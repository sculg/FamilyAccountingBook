//
//  FABBudgetSettingViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/2.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBudgetSettingViewController.h"
#import "FABTitleTextFieldTableViewCell.h"
#import "FABAccountingButtonCell.h"
#import "FABTitleValueTableViewCell.h"
#import "FABAccountingSummaryEntity.h"
#import "XNOKeyboardExtensionView.h"


@interface FABBudgetSettingViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) FABAccountingSummaryEntity *myMonthEntity;
@property (nonatomic, assign) BOOL isBound;

@end

@implementation FABBudgetSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = @"预算设置";
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"预算设置"];
    [MobClick beginLogPageView:@"预算设置"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"预算设置"];
    [MobClick endLogPageView:@"预算设置"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
     _isBound = NO;
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    if ([monthArray count] > 0) {
        self.myMonthEntity = monthArray[0];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 屏蔽黏贴
    if (string.length > 1) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length >= 12) {
        return NO;
    }
    else {
        return [self doCheckInputAmount:textField Range:range replacementString:string];
    }
}


#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 3) {
        return 44;
    }else{
        return kScreenHeight *0.4;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleTextFieldTableViewCell *cell = [FABTitleTextFieldTableViewCell cellForTableView:tableView];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        NSString *incomeBudget = [NSString stringWithFormat:@"%.2f",[self.myMonthEntity.incomeBudget doubleValue]];
        [cell configCellWithTitle:NSLocalizedString(@"Income budget",nil) leftOffset:10 textFieldValue:incomeBudget textFieldValueOffset:10 + 0.20 * kScreenWidth];
        cell.textValueChangedBlock = ^(NSString *value){
            self.myMonthEntity.incomeBudget = @([value doubleValue]);
        };
        cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.valueTextField.delegate = self;

        cell.valueTextField.inputAccessoryView = [XNOKeyboardExtensionView createView];

        return cell;
    }else if (indexPath.row == 1){
        NSString *expenditureBudget = [NSString stringWithFormat:@"%.2f",[self.myMonthEntity.expenditureBudget doubleValue]];
        [cell configCellWithTitle:NSLocalizedString(@"Expenditure budget",nil) leftOffset:10 textFieldValue:expenditureBudget textFieldValueOffset:10 + 0.20 * kScreenWidth];
        cell.textValueChangedBlock = ^(NSString *value){
            self.myMonthEntity.expenditureBudget = @([value doubleValue]);
            self.myMonthEntity.budgetBalance = @([value doubleValue] - [self.myMonthEntity.expenditure doubleValue]);
        };
        cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.valueTextField.delegate = self;
        cell.valueTextField.inputAccessoryView = [XNOKeyboardExtensionView createView];

        return cell;
    }else if (indexPath.row == 2){
        FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
//        [cell configCellWithTitle:@"收入对象："detail:[NSDate monthId]];
        [cell configCellWithTitle:NSLocalizedString(@"Corresponding month",nil) titleLeftOffset:10 detail:[NSDate monthId] detailLabelLeftOffset:135];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        FABAccountingButtonCell *cell1 = [FABAccountingButtonCell cellForTableView:tableView];
        [cell1 configButtonWithTitle:NSLocalizedString(@"Save",nil) topOffset:kScreenHeight *0.4 - 54];
        cell1.btnPressedBlock = ^(){
            [self saveBudget];
        };
        
        if (!_isBound) {
            RAC(cell1.button, enabled) = [RACSignal combineLatest:@[RACObserve(self, myMonthEntity.incomeBudget),
                                                                   RACObserve(self, myMonthEntity.expenditureBudget)]
                                                          reduce:^id(NSNumber *incomeBudget,
                                                                     NSNumber *expenditureBudget){
                                                              
                                                              BOOL enabled = ([incomeBudget integerValue] > 0 && [expenditureBudget integerValue] > 0);
                                                              return @(enabled);
                                                              
                                                          }];
            _isBound = YES;
        }
        cell1.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell1;
    }
}



-(void)saveBudget{
//    if ([self.myMonthEntity.incomeBudget intValue] == 0 || [self.myMonthEntity.expenditureBudget intValue] == 0) {
//        [self showAlertView];
//    }else{
        [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
        NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
        //NSUserDefaults 存预算
        [myDefault setObject:self.myMonthEntity.incomeBudget forKey:@"incomeBudget"];
        [myDefault setObject:self.myMonthEntity.expenditureBudget forKey:@"expenditureBudget"];
        [myDefault synchronize];
        
        LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
        [monthHelper updateToDB:self.myMonthEntity where:@{@"accountingId":self.myMonthEntity.accountingId} callback:^(BOOL result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [ProgressHUD showSuccess:NSLocalizedString(@"Saved successfully",nil)];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ProgressHUD showError:NSLocalizedString(@"Save failed",nil)];
                }});
        }];
//    }
}

//-(void)showAlertView{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"所设置预算值不能为0！"preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Got it",nil)style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
//        
//    }]];
//    [self presentViewController:alert animated:YES completion:nil];
//}


@end
