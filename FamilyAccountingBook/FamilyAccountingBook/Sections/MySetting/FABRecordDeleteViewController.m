//
//  FABRecordDeleteViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/25.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABRecordDeleteViewController.h"
#import "FABTitleButtonTableViewCell.h"
#import "FABAccountingSummaryEntity.h"
#import "FABRecordCommonViewController.h"
#import "FABAccountingRecentRecordEntity.h"

static NSString *RecordManageViewID = @"RecordManageView";

@interface FABRecordDeleteViewController ()

@property (nonatomic, strong) NSArray *monthArr;


@end

@implementation FABRecordDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"记录删除";
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"数据删除"];
    [MobClick beginLogPageView:@"数据删除"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"数据删除"];
    [MobClick endLogPageView:@"数据删除"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    self.monthArr = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:100];
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.monthArr count] > 1? [self.monthArr count] + 1 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleButtonTableViewCell *cell = [FABTitleButtonTableViewCell cellForTableView:tableView];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    if (indexPath.row != [self.monthArr count]) {
        FABAccountingSummaryEntity *myEntity = self.monthArr[indexPath.row];
        NSString *title = [NSString stringWithFormat:@"%@%@（%d）",myEntity.accountingId,NSLocalizedString(@"Month",nil),(int)myEntity.monthRecordNum];
        [cell configCellWithTitle:title];
        cell.deleteBtnPressedBlock = ^(){
            if ((int)myEntity.monthRecordNum > 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil) message:NSLocalizedString(@"Data can not be restored",nil)  preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Remind me later",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                    NSLog(@"点击了确定按钮");
                    JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
                    event.eventID = @"deletMonthRecored";
                    NSString *number = [NSString stringWithFormat:@"%ld", myEntity.monthRecordNum];
                    event.extra = @{@"删除月份":myEntity.accountingId,
                                    @"记录条数":number,
                                    @"操作类型":@"点击了按月删除按钮"
                                    };
                    [JANALYTICSService eventRecord:event];
                    [self toDeleteWithMonthId:myEntity.accountingId];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
        };
        
    }else{
        FABAccountingSummaryEntity *myEntity = self.monthArr[0];
        NSString *title = [NSString stringWithFormat:@"%@（%d）",NSLocalizedString(@"All records",nil),(int)myEntity.allRecordNum];
        [cell configCellWithTitle:title];
        cell.deleteBtnPressedBlock = ^(){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil) message:NSLocalizedString(@"Data can not be restored",nil) preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Remind me later",nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Confirm",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                NSLog(@"点击了确定按钮");
                JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
                event.eventID = @"deletAllRecord";
                NSString *number = [NSString stringWithFormat:@"%ld", myEntity.allRecordNum];
                event.extra = @{ @"记录条数":number,
                                 @"操作类型":@"点击了所有删除按钮"
                                 };
                [JANALYTICSService eventRecord:event];
                [self toDeleteWithMonthId:nil];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        };
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:RecordManageViewID];
    return sectionView;
}


- (void)toDeleteWithMonthId:(NSString *)monthId
{
    
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *incomeBudget = [myDefault objectForKey:@"incomeBudget"];
    NSNumber *expenditureBudget = [myDefault objectForKey:@"expenditureBudget"];
    if (!monthId) {
        [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
        
        LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
        LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
        [monthHelper deleteWithClass:[FABAccountingSummaryEntity class] where:nil];
        
        FABAccountingSummaryEntity *myEntity = [[FABAccountingSummaryEntity alloc] init];
        myEntity.accountingId = [NSDate monthId];
        myEntity.incomeBudget = [incomeBudget integerValue] > 0 ? expenditureBudget : @(0.0);
        myEntity.income = @(0.0);
        myEntity.expenditure = @(0.0);
        myEntity.expenditureBudget = [expenditureBudget integerValue] > 0 ? expenditureBudget : @(0.0);
        myEntity.budgetBalance = @([myEntity.expenditureBudget integerValue]- [myEntity.expenditure integerValue]);
        myEntity.cashSurplus = @(0.0);
        [myEntity saveToDB];
        
        [globalHelper deleteWithClass:[FABAccountingRecentRecordEntity class] where:nil callback:^(BOOL result){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [self setData];
                    [ProgressHUD showSuccess:NSLocalizedString(@"Deleted successfully",nil)];
                    
                }else{
                    [ProgressHUD showError:NSLocalizedString(@"Delete failed",nil)];
                }});
        }];
    }else{
        
        LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
        LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
        if ([monthId isEqualToString:[NSDate monthId]]) {
            FABAccountingSummaryEntity *myEntity = [[FABAccountingSummaryEntity alloc] init];
            myEntity.accountingId = [NSDate monthId];
            myEntity.incomeBudget = [incomeBudget integerValue] > 0 ? expenditureBudget : @(0.0);
            myEntity.income = @(0.0);
            myEntity.expenditure = @(0.0);
            myEntity.expenditureBudget = [expenditureBudget integerValue] > 0 ? expenditureBudget : @(0.0);
            myEntity.budgetBalance = @([myEntity.expenditureBudget integerValue]- [myEntity.expenditure integerValue]);
            myEntity.cashSurplus = @(0.0);
            [monthHelper updateToDB:myEntity where:@{@"accountingId":monthId}];
        }else{
            [monthHelper deleteWithClass:[FABAccountingSummaryEntity class] where:@{@"accountingId":monthId}];
            
        }
        
        [globalHelper deleteWithClass:[FABAccountingRecentRecordEntity class] where:@{@"monthId":monthId} callback:^(BOOL result){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [self setData];
                    [ProgressHUD showSuccess:NSLocalizedString(@"Deleted successfully",nil)];
                    
                }else{
                    [ProgressHUD showError:NSLocalizedString(@"Delete failed",nil)];
                }});
        }];
        
    }
}
@end
