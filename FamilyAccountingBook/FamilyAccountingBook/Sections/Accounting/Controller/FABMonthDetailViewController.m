//
//  FABMonthDetailViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABMonthDetailViewController.h"
#import "FABRecordCommonViewController.h"

#import "FABTitleValueTableViewCell.h"
#import "FABMonthSummaryCell.h"
#import "FABAccountingButtonCell.h"
#import "FABTableViewSectionView.h"
#import "FABAccountingSummaryEntity.h"



static NSString *MonthDetailSectionViewID = @"FABAccountingViewHeaderView";

@interface FABMonthDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) FABAccountingSummaryEntity *myMonthEntity;


@end

@implementation FABMonthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Month Details",nil);
    
    [self setUpCutomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"本月详情"];
    [MobClick beginLogPageView:@"本月详情"];

    [self setData];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"本月详情"];
    [MobClick endLogPageView:@"本月详情"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[FABTableViewSectionView class] forHeaderFooterViewReuseIdentifier:MonthDetailSectionViewID];
}

-(void)setData{
    
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":_monthId} orderBy:@"accountingId desc" offset:0 count:1000];
    if ([monthArray count] != 0) {
        self.myMonthEntity = monthArray[0];
    }
    else{
        self.myMonthEntity.accountingId = _monthId;
        self.myMonthEntity.incomeBudget = @(20000.0);
        self.myMonthEntity.income = @(0.0);
        self.myMonthEntity.expenditure = @(0.0);
        self.myMonthEntity.expenditureBudget = @(4300.0);
        self.myMonthEntity.budgetBalance = @([self.myMonthEntity.expenditureBudget doubleValue]- [self.myMonthEntity.expenditure doubleValue]);
        self.myMonthEntity.cashSurplus = @(0.0);
    }
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [_myMonthEntity.incomeItems count];
            break;
        case 1:
            return [_myMonthEntity.expenditureValueItems count];
            break;
        case 2:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 2 && indexPath.row == 0) {
        return 146;
    }else if(indexPath.section == 2 && indexPath.row == 1) {
        return 60;
    }{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:18];
        switch (indexPath.section) {
            case 0:
                [cell configCellWithTitle:_myMonthEntity.incomeTitleItems[indexPath.row]
                                    image:_myMonthEntity.incomeImageItems[indexPath.row]
                                   detail:[NSString stringWithFormat:@"%.2f",[_myMonthEntity.incomeItems[indexPath.row] doubleValue]]];
                break;
            case 1:
                [cell configCellWithTitle:_myMonthEntity.expenditureTitleItems[indexPath.row]
                                    image:_myMonthEntity.expenditureImageItems[indexPath.row]
                                   detail:[NSString stringWithFormat:@"%.2f",[_myMonthEntity.expenditureValueItems[indexPath.row] doubleValue]]];
                break;
            default:
                break;
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            FABMonthSummaryCell *cell = [FABMonthSummaryCell cellForTableView:tableView];
            [cell setUpItemEntity:_myMonthEntity];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
            [cell configButtonWithTitle:NSLocalizedString(@"All records",nil)];
            cell.btnPressedBlock = ^(){
                [self toRecordCommon];
            };
            
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MonthDetailSectionViewID];
    switch (section) {
        case 0:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Income",nil) value:[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:[_myMonthEntity.income doubleValue]],kCashUnit]];
            break;
        case 1:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Expenditure",nil) value:[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:[_myMonthEntity.expenditure doubleValue]],kCashUnit]];
            break;
        case 2:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Overview",nil)];
            break;
        default:
            break;
    }
    
    return sectionView;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 30 ;
    
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        
        NSNumber *value = _myMonthEntity.incomeItems[indexPath.row];
        NSString *title = _myMonthEntity.incomeTitleItems[indexPath.row];
        if ([value doubleValue] == 0) {
            [ProgressHUD showError:NSLocalizedString(@"No data",nil)];
        }
        FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
        monthDetail.isIncome = YES;
        monthDetail.monthId = _monthId;
        monthDetail.typeId  = [self incomeClassification:title];
        [self pushNormalViewController:monthDetail];
        
    }else if(indexPath.section == 1){
        NSNumber *value = _myMonthEntity.expenditureValueItems[indexPath.row];
        NSString *title = _myMonthEntity.expenditureTitleItems[indexPath.row];
        
        if ([value doubleValue] == 0) {
            [ProgressHUD showError:NSLocalizedString(@"No data",nil)];
        }
        FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
        monthDetail.isIncome = NO;
        monthDetail.monthId = _monthId;
        monthDetail.typeId  = [self ependitureClassification:title];
        monthDetail.payType = -1;
        monthDetail.payTarget = -1;
        [self pushNormalViewController:monthDetail];
    }
}

-(void)toRecordCommon{
    FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
    monthDetail.monthId = _monthId;
    monthDetail.typeId  = 100;
    [self pushNormalViewController:monthDetail];
}


-(NSInteger)incomeClassification:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Salary",nil)]) {
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Bonus",nil)]) {
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Financing Income",nil)]) {
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Other income",nil)]) {
        return 3;
    }else if ([str isEqualToString:NSLocalizedString(@"Part-time Income",nil)]) {
        return 4;
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return 5;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return 6;
    }else{
        return 7;
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
    }else{
        return 12;
    }
}


@end
