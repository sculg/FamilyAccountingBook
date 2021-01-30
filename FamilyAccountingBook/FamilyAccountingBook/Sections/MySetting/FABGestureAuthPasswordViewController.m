//
//  FABGestureAuthPasswordViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureAuthPasswordViewController.h"
#import "FABGestureView.h"
#import "FABGestureEntity.h"
#import "GesturePasswordConstants.h"
#import "FABGesturePasswordText.h"
@interface FABGestureAuthPasswordViewController ()<KKGestureLockViewDelegate>

@property (nonatomic, assign) NSInteger errCount;       //错误次数

@property (nonatomic, strong) FABGestureView *gesturePasswordView;
@property (nonatomic, strong) FABGestureEntity *curGestureEntity;

//@property (nonatomic, strong) UIButton *forgetButton;

@property (nonatomic, assign) BOOL isClickforgetButton;

@end

@implementation FABGestureAuthPasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Close gesture password",nil);
    
    [self setLayoutView];
    
    
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];

    self.errCount = self.curGestureEntity.errorCount;
    
    if (self.curGestureEntity.errorCount <= 0) {
        [self gestureMaxCoutError];
    }
}

#pragma mark - Layout Views
- (void)setLayoutView
{
    
//    CGFloat topOffset = scaleY(15.0f);
    CGFloat topOffset = (15.0f);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    
    CGRect gestureFrame = CGRectMake(0,topOffset,kScreenWidth,viewHeight-topOffset);
    self.gesturePasswordView =[[FABGestureView alloc] initWithFrame:gestureFrame GestureDelegate:self];
    [self.view addSubview:self.gesturePasswordView];
    
    
    NSString *authGesturePasswordText = NSLocalizedString(@"Original gesture password",nil);

    self.gesturePasswordView.stateLabel.text = authGesturePasswordText;
    
    
    //忘记密码按钮
//    self.forgetButton = [[UIButton alloc] init];
//    [self.view addSubview:self.forgetButton];
//    
//    
//    NSString *forgetButtonTitle = @"忘记手势密码";
//    self.forgetButton.hidden = YES;
//    [self.forgetButton ss_setTitle:forgetButtonTitle
//                         TitleFont:kFontSize(16)
//                  NormalTitleColor:KGestureButtonTextColor
//               HighLightTitleColor:KGestureButtonTextColor];
//    
//    [self.forgetButton ss_setTarget:self Selector:@selector(clickForgetButton)];
//    
//    
//    
//    @weakify(self);
//    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.centerX.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.width.equalTo(@140);
//        make.height.equalTo(@40);
//    }];
}



#pragma mark - Private



- (void)handleGestureAuthSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gestureMaxCoutError
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sorry",nil) message:NSLocalizedString(@"Verification failed",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Exit immediately",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        exit(0);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    //设置手势密码不可用
//    self.gesturePasswordView.userInteractionEnabled = NO;
    
    
}


- (void)resumeGestureView
{
    if(self.gesturePasswordView) {
        
        [self.gesturePasswordView.gestureView clearPasscode];
        [self.gesturePasswordView setUserInteractionEnabled:YES];
    }
}

- (void)clickForgetButton
{
    self.isClickforgetButton = YES;
    [self gestureMaxCoutError];
}


#pragma mark - KKGestureLockViewDelegate

- (void)gestureLockView:(KKGestureLockView *)gestureLockView
     didEndWithPasscode:(NSString *)passcode
{
    [self handleGestureView:self.gesturePasswordView WithPasscode:passcode];
}


#pragma mark - 处理设置类型的view
- (void)handleGestureView:(FABGestureView *)gesturePasswordView WithPasscode:(NSString *)passcode
{
    
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    NSString *oldPasscode = self.curGestureEntity.gesturePassword;
    NSString *authHintString = @"";
    
    
    if([oldPasscode isEqualToString:passcode]) {
        
        //两次绘制的都一致, 验证通过
        authHintString = @"验证通过";
        [gesturePasswordView.gestureView clearPasscode];
        [gesturePasswordView setStateWithText:authHintString Color:kGestureTitleTextColor];
        
        
        self.errCount = kFABGestureDefaultErrorMaxCount;
        
        //关闭手势密码并缓存
        [self.curGestureEntity disableGesture];
        self.curGestureEntity.errorCount = kFABGestureDefaultErrorMaxCount;
        
        [self upDateGestureEntity];
        
        
    } else {
        
        self.errCount--;
        if(self.errCount <= 0) {
            
            
            authHintString = NSLocalizedString(@"5 times",nil);
            
            // 超出最大次数
            self.errCount = 0;
            [gesturePasswordView.gestureView clearPasscode];
            [gesturePasswordView setStateWithText:authHintString Color:KGestureErrorTextColor];
            
//            self.curGestureEntity.errorCount = 0;
            [self upDateGestureEntity];
            [self gestureMaxCoutError];
            
        } else {
            
            self.curGestureEntity.errorCount = self.errCount;
            [self upDateGestureEntity];
//            if (self.forgetButton.isHidden) {
//                [self.forgetButton setHidden:NO];
//            }
            
            
            //提示语
            NSString *errTipText = [NSString stringWithFormat:@"%@%ld%@",kForgetGestureErrorText,(long)self.errCount,kForgetGestureNumberText];
            [gesturePasswordView setStateWithText:errTipText Color:KGestureErrorTextColor];
            
            //晃动动画
//            [XNLGestureHelper shakeWithView:gesturePasswordView.stateLabel];
            
            [gesturePasswordView.gestureView showErrorState];
            
            //禁用0.5秒
            [gesturePasswordView setUserInteractionEnabled:NO];
            [self performSelector:@selector(resumeGestureView) withObject:nil afterDelay:0.5];
        }
    }
}

-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.curGestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
    [self  getGestureEntity];
    
    [self handleGestureAuthSuccess];

}

-(void)getGestureEntity{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(myData){
        self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
}




@end
