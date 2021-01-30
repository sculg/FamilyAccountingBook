//
//  FABGestureUnLockViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureUnLockViewController.h"
#import "FABGestureView.h"
#import "FABGestureEntity.h"
#import "GesturePasswordConstants.h"
#import "FABSecurityViewController.h"
#import "FABGesturePasswordText.h"

@interface FABGestureUnLockViewController ()<KKGestureLockViewDelegate>

@property (nonatomic, assign) NSInteger errCount;       //错误次数

@property (nonatomic, strong) FABGestureView *gesturePasswordView;
@property (nonatomic, strong) FABGestureEntity *curGestureEntity;

/* 忘记手势密码 */
@property(nonatomic, strong) UIButton *forgetButton;

/* 其他账户登录 */
@property(nonatomic, strong) UIButton *otherButton;

@end

@implementation FABGestureUnLockViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    
    self.title = NSLocalizedString(@"Gesture password",nil);
    self.view.backgroundColor = [UIColor clearColor];
    
    int offsetY = 64.0f;
    CGRect gestureViewFrame = CGRectMake(0, offsetY, kScreenWidth, kScreenHeight - 0);
    self.gesturePasswordView = [[FABGestureView alloc] initWithFrame:gestureViewFrame GestureDelegate:self];
    [self.view addSubview:self.gesturePasswordView];
    
    
    NSString *authUnlockText = NSLocalizedString(@"Please draw the gesture to unlock",nil);
    self.gesturePasswordView.stateLabel.text = authUnlockText;
    
    
    
//    NSString *otherLoginText    = @"其他账户登录";
//    NSString *forgetGestureText = @"忘记手势密码";
    self.forgetButton = [[UIButton alloc] init];
    self.otherButton  = [[UIButton alloc] init];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.otherButton];
    
//    [self.forgetButton ss_setTitle:forgetGestureText
//                         TitleFont:kFontSize(16)
//                  NormalTitleColor:KGestureButtonTextColor
//               HighLightTitleColor:KGestureButtonTextColor];
//    [self.forgetButton ss_setTarget:self Selector:@selector(clickForgetButton:)];
    
    
    float viewHeight = CGRectGetHeight(self.view.frame);
    CGFloat btnOffsetX = 10;
    CGFloat btnOffsetY = viewHeight - 40;
    self.forgetButton.frame = CGRectMake(btnOffsetX, btnOffsetY, 140, 40);
    
//    
//    [self.otherButton ss_setTitle:otherLoginText
//                        TitleFont:kFontSize(16)
//                 NormalTitleColor:KGestureButtonTextColor
//              HighLightTitleColor:KGestureButtonTextColor];
//    [self.otherButton ss_setTarget:self Selector:@selector(clickOtherButton:)];
    
    btnOffsetX = kScreenWidth - 10 - 140;
    self.otherButton.frame = CGRectMake(btnOffsetX, btnOffsetY, 150, 40);
    
    self.errCount = kFABGestureDefaultErrorMaxCount;
    
}


#pragma mark - Private



-(void)clickForgetButton:(id)sender
{
    [_gesturePasswordView.gestureView clearPasscode];
    
    if (self.forgetPasswordBlock) {
        self.forgetPasswordBlock();
    }
}


- (void)clickOtherButton:(id)sender
{
    [_gesturePasswordView.gestureView clearPasscode];
    
    if (self.otherLoginBlock) {
        self.otherLoginBlock();
    }
    
}


- (void)resumeGestureView
{
    if(self.gesturePasswordView) {
        
        [self.gesturePasswordView.gestureView clearPasscode];
        [self.gesturePasswordView setUserInteractionEnabled:YES];
    }
}


- (void)handleGestureAuthSuccess
{
    //手势密码校验成功
    if (self.hideMainVCBlock) {
        self.hideMainVCBlock(NO);
    }
}


//手势密码校验失败
- (void)handleGestureAuthFail
{
    
    [self.gesturePasswordView setUserInteractionEnabled:NO];
    [self performSelector:@selector(resumeGestureView) withObject:nil afterDelay:0.5];
}


//手势密码校验失败达到最大次数
- (void)handleGestureMaxCountError
{
    if (self.maxCountErrorBlock) {
        self.maxCountErrorBlock();
    }
    //手势密码不可用
    self.gesturePasswordView.userInteractionEnabled = NO;
}

#pragma mark - KKGestureLockViewDelegate

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode
{
    [self handleGestureView:_gesturePasswordView WithPasscode:passcode];
}




#pragma mark - 处理设置类型的view
- (void)handleGestureView:(FABGestureView *)gesturePasswordView WithPasscode:(NSString *)passcode
{
    
    NSString *oldPasscode = self.curGestureEntity.gesturePassword;
    
    if([oldPasscode isEqualToString:passcode]) {
        
        //两次绘制的都一致, 验证通过
        [gesturePasswordView.gestureView clearPasscode];
        [gesturePasswordView setStateWithText:NSLocalizedString(@"Please draw the gesture to unlock",nil) Color:kGestureTitleTextColor];
        
        
        self.errCount = kFABGestureDefaultErrorMaxCount;
        
        //重置最大错误次数
        //更新手势密码相关数据
        //        curGesture.errorCount = kXNLGestureDefaultErrorMaxCount;
        //        [[XNLAccountManager sharedInstance] cacheUserInfoData];
        
        [self handleGestureAuthSuccess];
        
    } else {
        
        self.errCount--;
        if(self.errCount <= 0) {
            
            // 超出最大次数
            self.errCount = 0;
            [gesturePasswordView.gestureView clearPasscode];
            [gesturePasswordView setStateWithText:NSLocalizedString(@"5 times",nil) Color:KGestureErrorTextColor];
            gesturePasswordView.gestureView.userInteractionEnabled = NO;
            [self handleGestureMaxCountError];
            
        } else {
            
            NSString *errTipText = [NSString stringWithFormat:@"%@%ld%@",kForgetGestureErrorText,(long)self.errCount,kForgetGestureNumberText];
            [gesturePasswordView setStateWithText:errTipText Color:KGestureErrorTextColor];
            
//            [XNLGestureHelper shakeWithView:gesturePasswordView.stateLabel];
            
            [gesturePasswordView.gestureView showErrorState];
            
            
            [self handleGestureAuthFail];
            
            
            
        }
    }
}


- (void)toSecurityView
{
    
    FABSecurityViewController *securityView = [[FABSecurityViewController alloc] init];
    [self pushNormalViewController:securityView];
    
}

@end
