//
//  FABGestureSettingViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureSettingViewController.h"
#import "FABGestureEntity.h"

#import "FABAppDelegate.h"
#import "FABGestureAuthView.h"
#import "GesturePasswordConstants.h"
#import "FABGesturePasswordText.h"

@interface FABGestureSettingViewController ()<KKGestureLockViewDelegate>

@property (nonatomic, assign) BOOL isReset;             //是否是重设
@property (nonatomic, assign) NSInteger errCount;       //错误次数
@property (nonatomic, copy) NSString *firstPassword;    //第一次输入的密码

@property (nonatomic, strong) FABGestureAuthView *authGestureView;

//@property (nonatomic, strong) UIButton *skipButton;     //跳过
//@property (nonatomic, strong) UIButton *forgetButton;   //忘记密码

@property (nonatomic, strong) FABGestureEntity *curGestureEntity;

@property (nonatomic, assign) BOOL isClickforgetButton;

@end

@implementation FABGestureSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //手势校验View
    int offset = 20.0f;
    if (FABGestureMangerViewType_Set_Login_Setting == self.curViewType) {
        offset = 64.0f;
    }
    CGRect gestureViewFrame = CGRectMake(0, offset, kScreenWidth, kScreenHeight-offset);
    self.authGestureView = [[FABGestureAuthView alloc] initWithFrame:gestureViewFrame GestureDelegate:self];
    NSString *titleText = NSLocalizedString(@"Please draw the gesture password",nil);
    self.title = NSLocalizedString(@"Gesture password",nil);
    if (self.curViewType == FABGestureMangerViewType_Set_PasswordManage_Modify) {
        titleText = NSLocalizedString(@"Original gesture password",nil);
        self.title = NSLocalizedString(@"Modify gesture password",nil);
        
    }
    self.authGestureView.stateLabel.text = titleText;
    [self.view addSubview:self.authGestureView];
    
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    
    //在这里解档
    self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    self.errCount = self.curGestureEntity.errorCount;
    
    if (FABGestureMangerViewType_Set_Login_Setting != self.curViewType) {
        if (self.curGestureEntity.errorCount <= 0) {
            [self handleGestureMaxCountError];
        }
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.curViewType) {
        case FABGestureMangerViewType_Set_Login_Setting: {
            
            //登录设置:显示“跳过”按钮
//            [self.skipButton setHidden:NO];
            break;
        }
        case FABGestureMangerViewType_Set_PasswordManage_Setting: {
            
            //密码管理-设置手势密码:不显示按钮
            break;
        }
        case FABGestureMangerViewType_Set_PasswordManage_Modify: {
            
            //密码管理-修改手势密码:显示“忘记手势密码”按钮
            break;
        }
            
        default:
            break;
    }
}


//- (UIButton *)skipButton
//{
//    
//    if (!_skipButton) {
//        
//        
//        //跳过按钮
//        _skipButton = [[UIButton alloc] init];
//        [self.view addSubview:_skipButton];
//        
//        
//        
//        [_skipButton ss_setTarget:self Selector:@selector(onSkip)];
//        [_skipButton ss_setTitle:@"跳过"
//                       TitleFont:kFontSize(16)
//                NormalTitleColor:KGestureButtonTextColor
//             HighLightTitleColor:KGestureButtonTextColor];
//        
//        @weakify(self);
//        [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            @strongify(self);
//            make.centerX.equalTo(self.view);
//            make.bottom.equalTo(self.view);
//            make.width.equalTo(@140);
//            make.height.equalTo(@40);
//        }];
//        
//    }
//    
//    return _skipButton;
//}
//


//- (UIButton *)forgetButton
//{
//    if (!_forgetButton) {
//        
//        
//        //跳过按钮
//        _forgetButton = [[UIButton alloc] init];
//        [self.view addSubview:_forgetButton];
//        
//        
//        
//        [_forgetButton ss_setTarget:self Selector:@selector(onForget)];
//        [_forgetButton ss_setTitle:@"忘记手势密码"
//                         TitleFont:kFontSize(16)
//                  NormalTitleColor:KGestureButtonTextColor
//               HighLightTitleColor:KGestureButtonTextColor];
//        
//        
//        @weakify(self);
//        [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            @strongify(self);
//            make.centerX.equalTo(self.view);
//            make.bottom.equalTo(self.view);
//            make.width.equalTo(@140);
//            make.height.equalTo(@40);
//        }];
//        
//    }
//    
//    return _forgetButton;
//}
//



- (void)resetData
{
    self.isReset = NO;
    self.errCount = 0;
    self.firstPassword = nil;
}


- (void)resumeGestureView
{
    if(self.authGestureView) {
        
        [self.authGestureView.topGestureView clearPasscode];
        [self.authGestureView.bodyGestureView clearPasscode];
        [self.authGestureView setUserInteractionEnabled:YES];
    }
}



- (void)onSkip
{
    // 跳过设置手势(即禁用)
    [self.curGestureEntity disableGesture];
    
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.curGestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
    
    if (self.hideMainVCBlock) {
        self.hideMainVCBlock(NO);
    }
}


- (void)onForget
{
    //忘记手势密码
//    self.isClickforgetButton = YES;
//    [self handleGestureMaxCountError];
}

- (void)handleGestureAuthSuccess
{
    //手势密码校验成功
    if (FABGestureMangerViewType_Set_PasswordManage_Setting == self.curViewType) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (FABGestureMangerViewType_Set_Login_Setting == self.curViewType) {
        if (self.hideMainVCBlock) {
            self.hideMainVCBlock(NO);
        }
    }
}


//手势密码校验失败
- (void)handleGestureAuthFail
{
    //禁用0.5s
    [self.authGestureView setUserInteractionEnabled:NO];
    [self performSelector:@selector(resumeGestureView) withObject:nil afterDelay:0.5];
}


//手势密码校验失败达到最大次数
- (void)handleGestureMaxCountError
{
    //禁用手势密码
    self.authGestureView.userInteractionEnabled = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sorry",nil) message:NSLocalizedString(@"Verification failed",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Exit immediately",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        exit(0);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    //清空手势密码
    //弹窗提示输入账号密码
}

- (void)saveGestureCode:(NSString *)code
{
    // 保存手势密码
    self.curGestureEntity.enableGesture = YES;
    self.curGestureEntity.gesturePassword = code;
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.curGestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
}


-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.curGestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
}

#pragma mark - KKGestureLockViewDelegate

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode
{
    [self handleAuthView:self.authGestureView WithPasscode:passcode];
}



#pragma mark - 处理验证类型的view

- (void)handleAuthView:(FABGestureAuthView *)authGestureView WithPasscode:(NSString *)passcode
{
    
    
    if (self.curViewType == FABGestureMangerViewType_Set_PasswordManage_Modify) {
        
        
        // 修改手势密码流程
        
        NSString *oldPasscode = self.curGestureEntity.gesturePassword;
        
        /**
         *  验证手势密码
         *  判断当前绘制的手势密码和保存的手势密码一致，则验证通过;
         *  并设置curViewType 为设置密码类型( FABGestureMangerViewType_Set_PasswordManage_Setting ), 后续开始走设置流程。
         */
        
        
        if([oldPasscode isEqualToString:passcode]) {
            
            
//            self.forgetButton.hidden = YES;
            
            [authGestureView.bodyGestureView clearPasscode];
            [authGestureView setStateWithText:NSLocalizedString(@"Please draw a new gesture password",nil) Color:kGestureTitleTextColor];
            
            
            self.curViewType = FABGestureMangerViewType_Set_PasswordManage_Setting;
            
            self.isReset = NO;
            self.errCount = kFABGestureDefaultErrorMaxCount;
            
            //更新手势密码相关数据
            self.curGestureEntity.errorCount = kFABGestureDefaultErrorMaxCount;
            [self upDateGestureEntity];
            
        } else {
            
            //两次绘制的不一致, 验证失败, 判断错误次数是否超过最大次数。
            
            self.errCount--;
            if(self.errCount <= 0) {
                
                // 超出最大次数
                self.errCount = 0;
//                [authGestureView.bodyGestureView clearPasscode];
                [authGestureView setStateWithText:NSLocalizedString(@"5 times",nil) Color:KGestureErrorTextColor];
                
//                self.curGestureEntity.errorCount = 0;
//
//                [self upDateGestureEntity];
                [self handleGestureMaxCountError];
                
            } else {
                
                
//                self.forgetButton.hidden = NO;
                
//                self.curGestureEntity.errorCount = self.errCount;

//                [self upDateGestureEntity];
                
                NSString *errTipText = [NSString stringWithFormat:@"%@%ld%@",kForgetGestureErrorText,(long)self.errCount,kForgetGestureNumberText];
                [authGestureView setStateWithText:errTipText Color:KGestureErrorTextColor];
                
//                self.curGestureEntity.errorCount = self.errCount;
//                [self upDateGestureEntity];

//                [FABGestureHelper shakeWithView:authGestureView.stateLabel];
                
                [authGestureView.bodyGestureView showErrorState];
                
                
                [self handleGestureAuthFail];
            }
        }
        
    }  else {
        
        
        
        //设置手势密码流程: 第一次绘制 + 第二次绘制验证
        if (!self.isReset) {
            
            
            /**
             *  第一次绘制
             *  判断绘制的手势密码是否有效，即大于或等于4个数字,如果有效,保存当前绘制的密码并设置isReset为YES，表示开始第二次绘制
             */
            
            
            if ([[passcode componentsSeparatedByString:@","] count] < 4) {
                
                [authGestureView setStateWithText:NSLocalizedString(@"Connect at least 4 points, please redraw",nil) Color:KGestureErrorTextColor];
//                [FABGestureHelper shakeWithView:authGestureView.stateLabel];
                
                
                self.isReset = NO;
                [authGestureView.bodyGestureView clearPasscode];
                
            } else {
                
                [authGestureView.topGestureView setGestureWithPasscode:passcode];
                [authGestureView setStateWithText:NSLocalizedString(@"Draw again to confirm",nil) Color:kGestureTitleTextColor];
                
                self.isReset = YES;
                self.firstPassword = passcode;
                [authGestureView.bodyGestureView clearPasscode];
                
            }
            
        } else {
            
            
//            WEAKSELF;
            
            
            /**
             *  第二次绘制
             *  判断本次绘制的手势密码是否和第一次的一致，如果一致，则绘制成功，并保存手势密码。
             */
            
            
            if([self.firstPassword isEqualToString:passcode]) {
                
                [authGestureView setStateWithText:NSLocalizedString(@"Confirm success",nil) Color:kGestureTitleTextColor];
                
                [ProgressHUD showSuccess:NSLocalizedString(@"Saved successfully",nil)];
                
                // 保存手势密码
                [self saveGestureCode:passcode];
                
                //禁用0.5s
                [authGestureView setUserInteractionEnabled:NO];
                [self performSelector:@selector(resumeGestureView) withObject:nil afterDelay:1.0];
                
                [self ss_asyncDispatchBlock:^{
                    
                    [self handleGestureAuthSuccess];
                    
                } OnQueue:dispatch_get_main_queue() afterDelay:1.0];
                
                
            } else {
                
                
                [authGestureView setStateWithText:NSLocalizedString(@"Inconsistent",nil) Color:KGestureErrorTextColor];
                
//                [FABGestureHelper shakeWithView:authGestureView.stateLabel];
                
                [authGestureView.bodyGestureView showErrorState];
                
                self.isReset = NO;
                
                [self handleGestureAuthFail];
                
            }
        }
    }
}



@end
