//
//  FABCurrencyUnitViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/8/31.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABCurrencyUnitViewController.h"
#import "FABAccountingButtonCell.h"
#import "FABTitleValueTableViewCell.h"


@interface FABCurrencyUnitViewController ()

@property (nonatomic, strong) NSArray *unitArray;

@property (nonatomic, strong) NSString *selectedValue;
@end

@implementation FABCurrencyUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"单位设置"];
    [MobClick beginLogPageView:@"单位设置"];

    [self setData];
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"单位设置"];
    [MobClick endLogPageView:@"单位设置"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    self.unitArray = @[@" ¥",@" ￡",@" $",@" €",@" DM",@" FF",@" A$",@" DKR",@" WON",@" HK$",@" J￥",@" SF",@" F",@" LIT",@" A$",@" SKR",@" S$"];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    self.selectedValue = [myDefault objectForKey:@"CurrencyUnit"];
    if (_selectedValue.length == 0) {
        self.selectedValue = @"¥";
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
    
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0){
        NSString *incomeBudget = [NSString stringWithFormat:NSLocalizedString(@"Select the currency unit",nil)];
        [cell configCellWithTitle:incomeBudget titleLeftOffset:10 detail:self.selectedValue detailLabelLeftOffset:120];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
//        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    if (indexPath.row == 0) {
        @weakify(self);
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_unitArray] initialSelection:@[@0] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            @strongify(self);
            NSString *value = selectedValue[0];
            self.selectedValue = value;
            [self.tableView reloadData];
        } cancelBlock:nil origin:self.view];
    }
}



-(void)saveBudget{
//    [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:self.selectedValue forKey:@"CurrencyUnit"];
    [myDefault synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
