//
//  FABRecordManageViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/4.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABRecordManageViewController.h"
//#import "FABTitleButtonTableViewCell.h"
//#import "FABAccountingSummaryEntity.h"
//#import "FABRecordCommonViewController.h"
//#import "FABAccountingRecentRecordEntity.h"
#import "FABTitleValueTableViewCell.h"

#import "FABRecordDeleteViewController.h"
#import "FABRecordInquireViewController.h"

static NSString *RecordManageViewID = @"RecordManageView";


@interface FABRecordManageViewController ()

//@property (nonatomic, strong) NSArray *monthArr;

@end

@implementation FABRecordManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Data Management",nil);
    [self setUpCutomView];
}
- (void)viewDidAppear:(BOOL)animated {
    [JANALYTICSService startLogPageView:@"数据管理"];
    [MobClick beginLogPageView:@"数据管理"];

}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"数据管理"];
    [MobClick endLogPageView:@"数据管理"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    if (indexPath.section == 0) {
        [cell configCellWithTitle:NSLocalizedString(@"Delete",nil) titleLeftOffset:10];
    }else{
        [cell configCellWithTitle:NSLocalizedString(@"Query the records",nil) titleLeftOffset:10];

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

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section  == 0) {
        FABRecordDeleteViewController *recordDelete = [[FABRecordDeleteViewController alloc] init];
        [self pushNormalViewController:recordDelete];
    }else{
        FABRecordInquireViewController *recordInquire = [[FABRecordInquireViewController alloc] init];
        [self pushNormalViewController:recordInquire];
    }
}


@end
