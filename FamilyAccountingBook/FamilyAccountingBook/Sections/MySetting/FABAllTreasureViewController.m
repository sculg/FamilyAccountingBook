//
//  FABAllTreasureViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/5.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAllTreasureViewController.h"
#import "FABAcumulativeCell.h"
#import "FABAcumulativeEntity.h"
#import "FABAccountingSummaryEntity.h"
#import "FABAccountingRecentRecordEntity.h"
#import "FABPieChartTableViewCell.h"
#import "FABRouter.h"

static NSString *AllTreasureViewID = @"AllTreasureView";

static NSString *Router_JumpToAllTreasureVC = @"Router_JumpToAllTreasureVC";


@interface FABAllTreasureViewController ()

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) FABAcumulativeEntity *myEntity;


@end

@implementation FABAllTreasureViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Total Wealth",nil);
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"总财富"];
    [MobClick beginLogPageView:@"总财富"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"总财富"];
    [MobClick endLogPageView:@"总财富"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:nil orderBy:@"recordTime desc" offset:0 count:10000];
    double acumuIncome = 0;
    double acumuExpenditure = 0;
 
    self.myEntity.acumuTime = @"-- --";
    for (int i = 0; i < [myRecordArray count] ; i++) {
        FABAccountingRecentRecordEntity *entity = myRecordArray[i];
        if (i == [myRecordArray count] -1) {
            self.myEntity.acumuTime = entity.recordTime;
        }
        switch (entity.accountingType) {
            case FABAccountingType_Income:
                acumuIncome += [entity.recordMoney doubleValue];
                break;
            case FABAccountingType_Expenditure:
                acumuExpenditure += [entity.recordMoney doubleValue];
                break;
            default:
                break;
        }
    }
    self.myEntity.acumuIncome = @(acumuIncome);
    self.myEntity.acumuExpenditure =@(acumuExpenditure);
    self.myEntity.acumuCount = @([myRecordArray count]);
    self.myEntity.acumuCashSurplus =  @(acumuIncome - acumuExpenditure);
    
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    NSString *initialAsset = [myDefault objectForKey:@"InitialAssets"];
    self.myEntity.initialAssets = (initialAsset.length > 0) ? @([initialAsset doubleValue]): @(0.00);
    self.myEntity.totalAssets = @([self.myEntity.initialAssets doubleValue] + [self.myEntity.acumuCashSurplus doubleValue]);


}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else{
        return 280;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FABAcumulativeCell *cell = [FABAcumulativeCell cellForTableView:tableView];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        [cell setUpItemEntity:_myEntity];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }else{
        FABPieChartTableViewCell *cell = [FABPieChartTableViewCell cellForTableView:tableView];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;

        switch (indexPath.section) {
            case 1:
                [cell configCellWithTitle:[NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"Cumulative expenditures",nil),NSLocalizedString(@"Payment Type",nil)]
                                 sumValue:self.myEntity.acumuExpenditure
                                  itemArr:self.myEntity.expenditureTitleItems
                             itemValueArr:self.myEntity.acumuExpenditureValueItems];
                break;
            case 2:
                [cell configCellWithTitle:[NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"Accumulated income",nil),NSLocalizedString(@"Income Type",nil)]
                                 sumValue:self.myEntity.acumuIncome
                                  itemArr:self.myEntity.incomeTitleItems
                             itemValueArr:self.myEntity.acumuIncomeItems];
                break;
            case 3:
                [cell configCellWithTitle:[NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"Cumulative expenditures",nil),NSLocalizedString(@"Payment Method",nil)]
                                 sumValue:self.myEntity.acumuExpenditure
                                  itemArr:@[NSLocalizedString(@"Cash Pay",nil),NSLocalizedString(@"Union Pay",nil),NSLocalizedString(@"Wechat Pay",nil),NSLocalizedString(@"Ali Pay",nil)]
                             itemValueArr:self.myEntity.acumuAccountingPayTypeItems];
                break;
            case 4  :
                [cell configCellWithTitle:[NSString stringWithFormat:@"%@（%@）",NSLocalizedString(@"Cumulative expenditures",nil),NSLocalizedString(@"Expenditure Target",nil)]
                                 sumValue:self.myEntity.acumuExpenditure
                                  itemArr:@[NSLocalizedString(@"Family",nil),NSLocalizedString(@"Me",nil),NSLocalizedString(@"Spouse",nil),NSLocalizedString(@"Parents",nil),NSLocalizedString(@"Children",nil),NSLocalizedString(@"Other people",nil)]
                             itemValueArr:self.myEntity.acumuExpenditureObjectItems];
                break;
            default:
                break;
        }
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AllTreasureViewID];
    return sectionView;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(FABAcumulativeEntity *)myEntity{
    if (!_myEntity) {
        _myEntity = [[FABAcumulativeEntity alloc] init];
    }
    return _myEntity;
}

@end
