//
//  FABPassWordViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABPassWordViewController.h"
#import "FABTitleValueTableViewCell.h"
#import "FABSecurityViewController.h"
#import "FABGestureSettingViewController.h"
#import "FABGestureSwitchCell.h"
#import "FABGestureAuthPasswordViewController.h"
#import "FABGestureEntity.h"
#import "FABUnlockManager.h"

static NSString *PassWordViewID = @"PassWordView";


@interface FABPassWordViewController ()
@property (nonatomic, strong) FABGestureEntity *myEntity;
@property (nonatomic, assign) BOOL isSecurityQuestionExist;
@property (nonatomic, assign) BOOL touchIDSwithState;
@property (nonatomic, assign) BOOL gestureState;

@end

@implementation FABPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Security Settings",nil);
    [self setUpCutomView];
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"密码设置"];
    [MobClick beginLogPageView:@"密码设置"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"密码设置"];
    [MobClick endLogPageView:@"密码设置"];

}
- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    self.gestureState = NO;
    self.isSecurityQuestionExist = NO;
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"securityQuestion"];
    if(myData){
        self.isSecurityQuestionExist = YES;
    }
  [self getGestureEntity ];
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1 && self.myEntity.enableGesture) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    
    FABGestureSwitchCell *cell1 = [FABGestureSwitchCell cellForTableView:tableView];
    cell1.accessoryType = UITableViewCellAccessoryNone;
    [tableView addLineforPlainCell:cell1 forRowAtIndexPath:indexPath withLeftSpace:10];

    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle  = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        [cell configCellWithTitle:NSLocalizedString(@"Security question setting",nil) titleLeftOffset:10];
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        [MobClick event:@"set_Gesture"];

        [cell1 configCellWithTitle:NSLocalizedString(@"Gesture password setting",nil)];
        __weak   typeof(self)  weakSelf = self;

        cell1.switchChangedHandlerBlock = ^(UISwitch *switchView) {
            
            if (self.isSecurityQuestionExist) {
                BOOL isOn = switchView.isOn;
                if (!self.gestureState){
                    [weakSelf enableGesturePassword:isOn];
                }
            }else{
                [weakSelf showAlertView];
            }
        };
        [cell1.switchView setOn:self.myEntity.enableGesture];
        return cell1;
    }else if(indexPath.section == 1 &&  indexPath.row == 1){
        if (self.myEntity.enableGesture) {
            [cell configCellWithTitle:NSLocalizedString(@"Modify gesture password",nil) titleLeftOffset:10];
            return cell;
        }else{
            return nil;
        }
    }else{
        [MobClick event:@"set_TouchID"];

        [cell1 configCellWithTitle:NSLocalizedString(@"Touch ID",nil)];
        cell1.switchChangedHandlerBlock = ^(UISwitch *switchView) {
            [self switchTouchIDChanged:switchView];
        };
        [cell1.switchView setOn:self.myEntity.touchIDSwithState];
        return cell1;
    }
}

- (void)switchTouchIDChanged:(UISwitch *)touchIDSwitch
{
    FABTouchIDType type = [[FABUnlockManager sharedManager] isSupportTouchID];
    switch (type) {
        case FABTouchIDTypeNotEnrolled: {
            [ProgressHUD showError:NSLocalizedString(@"kTouchIDNotEvaluatePolicyKey",nil)];
            if (self.touchIDSwithState != touchIDSwitch.on) {
                touchIDSwitch.on = !touchIDSwitch.on;
                self.touchIDSwithState = touchIDSwitch.on;
            }
            break;
        }
        default: {
            if (touchIDSwitch.on) {
                touchIDSwitch.enabled = YES;
//                @weakify(self);
                [[FABUnlockManager sharedManager] evaluateTouchIDSuccess:^{
//                    @strongify(self);
                    [ProgressHUD showSuccess:NSLocalizedString(@"kTouchIDEvaluateSuccess",nil)];
                    self.myEntity.touchIDSwithState = YES;
                    [self upDateGestureEntity];
                    touchIDSwitch.on = YES;

                } failed:^(FABTouchIDType type) {
                    touchIDSwitch.on = NO;
//                    self.myEntity.touchIDSwithState = NO;
//                    [self upDateGestureEntity];

                }];            }
            else {
                @weakify(self);
                touchIDSwitch.enabled = NO;
                [[FABUnlockManager sharedManager] evaluateTouchIDSuccess:^{
                    @strongify(self);
                    [ProgressHUD showSuccess:NSLocalizedString(@"kTouchIDCloseSuccess",nil)];
                    touchIDSwitch.enabled = YES;
                    self.myEntity.touchIDSwithState = NO;
                    [self upDateGestureEntity];
                    touchIDSwitch.on = NO;


                } failed:^(FABTouchIDType type) {
//                    @strongify(self);
                    touchIDSwitch.on = YES;
                    touchIDSwitch.enabled = YES;
//                    self.myEntity.touchIDSwithState = YES;
//                    [self upDateGestureEntity];
                }];
            }
            break;
        }
    }
}

- (void)enableGesturePassword:(BOOL)enable
{
    self.gestureState = YES;
    if (enable) {
        //启用手势密码-->设置手势密码
        FABGestureSettingViewController *gestureSettingVC = [[FABGestureSettingViewController alloc] init];
        gestureSettingVC.curViewType = FABGestureMangerViewType_Set_PasswordManage_Setting;
        [self pushNormalViewController:gestureSettingVC];
        
        
    } else {
        //关闭手势密码
        FABGestureAuthPasswordViewController *authPasswordVC = [[FABGestureAuthPasswordViewController alloc] init];
        [self pushNormalViewController:authPasswordVC];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PassWordViewID];
    return sectionView;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self toPassWord];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        [self modifyGesturePassword];
    }
}


-(void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil)message:NSLocalizedString(@"Please set the security problem first",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Set immediately",nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self toPassWord];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)toPassWord{
    FABSecurityViewController *security = [[FABSecurityViewController alloc] init];
    [self pushNormalViewController:security];
}
- (void)modifyGesturePassword
{
    //修改手势密码
    FABGestureSettingViewController *gestureSettingVC = [[FABGestureSettingViewController alloc] init];
    gestureSettingVC.curViewType = FABGestureMangerViewType_Set_PasswordManage_Modify;
    [self pushNormalViewController:gestureSettingVC];
    
}


-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.myEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
    [self getGestureEntity];
}

-(void)getGestureEntity{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(myData){
        self.myEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
}

@end
