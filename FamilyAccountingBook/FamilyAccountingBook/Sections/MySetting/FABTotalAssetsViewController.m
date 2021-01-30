//
//  FABTotalAssetsViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/9/17.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABTotalAssetsViewController.h"
#import "FABAccountingButtonCell.h"
#import "FABTitleTextFieldTableViewCell.h"
#import "XNOKeyboardExtensionView.h"


@interface FABTotalAssetsViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSString *totalAssets;
@end

@implementation FABTotalAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"总资产"];
    [MobClick beginLogPageView:@"总资产"];

    [self setData];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"总资产"];
    [MobClick endLogPageView:@"总资产"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    self.totalAssets = [myDefault objectForKey:@"InitialAssets"];
    if (_totalAssets.length == 0) {
        self.totalAssets = @"0";
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
    
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 1) {
        return 44;
    }else{
        return kScreenHeight *0.4;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0){
        FABTitleTextFieldTableViewCell *cell = [FABTitleTextFieldTableViewCell cellForTableView:tableView];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        NSString *title  = [NSString stringWithFormat:@"%@:",NSLocalizedString(@"Initial Assets",nil)];
        [cell configCellWithTitle:title textFieldValue:self.totalAssets];
        cell.textValueChangedBlock = ^(NSString *value){
            self.totalAssets = [NSString stringWithFormat:@"%.2f",[value doubleValue]];
        };
        cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.valueTextField.delegate = self;
        cell.valueTextField.inputAccessoryView = [XNOKeyboardExtensionView createView];
        return cell;
    }else{
        FABAccountingButtonCell *cell1 = [FABAccountingButtonCell cellForTableView:tableView];
        [cell1 configButtonWithTitle:NSLocalizedString(@"Save",nil) topOffset:kScreenHeight *0.4 - 54];
        cell1.btnPressedBlock = ^(){
            [self saveBudget];
        };
        cell1.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}



-(void)saveBudget{
    //    [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:self.totalAssets forKey:@"InitialAssets"];
    [myDefault synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
