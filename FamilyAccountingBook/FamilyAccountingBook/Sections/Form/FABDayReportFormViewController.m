//
//  FABDayReportFormViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABDayReportFormViewController.h"
#import "FamilyAccountingBook-Bridging-Header.h"
#import "FABPieChartTableViewCell.h"
#import "FABLineChartTableViewCell.h"
#import "FABTableSelectView.h"
#import "FABRecordCommonViewController.h"
#import "FABAccountingRecentRecordEntity.h"
#import "FABAccountingRecentRecordCell.h"

static NSString *ReportFormViewID = @"DayReportFormView";


@interface FABDayReportFormViewController ()<ChartViewDelegate>

@property (nonatomic, strong) NSArray *incomeArr;
@property (nonatomic, strong) NSArray *expenditureArr;

@property (nonatomic, strong) NSArray *sectionTitleArr;

@property (nonatomic, strong) NSArray *sectionValueArr;

@end

@implementation FABDayReportFormViewController

- (void)viewDidLoad {
    
    self.title = NSLocalizedString(@"Report",nil);
    [super viewDidLoad];
    [self addBarButtonWithTitle:NSLocalizedString(@"History report",nil) isLeft:NO];
    [self setUpCutomView];
    [self setupConstraint];
    [self setBinding];
}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[FABTableViewSectionView class] forHeaderFooterViewReuseIdentifier:ReportFormViewID];
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

-(void)setBinding{
    [[RACObserve(self, curSelectedDate) ignore:nil] subscribeNext:^(id x) {
        self.dayEntity.selectedDate = self.curSelectedDate;
        [self setData];
    }];

}

- (void)setupConstraint
{
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-49);
    }];
}

- (void)setData{
    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myDayArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"recordTime":self.curSelectedDate} orderBy:@"recordId desc" offset:0 count:100];
    
    NSMutableArray *income = [[NSMutableArray alloc] init];
    NSMutableArray *expenditure = [[NSMutableArray alloc] init];
    NSMutableArray *sectionTitle = [[NSMutableArray alloc] init];
    NSMutableArray *sectionValue = [[NSMutableArray alloc] init];

    for (int i = 0; i < [myDayArray count]; i++ ) {
        FABAccountingRecentRecordEntity *entity = myDayArray[i];
        if (entity.accountingType == FABAccountingType_Income){
            [income addObject:entity];
        }else{
            [expenditure addObject:entity];
        }
    }
    self.incomeArr = income;
    self.expenditureArr = expenditure;
    if ([income count] > 0) {
        [sectionTitle addObject:[NSString stringWithFormat:@"%@ %@",self.curSelectedDate,NSLocalizedString(@"day income",nil)]];
        [sectionValue addObject:[NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:self.dayEntity.incomeSum],kCashUnit]];
    }else{
        [sectionTitle addObject:@""];
        [sectionValue addObject:@""];
    }
    if ([expenditure count]>0) {
        [sectionTitle addObject:[NSString stringWithFormat:@"%@ %@",self.curSelectedDate,NSLocalizedString(@"day expenditure",nil)]];
        [sectionValue addObject:[NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:self.dayEntity.expenditureSum],kCashUnit]];
    }else{
        [sectionTitle addObject:@""];
        [sectionValue addObject:@""];
    }
    if([expenditure count] == 0 && [income count] == 0){
        [sectionTitle addObject:[NSString stringWithFormat:@"%@ %@",self.curSelectedDate,NSLocalizedString(@"no record",nil)]];
        [sectionValue addObject:@""];

    }
    self.sectionTitleArr = sectionTitle;
    self.sectionValueArr = sectionValue;

    [self.tableView reloadData];

}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return [self.sectionTitleArr count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return [_incomeArr count] > 0 ? [_incomeArr count] : 0;
    }else{
        return [_expenditureArr count] > 0 ? [_expenditureArr count] : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPAD) {
        if (indexPath.section == 0) {
            return 292;
        }
        return 60;
    }else{
        if (indexPath.section == 0) {
            return 268;
        }
        return 60;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABPieChartTableViewCell *cell = [FABPieChartTableViewCell cellForTableView:tableView];
    FABLineChartTableViewCell *cell1 = [FABLineChartTableViewCell cellForTableView:tableView];
    cell1.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell.myChartView.delegate = self;
    cell1.myChartView.delegate = self;
    if (indexPath.section == 0) {
        [cell1 configCellWithTitle:NSLocalizedString(@"DayChanges",nil)
                         incomeArr:self.incomeOfDays
                    expenditureArr:self.expenditureOfDays
                          monthArr:self.daysDesc];
        return cell1;
        
    }else if(indexPath.section == 1){
        FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
        [cell setUpItemEntity:self.incomeArr[indexPath.row]];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
        [cell setUpItemEntity:self.expenditureArr[indexPath.row]];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReportFormViewID];
    NSString *value = self.sectionValueArr[section - 1];
    if (value.length == 0) {
        [sectionView configHeadViewWithTitle:self.sectionTitleArr[section - 1] titleFont:kFontSize(16) value:self.sectionValueArr[section - 1] isTitleCenter:YES];
    }else{
    [sectionView configHeadViewWithTitle:self.sectionTitleArr[section - 1] titleFont:kFontSize(16) value:self.sectionValueArr[section - 1] isTitleCenter:NO];
    }
    return sectionView;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    if(section == 0){
      return 0;
    }else{
        return 30;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <ChartViewDelegate>

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight{
    
    PieChartDataEntry *pieEntry = (PieChartDataEntry *)entry;
    NSLog(@"pieEntry.label:%f",pieEntry.x);
    
    NSString *firstDay = _daysDesc[0];
    NSString *day = [firstDay componentsSeparatedByString:@"-"][1]; //从字符A中分隔成2个元素的数组

    int dayNum = [day intValue] + (int)pieEntry.x;
    
    NSString *dayStr = dayNum < 10 ? [NSString stringWithFormat:@"0%d",dayNum]: [NSString stringWithFormat:@"%d",dayNum];
    self.curSelectedDate = [NSString stringWithFormat:@"%@%@",[self.curSelectedDate substringWithRange:NSMakeRange(0,8)],dayStr];
}



@end
