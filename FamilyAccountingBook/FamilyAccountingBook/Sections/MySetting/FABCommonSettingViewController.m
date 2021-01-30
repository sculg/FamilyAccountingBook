//
//  FABCommonSettingViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/2.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABCommonSettingViewController.h"
#import "FABTitleValueTableViewCell.h"

#import "FABBudgetSettingViewController.h"
#import "FABAccountingRecentRecordEntity.h"
#import "FABAccountingIncomeViewController.h"
#import "FABAccountingExpenditureViewController.h"
#import "FABAdditionalViewController.h"
#import "FABCurrencyUnitViewController.h"
#import "FABTotalAssetsViewController.h"
//#import "FABAppDelegate.h"

static NSString *CommonSettingViewID = @"CommonSettingView";


@interface FABCommonSettingViewController ()

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) FABAccountingRecentRecordEntity *myEntity;


@end

@implementation FABCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"General Settings",nil);
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"通用设置"];
    [MobClick beginLogPageView:@"通用设置"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"通用设置"];
    [MobClick endLogPageView:@"通用设置"];

}
- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    //    self.imageArr = @[@"mysetting_item_cash.png",@"mysetting_item_safe.png",@"mysetting_item_data.png",@"mysetting_item_clean.png",@"mysetting_item_help.png",@"mysetting_item_about.png"];
    self.titleArr = @[NSLocalizedString(@"Budget Settings",nil),NSLocalizedString(@"Income Template",nil),NSLocalizedString(@"Expenditure Template",nil),NSLocalizedString(@"Income Type Settings",nil),NSLocalizedString(@"Payment Type Settings",nil),NSLocalizedString(@"Currency Unit",nil),NSLocalizedString(@"Initial Assets",nil)];
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
        default:
            return 0;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    
    if (indexPath.section == 0) {
        [cell configCellWithTitle:_titleArr[indexPath.row] titleLeftOffset:10];
    }else if (indexPath.section == 1){
        [cell configCellWithTitle:_titleArr[indexPath.row + 1] titleLeftOffset:10];
    }else if (indexPath.section == 2){
        [cell configCellWithTitle:_titleArr[indexPath.row + 3] titleLeftOffset:10];
    }else{
        [cell configCellWithTitle:_titleArr[indexPath.row + 5] titleLeftOffset:10];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CommonSettingViewID];
    return sectionView;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self tobudgetSetting];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FABAccountingIncomeViewController *income = [[FABAccountingIncomeViewController alloc] init];
            income.isToSetTemplate = YES;
            [self pushNormalViewController:income];
        }else if (indexPath.row == 1){
            FABAccountingExpenditureViewController *expenditure = [[FABAccountingExpenditureViewController alloc] init];
            expenditure.isToSetTemplate = YES;
            [self pushNormalViewController:expenditure];
        }
    }else if (indexPath.section == 2) {
        FABAdditionalViewController *additional = [[FABAdditionalViewController alloc] init];
        switch (indexPath.row) {
            case 0:
                additional.additionalType = FABAdditionalType_IncomeClassification;
                break;
            case 1:
                additional.additionalType = FABAdditionalType_ExpenditureClassification;
                break;
            case 2:
                additional.additionalType = FABAdditionalType_ExpenditureObjectType;
                break;
            default:
                break;
        }
        [self pushNormalViewController:additional];
    }else if (indexPath.section == 3){
        if(indexPath.row == 0){
        FABCurrencyUnitViewController *currencyUnit= [[FABCurrencyUnitViewController alloc] init];
        [self pushNormalViewController:currencyUnit];
        }else{
            FABTotalAssetsViewController *totalAssets= [[FABTotalAssetsViewController alloc] init];
            [self pushNormalViewController:totalAssets];
        }
    }
}



- (void)tobudgetSetting
{
    
    FABBudgetSettingViewController *budgetSetting = [[FABBudgetSettingViewController alloc] init];
    [self pushNormalViewController:budgetSetting];
    
}

//- (void)toCommonSetting
//{
//    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate skipToTabBar];
//    
//}



@end
