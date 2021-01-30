//
//  FABMonthHistoryViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/6.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABMonthHistoryViewController.h"
#import "FABAccountingSummaryCell.h"
#import "FABAccountingSummaryEntity.h"
#import "FABMonthDetailViewController.h"



@interface FABMonthHistoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *myRecordArray;


@end

@implementation FABMonthHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"History record",nil);
    [self setUpCutomView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"历史记录"];
    [MobClick beginLogPageView:@"历史记录"];

    [self setData];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"历史记录"];
    [MobClick endLogPageView:@"历史记录"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
}


-(void)setData{
    
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    
    self.myRecordArray = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:100];
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _myRecordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 190;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FABAccountingSummaryCell *cell = [FABAccountingSummaryCell cellForTableView:tableView];
    [cell setUpItemEntity:self.myRecordArray[indexPath.row]];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}




#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABMonthDetailViewController *monthDetail = [[FABMonthDetailViewController alloc] init];
    FABAccountingSummaryEntity *myEntity = self.myRecordArray[indexPath.row];
    monthDetail.monthId = myEntity.accountingId;
    [self pushNormalViewController:monthDetail];
    
}




@end
