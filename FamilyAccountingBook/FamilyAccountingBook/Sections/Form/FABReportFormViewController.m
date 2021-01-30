//
//  FABReportFormViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABReportFormViewController.h"
#import "FABSegmentView.h"
#import "FABMonthReportFormViewController.h"
#import "FABDayReportFormViewController.h"
#import "FABTableSelectView.h"
#import "FABAccountingSummaryEntity.h"
#import "FABCalendarView.h"
#import "FABAccountingRecentRecordEntity.h"

#import "FABPieChartTableViewCell.h"
#import "FABRecordCommonViewController.h"

static const CGFloat kSegmentPercent = 0.5;

@interface FABReportFormViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) FABSegmentView *choiceView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray <FABBaseViewController *> *viewControllers;

@property (nonatomic, strong) NSString *curSelectedItem;

@property (nonatomic, strong) FABTableSelectView *tableSelectView;

@property (nonatomic, strong) FABDayReportFormViewController *dayReportVC;

@property (nonatomic, strong) FABMonthReportFormViewController *monthReportVC;

@property (nonatomic, strong) NSArray *tableSelectViewItems;

@property (nonatomic, assign) NSInteger selectedVCIndex;

@property (nonatomic, strong) FABCalendarView *calendarView;

@property (nonatomic, strong) NSDate *calendarSelectedDate;

@property (nonatomic, assign) BOOL isIncome;


@end

@implementation FABReportFormViewController

- (void)viewDidLoad {
    
    [self setupLayout];
    [self setupBinding];
    [self addBarButtonWithImage:[UIImage imageNamed:@"report_date"] isLeft:NO];
    
    if (self.curSelectedItem == nil) {
        self.monthReportVC.curSelectedItem = [NSString stringWithFormat:@"%@%@",[NSDate monthId],NSLocalizedString(@"Month",nil)];
    }
    if (self.calendarSelectedDate == nil) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        self.dayReportVC.curSelectedDate = [fmt stringFromDate:[NSDate date]];
        self.dayReportVC.dayEntity =[[FABDaySummaryEntity alloc] init];
        self.dayReportVC.dayEntity.selectedDate = self.dayReportVC.curSelectedDate;
    }
    
    [self setupViewControllers];
    [self setData];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"报表页面"];
    [MobClick beginLogPageView:@"报表页面"];

    if (self.curSelectedItem == nil) {
        self.curSelectedItem = [NSString stringWithFormat:@"%@%@",[NSDate monthId],NSLocalizedString(@"Month",nil)];
    }
    [self setData];
}

-(void)viewDidDisappear:(BOOL)animated{
    [JANALYTICSService stopLogPageView:@"报表页面"];
    [MobClick endLogPageView:@"报表页面"];

    [self.tableSelectView hideView];
    _tableSelectView = nil;
    _calendarView = nil;
}

- (void)rightBarButtonPressed:(id)sender
{
    
    if (_selectedVCIndex == 1) {
        if (!_tableSelectView) {
            @weakify(self);
            _tableSelectView =  [FABTableSelectView initTableSelectViewWithTopOffset:0
                                                                          leftOffset:kScreenWidth - 98
                                                                tableSelectViewItems:self.monthReportVC.tableSelectViewItems
                                                                     curSelectedItem:self.monthReportVC.curSelectedItem
                                                                      selectedResult:^(NSString *selectValue) {
                                                                          @strongify(self);
                                                                          if (![selectValue isEqualToString:@"0"]) {
                                                                              self.monthReportVC.curSelectedItem = selectValue;
                                                                          }
                                                                          [self setData];
                                                                          _tableSelectView = nil;
                                                                      }];
            [self.view addSubview:_tableSelectView];
        }else{
            _tableSelectView.hidden = YES;
            _tableSelectView = nil;
        }

    }else if (_selectedVCIndex == 0){

        if (!_calendarView) {
        _calendarView = [FABCalendarView initCalendarViewWithSelectedDate:self.calendarSelectedDate
                                                           selectedResult:^(NSDate *selectDate) {
                                                               ;
                                                               _calendarSelectedDate = selectDate;
                                                               NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                                                               fmt.dateFormat = @"yyyy-MM-dd";
                                                               self.dayReportVC.curSelectedDate = [fmt stringFromDate:selectDate];
                                                               self.dayReportVC.dayEntity =[[FABDaySummaryEntity alloc] init];
                                                               self.dayReportVC.dayEntity.selectedDate = self.dayReportVC.curSelectedDate;
                                                               [self setDayLineChartData];
                                                               [self.dayReportVC.tableView reloadData];
                                                               _calendarView = nil;
                                                           }];
        [self.view addSubview:_calendarView];
        }else{
            _calendarView.hidden = YES;
            _calendarView = nil;
        }
    }
}

- (void)setData{

    
    self.isIncome = NO;

    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:100];
    
    NSString *monthStr = [self.monthReportVC.curSelectedItem substringWithRange:NSMakeRange(0,7)];
    NSArray *myMonthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":monthStr} orderBy:@"accountingId asc" offset:0 count:20];
    if (myMonthArray) {
        self.monthReportVC.myMonthEntity = myMonthArray[0];
    }
    NSMutableArray *income = [[NSMutableArray alloc] init];
    NSMutableArray *expenditure = [[NSMutableArray alloc] init];
    NSMutableArray *month = [[NSMutableArray alloc] init];
    NSMutableArray *tableSelectItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < [myRecordArray count]; i++) {
        FABAccountingSummaryEntity *entity = myRecordArray[i];
        [income addObject:entity.income];
        [expenditure addObject:entity.expenditure];
        int monthId = [[entity.accountingId substringWithRange:NSMakeRange(5,2)] intValue];
        [month addObject:[NSString stringWithFormat:@"%d%@",monthId,NSLocalizedString(@"Month",nil)]];
        [tableSelectItems addObject:[NSString stringWithFormat:@"%@%@",entity.accountingId,NSLocalizedString(@"Month",nil)]];
    }
    
    self.monthReportVC.incomeItems = [[income reverseObjectEnumerator] allObjects];
    self.monthReportVC.expenditureItems = [[expenditure reverseObjectEnumerator] allObjects];
    self.monthReportVC.monthItems = [[month reverseObjectEnumerator] allObjects];
    self.monthReportVC.tableSelectViewItems = tableSelectItems;
    
    [self.monthReportVC.tableView reloadData];
    
    [self setDayLineChartData];
    
}
-(void)setDayLineChartData{
    
    NSMutableArray *incomeOfDays = [[NSMutableArray alloc] init];
    NSMutableArray *expenditureOfDays = [[NSMutableArray alloc] init];
    NSMutableArray *days = [[NSMutableArray alloc] init];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *todayDate = nil;
    if(!self.calendarSelectedDate){
        todayDate = [fmt stringFromDate:[NSDate date]];
    }else{
        todayDate = [fmt stringFromDate:self.calendarSelectedDate];
    }
    int dayNum = [[todayDate substringWithRange:NSMakeRange(8,2)] intValue];
    int startDay = dayNum > 16 ? dayNum - 16: 1;
//    int startDay = 1;
    for (int  i = startDay; i <= dayNum ; i++) {
        NSString *dayStr = i < 10 ? [NSString stringWithFormat:@"0%d",i]: [NSString stringWithFormat:@"%d",i];
        NSString *searchDate = [NSString stringWithFormat:@"%@%@",[todayDate substringWithRange:NSMakeRange(0,8)],dayStr];
        LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
        NSArray *myDayArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"recordTime":searchDate} orderBy:@"recordId desc" offset:0 count:100];

        double incomeSum = 0, ependitureSum = 0;
        for (int j = 0 ; j < [myDayArray count]; j++ ) {
            FABAccountingRecentRecordEntity *entity = myDayArray[j];
            if (entity.accountingType == FABAccountingType_Income) {
                incomeSum += [entity.recordMoney doubleValue];
            }else{
                ependitureSum += [entity.recordMoney doubleValue];
            }
        }
        [incomeOfDays addObject:@(incomeSum)];
        [expenditureOfDays addObject:@(ependitureSum)];
        [days addObject:[NSString stringWithFormat:@"%@-%d",[todayDate substringWithRange:NSMakeRange(5,2)],i]];
    }
    self.dayReportVC.daysDesc = days;
    self.dayReportVC.incomeOfDays = incomeOfDays;
    self.dayReportVC.expenditureOfDays = expenditureOfDays;
    
    [self.dayReportVC.tableView reloadData];

}


#pragma mark - Private Methods

- (void)setupBinding
{
    //类型变化
    @weakify(self);
    [RACObserve(self, selectedVCIndex) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        NSInteger section = x.integerValue;
        if (section == 0) {
            [self.choiceView setSelectedIndex:0 animated:YES];
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth * 0, 0.0f) animated:YES];
        }
        
        if (section == 1) {
            [self.choiceView setSelectedIndex:1 animated:YES];
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth * section, 0.0f) animated:YES];
        }
    }];
    
    [[RACObserve(self.monthReportVC, pieEntry) ignore:nil] subscribeNext:^(id x) {
        [self toRecordList];
    }];
}

-(void)toRecordList {
    FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
    monthDetail.monthId = [self.monthReportVC.curSelectedItem substringWithRange:NSMakeRange(0,7)];
    if ([self ependitureClassification:self.monthReportVC.pieEntry.label] >= 0) {
        monthDetail.typeId  = [self ependitureClassification:self.monthReportVC.pieEntry.label];
        monthDetail.payTarget = -1;
        monthDetail.payType = -1;
    }else if([self incomeClassification:self.monthReportVC.pieEntry.label] >= 0){
        monthDetail.typeId  = [self incomeClassification:self.monthReportVC.pieEntry.label];
        monthDetail.payTarget = -1;
        monthDetail.payType = -1;
    }else if ([self ependitureTarget:self.monthReportVC.pieEntry.label] >= 0) {
        monthDetail.payTarget = [self ependitureTarget:self.monthReportVC.pieEntry.label];
        monthDetail.payType = -1;
    }else if ([self ependitureType:self.monthReportVC.pieEntry.label] >= 0) {
        monthDetail.payType = [self ependitureType:self.monthReportVC.pieEntry.label];
        monthDetail.payTarget = -1;
    }
    monthDetail.isIncome = self.isIncome;
    [self pushNormalViewController:monthDetail];
}


- (void)setupLayout
{
    self.navigationItem.titleView = self.choiceView;
    [self.view addSubview:self.scrollView];
}

- (void)setupViewControllers
{
    for (int section = 0; section < 2; section ++) {
        FABBaseViewController *vc = nil;
        
        if (section == 0) {
            vc = _dayReportVC;
        }else if(section == 1){
            vc = _monthReportVC;
        }
        if (vc) {
            CGRect rect = vc.view.frame;
            rect.origin.x += self.scrollView.frame.size.width * section;
            rect.size.height -= 64;
            vc.view.frame = rect;
            [self.viewControllers addObject:vc];
            [self.scrollView addSubview:vc.view];
        }
    }
}



-(NSInteger)ependitureClassification:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Clothes",nil)
         ]) {
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Foods",nil)]) {
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Traffic",nil)]) {
        return 3;
    }else if ([str isEqualToString:NSLocalizedString(@"Entertainment",nil)]) {
        return 4;
    }else if ([str isEqualToString:NSLocalizedString(@"Other expenses",nil)]) {
        return 5;
    }else if ([str isEqualToString:NSLocalizedString(@"Medical Care",nil)]) {
        return 6;
    }else if ([str isEqualToString:NSLocalizedString(@"Necessary",nil)]) {
        return 7;
    }else if ([str isEqualToString:NSLocalizedString(@"Cosmetology",nil)]) {
        return 8;
    }else if ([str isEqualToString:NSLocalizedString(@"Social",nil)]) {
        return 9;
    }else if ([str isEqualToString:NSLocalizedString(@"Education",nil)]) {
        return 10;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return 11;
    }else if ([str isEqualToString:NSLocalizedString(@"Donate",nil)]) {
        return 12;
    }else{
        return -1;
    }
}

-(NSInteger)ependitureTarget:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Family",nil)
         ]) {
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Me",nil)]) {
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Spouse",nil)]) {
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Parents",nil)]) {
        return 3;
    }else if ([str isEqualToString:NSLocalizedString(@"Children",nil)]) {
        return 4;
    }else if ([str isEqualToString:NSLocalizedString(@"Other people",nil)]) {
        return 5;
    }else{
        return -1;
    }
}

-(NSInteger)ependitureType:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Cash Pay",nil)
         ]) {
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Union Pay",nil)]) {
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Wechat Pay",nil)]) {
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Ali Pay",nil)]) {
        return 3;
    }else{
        return -1;
    }
}

-(NSInteger)incomeClassification:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Salary",nil)]) {
        self.isIncome = YES;
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Bonus",nil)]) {
        self.isIncome = YES;
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Financing Income",nil)]) {
        self.isIncome = YES;
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Other income",nil)]) {
        self.isIncome = YES;
        return 3;
    }else if ([str isEqualToString:NSLocalizedString(@"Part-time Income",nil)]) {
        self.isIncome = YES;
        return 4;
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        self.isIncome = YES;
        return 5;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        self.isIncome = YES;
        return 6;
    }else if ([str isEqualToString:NSLocalizedString(@"Red Packet",nil)]) {
        self.isIncome = YES;
        return 7;
    }else{
        return -1;
    }
}



#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    self.selectedVCIndex = page;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.choiceView setBottomLineOriginX:scrollView.contentOffset.x / 2 * kSegmentPercent];
}







#pragma mark - Property

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight - 64)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        [_scrollView setContentOffset:CGPointMake(kScreenWidth * self.selectedVCIndex, 0.0f)  animated:NO];
    }
    return _scrollView;
}

- (FABSegmentView *)choiceView
{
    if (!_choiceView) {
        CGFloat leftPercent = (1 - kSegmentPercent)/ 2.0;
        CGRect rect = CGRectMake(kScreenWidth * leftPercent, 0.0f, kScreenWidth * kSegmentPercent, 44);
        _choiceView = [[FABSegmentView alloc] initWithFrame:rect
                                                     titles:@[NSLocalizedString(@"Daily report",nil),NSLocalizedString(@"Monthly report",nil)]
                                                    selectedIndex:self.selectedVCIndex];
        
        @weakify(self);
        _choiceView.horizonLineView.backgroundColor = kSplitLineColor;
        _choiceView.backgroundColor = [UIColor clearColor];
        _choiceView.selectedBlock = ^(NSInteger index) {
            @strongify(self);
            self.selectedVCIndex = index;
            [self.scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0.0f) animated:YES];
            
            if(index == 0){
                self.tableSelectView.hidden = YES;
                self.tableSelectView = nil;
            }
            if (index == 1) {
                self.calendarView.hidden = YES;
                self.calendarView = nil;
            }
        };
    }
    return _choiceView;
}

- (NSMutableArray <FABBaseViewController *> *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

- (FABDayReportFormViewController *)dayReportVC{
    if (!_dayReportVC) {
        _dayReportVC = [[FABDayReportFormViewController alloc] init];
    }
    return _dayReportVC;
}

- (FABMonthReportFormViewController *)monthReportVC{
    if (!_monthReportVC) {
        _monthReportVC = [[FABMonthReportFormViewController alloc] init];
    }
    return _monthReportVC;
}



@end
