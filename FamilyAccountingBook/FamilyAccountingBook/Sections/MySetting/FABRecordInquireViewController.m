//
//  FABRecordInquireViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/25.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABRecordInquireViewController.h"
#import "FABAccountingButtonCell.h"
#import "FABTitleValueTableViewCell.h"
#import "FABInquiryPeriodViewController.h"



@interface FABRecordInquireViewController ()

@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;

@end

@implementation FABRecordInquireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Query the records",nil);
    [self setUpCutomView];
    [self setData];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"数据查询"];
    [MobClick beginLogPageView:@"数据查询"];

    [self.tableView reloadData];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"数据查询"];
    [MobClick endLogPageView:@"数据查询"];

}

-(void)setData{
    _startDate = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    _endDate = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        return 90;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
        [cell configButtonWithTitle:NSLocalizedString(@"Queries Now",nil) topOffset:40];
        cell.btnPressedBlock = ^(){
            [self tobudgetSetting];
        };
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:20];
    NSString *myTitle = indexPath.row == 0 ? NSLocalizedString(@"Start time",nil) : NSLocalizedString(@"End time",nil);
    NSString *myDetail = indexPath.row == 0 ? _startDate : _endDate;
    [cell configCellWithTitle:myTitle titleLeftOffset:20  detail:myDetail detailLabelLeftOffset:80];
    return cell;
    }
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NSDate *curDate = [NSDate dateFromString:_startDate withFormat:@"yyyy-MM-dd"];
        if (!curDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
            curDate = [NSDate dateFromString:nowtimeStr withFormat:@"yyyy-MM-dd"];
        }
         @weakify(self);
        ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
            @strongify(self);
            _startDate = [selectedDate string_yyyy_MM_dd];
            [self.tableView reloadData];
            
        } cancelBlock:^(ActionSheetDatePicker *picker) {
        } origin:self.view];
        picker.minimumDate = [[NSDate date] offsetYear:-120];
        picker.maximumDate = [NSDate date];
        [picker showActionSheetPicker];
    }else{
        NSDate *curDate = [NSDate dateFromString:_endDate withFormat:@"yyyy-MM-dd"];
        if (!curDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
            curDate = [NSDate dateFromString:nowtimeStr withFormat:@"yyyy-MM-dd"];
        }
        
        ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
            _endDate = [selectedDate string_yyyy_MM_dd];
            [self.tableView reloadData];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
        } origin:self.view];
        picker.minimumDate = [[NSDate date] offsetYear:-120];
        picker.maximumDate = [NSDate date];
        [picker showActionSheetPicker];
    }
}



- (void)tobudgetSetting
{
    FABInquiryPeriodViewController *inquiryPeriod = [[FABInquiryPeriodViewController alloc] init];
    inquiryPeriod.startDate = _startDate;
    inquiryPeriod.endDate = _endDate;
    [self pushNormalViewController:inquiryPeriod];

}




@end
