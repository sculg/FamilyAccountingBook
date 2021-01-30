//
//  FABInquiryPeriodViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/25.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABInquiryPeriodViewController.h"
#import "FABRecordCommonViewController.h"

#import "FABTitleValueTableViewCell.h"
#import "FABMonthSummaryCell.h"
#import "FABAccountingButtonCell.h"
#import "FABTableViewSectionView.h"
#import "FABAccountingSummaryEntity.h"

#import "FABInquiryPeriodEntity.h"

static NSString *InquiryPeriodViewID = @"InquiryPeriodView";

@interface FABInquiryPeriodViewController ()
@property (nonatomic, strong) FABInquiryPeriodEntity *myPeriodEntity;

@end

@implementation FABInquiryPeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"阶段收支详情";
    
    [self setUpCutomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"阶段查询"];
    [MobClick beginLogPageView:@"阶段查询"];

    [self setData];
    [self.tableView reloadData];
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"阶段查询"];
    [MobClick endLogPageView:@"阶段查询"];

}


- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[FABTableViewSectionView class] forHeaderFooterViewReuseIdentifier:InquiryPeriodViewID];
}

-(void)setData{
    _myPeriodEntity = [[FABInquiryPeriodEntity alloc] init];
    _myPeriodEntity.startDate = _startDate;
    _myPeriodEntity.endDate = _endDate;
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [_myPeriodEntity.incomeItems count];
            break;
        case 1:
            return [_myPeriodEntity.expenditureValueItems count];
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 2 && indexPath.row == 0) {
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
                [cell configCellWithTitle:_myPeriodEntity.incomeTitleItems[indexPath.row]
                                    image:_myPeriodEntity.incomeImageItems[indexPath.row]
                                   detail:[NSString stringWithFormat:@"%.2f",[_myPeriodEntity.incomeItems[indexPath.row] doubleValue]]];
                break;
            case 1:
                [cell configCellWithTitle:_myPeriodEntity.expenditureTitleItems[indexPath.row]
                                    image:_myPeriodEntity.expenditureImageItems[indexPath.row]
                                   detail:[NSString stringWithFormat:@"%.2f",[_myPeriodEntity.expenditureValueItems[indexPath.row] doubleValue]]];
                break;
            default:
                break;
        }
        return cell;
    }else{
//        if (indexPath.row == 0) {
//            FABMonthSummaryCell *cell = [FABMonthSummaryCell cellForTableView:tableView];
//            [cell setUpItemEntity:_myPeriodEntity];
//            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//            return cell;
//            
//        }else{
            FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
            [cell configButtonWithTitle:NSLocalizedString(@"All records",nil)];
            cell.btnPressedBlock = ^(){
                [self toRecordCommon];
            };
            
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
//        }
    }
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:InquiryPeriodViewID];
    switch (section) {
        case 0:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Income",nil) value:[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:_myPeriodEntity.incomeSum],kCashUnit]];
            break;
        case 1:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Expenditure",nil) value:[NSString stringWithFormat:@"%@%@ %@",NSLocalizedString(@"Sum",nil),[StringHelper numberDoubleFormatterValue:_myPeriodEntity.expenditureSum],kCashUnit]];
            break;
//        case 2:
//            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Overview",nil)];
//            break;
        default:
            break;
    }
    
    return sectionView;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    if (section == 2) {
        return 10;
    }
    return 30 ;
    
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        
        NSNumber *value = _myPeriodEntity.incomeItems[indexPath.row];
        NSString *title = _myPeriodEntity.incomeTitleItems[indexPath.row];
        if ([value doubleValue] == 0) {
            [ProgressHUD showError:NSLocalizedString(@"No data",nil)];
        }
        FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
        monthDetail.isIncome = YES;
        monthDetail.startDate = _startDate;
        monthDetail.endDate = _endDate;
        monthDetail.typeId  = [self incomeClassification:title];
        [self pushNormalViewController:monthDetail];
        
    }else if(indexPath.section == 1){
        NSNumber *value = _myPeriodEntity.expenditureValueItems[indexPath.row];
        NSString *title = _myPeriodEntity.expenditureTitleItems[indexPath.row];
        
        if ([value doubleValue] == 0) {
            [ProgressHUD showError:NSLocalizedString(@"No data",nil)];
        }
        FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
        monthDetail.isIncome = NO;
        monthDetail.startDate = _startDate;
        monthDetail.endDate = _endDate;
        monthDetail.typeId  = [self ependitureClassification:title];
        [self pushNormalViewController:monthDetail];
    }
}

-(void)toRecordCommon{
    FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
    monthDetail.startDate = _startDate;
    monthDetail.endDate = _endDate;
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
