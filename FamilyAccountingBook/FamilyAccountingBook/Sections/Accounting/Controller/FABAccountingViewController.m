//
//  FABAccountingViewController.m
//  FinancialHousekeeper
//
//  Created by lg on 2017/6/2.
//  Copyright © 2017年 financialhousekeeper. All rights reserved.
//

#import "FABAccountingViewController.h"
#import "FABMonthDetailViewController.h"
#import "FABMonthHistoryViewController.h"
#import "FABAccountingNowViewController.h"
#import "FABAccountingIncomeViewController.h"
#import "FABAccountingExpenditureViewController.h"
#import "FABRecordCommonViewController.h"
#import "FABBudgetSettingViewController.h"

#import "FABAccountingSummaryCell.h"
#import "FABAccountingButtonCell.h"
#import "FABTableViewSectionView.h"
#import "FABAccountingRecentRecordCell.h"

#import "FABAccountingSummaryEntity.h"
#import "FABAccountingRecentRecordEntity.h"
#import "FABNavigationController.h"
#import "FABGestureMainViewController.h"

static NSString *SectionViewID = @"FABAccountingViewHeaderView";


@interface FABAccountingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) NSArray *myRecordArray;
@property (nonatomic, strong) FABAccountingSummaryEntity *myMonthEntity;

@end

@implementation FABAccountingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Account",nil);
    [self addBarButtonWithImage:[UIImage imageNamed:@"record_history"] isLeft:NO];
    [self createMonthRecord];
    [self setUpCutomView];
    [self setData];
    
    //    [FABGestureMainViewController showMainGestureDefinitely:YES type:FABGestureMangerViewType_UnLock];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"记账首页"];
    [MobClick beginLogPageView:@"记账首页"];
    [self setData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"记账首页"];
    [MobClick endLogPageView:@"记账首页"];
}
/* 先查询是否设置过本月预算，没有则引导去设置 */
-(void)createMonthRecord{
    
    LKDBHelper* summaryEntityHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    FABAccountingSummaryEntity *myEntity = [[FABAccountingSummaryEntity alloc] init];
    NSArray *monthArray = [summaryEntityHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":[NSDate monthId]} orderBy:@"accountingId desc" offset:0 count:1000];
    if (monthArray.count == 1) {
        myEntity = monthArray[0];
        if ([myEntity.incomeBudget doubleValue] == 0 && [myEntity.expenditureBudget doubleValue] == 0) {
            [self showAlertView];
        }
    }
}


-(void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil) message:NSLocalizedString(@"set it now？",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Remind me later",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Set immediately",nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        
        NSLog(@"点击了确定按钮");
        [self  tobudgetSetting];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}




- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.tableView registerClass:[FABTableViewSectionView class] forHeaderFooterViewReuseIdentifier:SectionViewID];
    //    if (@available(iOS 11.0, *)) {
    //        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //            make.left.right.bottom.equalTo(@0);
    //            make.top.equalTo(@(kStatusBarHeight));
    //        }];
    //    }
    
}

-(void)setData{
    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    self.myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:nil orderBy:@"recordTime desc" offset:0 count:50];
    
    
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    
    NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    
    if ([monthArray count] > 0) {
        self.myMonthEntity = monthArray[0];
    }
    [self.tableView reloadData];
    
}


- (void)rightBarButtonPressed:(id)sender
{
    FABMonthHistoryViewController *monthDetail = [[FABMonthHistoryViewController alloc] init];
    [self pushNormalViewController:monthDetail];
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else{
        return _myRecordArray.count <= kHomePageCommonRecordItemsNumber ? _myRecordArray.count : kHomePageCommonRecordItemsNumber + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }else{
            return 60;
        }
    }else{
        if (indexPath.row == kHomePageCommonRecordItemsNumber)
        {
            return 50;
        }
        return 60;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            FABAccountingSummaryCell *cell = [FABAccountingSummaryCell cellForTableView:tableView];
            [self autoDrawCellLineWithCell:cell indexPath:indexPath];
            [cell setUpItemEntity:self.myMonthEntity];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
            [cell configButtonWithTitle:NSLocalizedString(@"Add A Record",nil)
                             titleColor:kWhiteColor
                                bgColor:kPieYellowColor
                              topOffset:6];
            cell.btnPressedBlock = ^(){
                [self toAccountingNow];
            };
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else{
        
        if (indexPath.row == kHomePageCommonRecordItemsNumber) {
            FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
            [cell configButtonWithTitle:@"点击查看更多记录"
                             titleColor:kTitleTextColor
                                bgColor:kWhiteColor
                              topOffset:2];
            cell.btnPressedBlock = ^(){
                [self toRecordCommon];
            };
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
//            if ([self.myRecordArray count] == 1) {
                FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
                return cell;
//            }
//            else {
//                if (indexPath.row == 0) {
//                    FABAccountingRecentRecordFirstCell *cell = [FABAccountingRecentRecordFirstCell cellForTableView:tableView];
//                    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//                    [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
//                    return cell;
//                }else{
//                    FABAccountingRecentRecordCell *cell = [FABAccountingRecentRecordCell cellForTableView:tableView];
//                    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
//                    [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
//                    return cell;
//                }
//            }
        }
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionViewID];
        [sectionView configHeadViewWithTitle:NSLocalizedString(@"Recent record",nil) titleLeftOffset:10.0];
        return sectionView;
    }
    return nil;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    if (section == 1) {
        return 25 ;
    }else{
        return 0;
    }
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        FABMonthDetailViewController *monthDetail = [[FABMonthDetailViewController alloc] init];
        monthDetail.monthId = self.myMonthEntity.accountingId;
        [self pushNormalViewController:monthDetail];
        
    }else if (indexPath.section == 1 && indexPath.row != kHomePageCommonRecordItemsNumber){
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
}
-(void)toRecordCommon{
    FABRecordCommonViewController *monthDetail = [[FABRecordCommonViewController alloc] init];
    monthDetail.monthId = nil;
    [self pushNormalViewController:monthDetail];
}



- (void)toAccountingNow
{
    
    FABAccountingNowViewController *accountingNow = [[FABAccountingNowViewController alloc] init];
    [self pushNormalViewController:accountingNow];
    
}

- (void)tobudgetSetting
{
    
    FABBudgetSettingViewController *budgetSetting = [[FABBudgetSettingViewController alloc] init];
    [self pushNormalViewController:budgetSetting];
    
}


@end
