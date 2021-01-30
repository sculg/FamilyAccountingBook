//
//  FABMonthReportFormViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABMonthReportFormViewController.h"
#import "FamilyAccountingBook-Bridging-Header.h"
#import "FABLineChartTableViewCell.h"
#import "FABTableSelectView.h"
#import "FABRecordCommonViewController.h"
#import "FABAppUtils.h"

static NSString *ReportFormViewID = @"ReportFormView";



@interface FABMonthReportFormViewController ()<ChartViewDelegate>

@end

@implementation FABMonthReportFormViewController

- (void)viewDidLoad {
    
    self.title = NSLocalizedString(@"Report",nil);
    [super viewDidLoad];
    [self addBarButtonWithTitle:NSLocalizedString(@"History report",nil) isLeft:NO];
    [self setUpCutomView];
    [self setupConstraint];
}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.allowsSelection = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
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

//- (void)setData{
//    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
//    NSArray *myRecordArray = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:100];
//    
//    NSString *monthStr = [self.curSelectedItem substringWithRange:NSMakeRange(0,7)];
//    NSArray *myMonthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":monthStr} orderBy:@"accountingId asc" offset:0 count:20];
//    if (myMonthArray) {
//        self.myMonthEntity = myMonthArray[0];
//    }
//    NSMutableArray *income = [[NSMutableArray alloc] init];
//    NSMutableArray *expenditure = [[NSMutableArray alloc] init];
//    NSMutableArray *month = [[NSMutableArray alloc] init];
//    NSMutableArray *tableSelectItems = [[NSMutableArray alloc] init];
//    for (int i = 0; i < [myRecordArray count]; i++) {
//        FABAccountingSummaryEntity *entity = myRecordArray[i];
//        [income addObject:entity.income];
//        [expenditure addObject:entity.expenditure];
//        int monthId = [[entity.accountingId substringWithRange:NSMakeRange(5,2)] intValue];
//        [month addObject:[NSString stringWithFormat:@"%d%@",monthId,NSLocalizedString(@"Month",nil)]];
//        [tableSelectItems addObject:[NSString stringWithFormat:@"%@%@",entity.accountingId,NSLocalizedString(@"Month",nil)]];
//    }
//    
//    self.incomeItems = [[income reverseObjectEnumerator] allObjects];
//    self.expenditureItems = [[expenditure reverseObjectEnumerator] allObjects];
//    self.monthItems = [[month reverseObjectEnumerator] allObjects];
//    self.tableSelectViewItems = tableSelectItems;
//    
//    [self.tableView reloadData];
//    
//}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPAD) {
        return 292;
    }else{
        return 268;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABPieChartTableViewCell *cell = [FABPieChartTableViewCell cellForTableView:tableView];
    FABLineChartTableViewCell *cell1 = [FABLineChartTableViewCell cellForTableView:tableView];
    cell1.selectionStyle  = UITableViewCellSelectionStyleNone;
//    cell1.myChartView.delegate = self;
    cell.myChartView.delegate = self;
    if (indexPath.section == 0) {
        [cell1 configCellWithTitle:NSLocalizedString(@"Changes",nil)
                         incomeArr:self.incomeItems
                    expenditureArr:self.expenditureItems
                          monthArr:self.monthItems];
        return cell1;
        
    }else if (indexPath.section == 1){
        [cell configCellWithTitle:[NSString stringWithFormat:@"%@ %@%@（%@）",self.myMonthEntity.accountingId,NSLocalizedString(@"Month",nil),NSLocalizedString(@"Income",nil),NSLocalizedString(@"Income Type",nil)]
                         sumValue:self.myMonthEntity.income
                          itemArr:self.myMonthEntity.incomeTitleItems
                     itemValueArr:self.myMonthEntity.incomeItems];
        return cell;
    }
    else if (indexPath.section == 2){
        [cell configCellWithTitle:[NSString stringWithFormat:@"%@ %@%@（%@）",self.myMonthEntity.accountingId,NSLocalizedString(@"Month",nil),NSLocalizedString(@"Expenditure",nil),NSLocalizedString(@"Payment Type",nil)]
                         sumValue:self.myMonthEntity.expenditure
                          itemArr:self.myMonthEntity.expenditureTitleItems
                     itemValueArr:self.myMonthEntity.expenditureValueItems];
        return cell;
    }else if (indexPath.section == 3){
        [cell configCellWithTitle:[NSString stringWithFormat:@"%@ %@%@（%@）",self.myMonthEntity.accountingId,NSLocalizedString(@"Month",nil),NSLocalizedString(@"Expenditure",nil),NSLocalizedString(@"Payment Method",nil)]
                         sumValue:self.myMonthEntity.expenditure
                          itemArr:@[NSLocalizedString(@"Cash Pay",nil),NSLocalizedString(@"Union Pay",nil),NSLocalizedString(@"Wechat Pay",nil),NSLocalizedString(@"Ali Pay",nil)]
                     itemValueArr:self.myMonthEntity.accountingPayTypeItems];
        return cell;
    }else{
        [cell configCellWithTitle:[NSString stringWithFormat:@"%@ %@%@（%@）",self.myMonthEntity.accountingId,NSLocalizedString(@"Month",nil),NSLocalizedString(@"Expenditure",nil),NSLocalizedString(@"Expenditure Target",nil)]
                         sumValue:self.myMonthEntity.expenditure
                          itemArr:@[NSLocalizedString(@"Family",nil),NSLocalizedString(@"Me",nil),NSLocalizedString(@"Spouse",nil),NSLocalizedString(@"Parents",nil),NSLocalizedString(@"Children",nil),NSLocalizedString(@"Other people",nil)]
                     itemValueArr:self.myMonthEntity.expenditureObjectItems];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 14;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReportFormViewID];
    return sectionView;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - <ChartViewDelegate>

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight{
    
    self.pieEntry = (PieChartDataEntry *)entry;
    
}


@end
