//
//  FABRecordCommonViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABRecordCommonViewController.h"
#import "FABAccountingRecentRecordCell.h"
#import "FABAccountingRecentRecordEntity.h"
#import "FABAccountingIncomeViewController.h"
#import "FABAccountingExpenditureViewController.h"

static NSString *SectionViewID = @"RecordCommonView";

@interface FABRecordCommonViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *myRecordArray;

@end

@implementation FABRecordCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"All records",nil);
    [self setUpCutomView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"所有记录"];
    [MobClick beginLogPageView:@"所有记录"];


    [self setData];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"所有记录"];
    [MobClick endLogPageView:@"所有记录"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];

}

-(void)setData{
    
    NSString *inquiryPeriodSql = [NSString stringWithFormat:@"recordTime >= '%@ 00:00:00' and recordTime <= '%@ 23:59:59'",_startDate,_endDate];

    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSString *whereStr = nil;
    if (_startDate == nil && _monthId == nil) {
        whereStr = nil;
    }else if(_startDate == nil && _monthId != nil && _typeId == 100){
        whereStr = [NSString stringWithFormat:@"monthId = '%@'",_monthId];
    }else if (_startDate == nil && _isIncome){
        whereStr = [NSString stringWithFormat:@"monthId = '%@' and incomeClassificationType = %d",_monthId,(int)_typeId];
    }else if (_startDate == nil && !_isIncome){
        if (_payType >= 0) {
            whereStr = [NSString stringWithFormat:@"monthId = '%@' and payType = %d",_monthId,(int)_payType];
        }else if (_payTarget >= 0){
            whereStr = [NSString stringWithFormat:@"monthId = '%@' and expenditureObjectType = %d",_monthId,(int)_payTarget];
        }else{
        whereStr = [NSString stringWithFormat:@"monthId = '%@' and ependitureClassificationType = %d",_monthId,(int)_typeId];
        }
    }else if (_startDate != nil && _isIncome){
        whereStr = [NSString stringWithFormat:@"and incomeClassificationType = %d",(int)_typeId];
    }else if (_startDate != nil && _typeId == 100){
        whereStr = [NSString stringWithFormat:@""];
    }else{
        whereStr = [NSString stringWithFormat:@"and ependitureClassificationType = %d",(int)_typeId];
    }
    
    if (_endDate == nil || _endDate.length == 0) {
        inquiryPeriodSql = whereStr;
    }else{
        inquiryPeriodSql = [NSString stringWithFormat:@"recordTime >= '%@ 00:00:00' and recordTime <= '%@ 23:59:59' %@",_startDate,_endDate,whereStr];
    }
    self.myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:inquiryPeriodSql orderBy:@"recordTime desc" offset:0 count:300];
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _myRecordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (_myRecordArray.count == 1) {
        FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
        [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
//    }else{
//        if (indexPath.row == 0) {
//            FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
//            [cell setUpItemEntity:self.myRecordArray[indexPath.row] cellType:FABAccountingRecentRecordCellTypeFirst];
//            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else if (indexPath.row == _myRecordArray.count -1){
//            FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
//            [cell setUpItemEntity:self.myRecordArray[indexPath.row] cellType:FABAccountingRecentRecordCellTypeLast];
//            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else{
//            FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
//            [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
//            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionViewID];
    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionViewID];
    return sectionView;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABAccountingRecentRecordEntity *myEntity = self.myRecordArray[indexPath.row];
    if (myEntity.accountingType  == FABAccountingType_Income) {
        FABAccountingIncomeViewController *income = [[FABAccountingIncomeViewController alloc] init];
        income.isToChangeData = YES;
        income.myEntity = myEntity;
        [self pushNormalViewController:income];
    }else{
        FABAccountingExpenditureViewController *expenditure = [[FABAccountingExpenditureViewController alloc] init];
        expenditure.myEntity = myEntity;
        expenditure.isToChangeData = YES;
        [self pushNormalViewController:expenditure];
    }
    
}


@end
