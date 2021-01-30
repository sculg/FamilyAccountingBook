//
//  FABGestureMainViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureMainViewController.h"
#import "FABGestureUnLockViewController.h"
#import "FABGestureSettingViewController.h"
#import "FABNavigationController.h"
#import "FABAppUtils.h"
#import "FABAppDelegate.h"
#import "UIViewController+SSToolkitAdditions.h"
#import "FABSecurityViewController.h"


#import "FABGestureEntity.h"

static const NSTimeInterval kShowGestureInterval = 3 * 60;
//static const NSTimeInterval kShowGestureInterval = 6;


typedef NS_ENUM(NSInteger, FABGestureShowLoginType) {
    
    FABGestureForgotShowLoginType = 1,
    FABGestureOtherShowLoginType,
    FABGestureMaxErrorShowLoginType
    
};

@interface FABGestureMainViewController ()
{
    UIImageView *snapImageView;
}


//校验手势密码
@property (nonatomic, strong) FABGestureUnLockViewController *gestureUnLockController;

//设置手势密码
@property (nonatomic, strong) FABGestureSettingViewController *setPasswordController;

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) FABGestureShowLoginType showLoginType;

@property (nonatomic, strong) FABGestureEntity *myEntity;

@property (nonatomic, assign) BOOL loginSuccessed;

@end

@implementation FABGestureMainViewController

-(void)dealloc
{
    [self removeNotify];
}

#pragma mark - LifeCycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController setNavigationBarHidden:YES];
    
    if (self.timer) {
        dispatch_resume(self.timer);
    }
    
    [self getGestureEntity];
    if (self.myEntity.enableGesture == NO) {
        [self hide:NO];
    }
    
    if (FABGestureForgotShowLoginType == self.showLoginType) {
        if (self.loginSuccessed) {
            [self changeViewWithType:FABGestureMangerViewType_Set_Login_Setting];
        }
    } else if (FABGestureOtherShowLoginType == self.showLoginType) {
        if (self.loginSuccessed) {
            [self clearUserData];
            [self hide:NO];
            if (self.operationBlock) {
                self.operationBlock(NO);
            }
            [self skipToTabBar];
        }
    } else if (FABGestureMaxErrorShowLoginType == self.showLoginType) {
        if (self.loginSuccessed) {
            [self changeViewWithType:FABGestureMangerViewType_Set_Login_Setting];
        } else {
            
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.timer){
        dispatch_suspend(self.timer);
    }
    
    
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    [self addNotify];
    
    self.title = NSLocalizedString(@"Gesture password",nil);
    self.view.backgroundColor = [UIColor clearColor];
    
    ((FABNavigationController*)self.navigationController).canDragBack = NO;

    [self.view setBackgroundColor:[UIColor whiteColor]];
 
}



#pragma mark - 通知

- (void)addNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNoticeGesture)
                                                 name:FAB_NOTIFICATION_HIDE_GESTURE_PASSWORD
                                               object:nil];
    
}

- (void)removeNotify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public

+ (BOOL)isCanShowMainGestureWithDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type
{
    

    if (!definite) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
        //在这里解档
        
        if(myData){
            FABGestureEntity *myEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
            if (myEntity.enableGesture == NO) {
                return NO;
            }
            NSTimeInterval enterBackGroundTime = myEntity.enterBackgroundTime;
            
            //一定时间内不弹出手势密码
            if (currentTime - enterBackGroundTime < kShowGestureInterval) {
                return NO;
            }
        }
        
    }
    
    UIViewController *topCtl = [FABAppUtils currentVC];
    //如果页面就是解锁界面 则不需要再次出现解锁界面
    if ([topCtl isKindOfClass:[FABGestureMainViewController class]]) {
        return NO;
    }
    return YES;
}

+ (FABGestureMainViewController *)showMainGestureDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type animate:(BOOL)isAnimate
{
    BOOL canShow = [FABGestureMainViewController isCanShowMainGestureWithDefinitely:definite type:type];
    if (!canShow) {
        return nil;
    }
    
    FABGestureMainViewController *mainGestureCtl = [[FABGestureMainViewController alloc] init];
    [mainGestureCtl changeViewWithType:type];
    
    UIViewController *topCtl = [FABAppUtils currentVC];
    [topCtl presentViewController:mainGestureCtl animated:isAnimate completion:nil];
    
    return mainGestureCtl;
}

+ (FABGestureMainViewController *)showMainGestureDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type
{
    return [FABGestureMainViewController showMainGestureDefinitely:definite type:type animate:NO];
}

#pragma mark - Private

//
- (void)refreshSnapImageView
{
    if(snapImageView == nil) {
        
        snapImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:snapImageView];
    }
    
    [self.view sendSubviewToBack:snapImageView];
}


-(void)hide:(BOOL)animation
{
    [self dismissViewControllerAnimated:animation completion:nil];
}

#pragma mark - Notice

-(void)handleNoticeGesture
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hide:NO];
        if (self.operationBlock) {
            self.operationBlock(NO);
        }
        
    });
}

#pragma mark - AddView

-(void)changeViewWithType:(FABGestureMangerViewType)viewType
{
    
    [self clearViewController:self.gestureUnLockController];
    [self clearViewController:self.setPasswordController];
    
    
    switch (viewType) {
        case FABGestureMangerViewType_Set_Login_Setting:
        case FABGestureMangerViewType_Set_PasswordManage_Setting:
        case FABGestureMangerViewType_Set_PasswordManage_Modify:
        {
            
            [self createGestureSettingViewControllerWithViewType:viewType];
            break;
        }
        case FABGestureMangerViewType_Auth_PasswordManage_Close: {
            
            break;
        }
        case FABGestureMangerViewType_UnLock: {
            
            [self createGestureUnLockViewController];
            break;
        }
    }
}

- (void)clearViewController:(UIViewController *)viewController
{
    if(viewController) {
        
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
        [viewController.view removeFromSuperview];
        viewController.view = nil;
        viewController = nil;
    }
}

- (void)createGestureSettingViewControllerWithViewType:(FABGestureMangerViewType)viewType
{
    self.setPasswordController = [[FABGestureSettingViewController alloc] init];
    self.setPasswordController.curViewType = viewType;
    [self ss_addChildViewController:self.setPasswordController atFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    __weak   typeof(self)  weakSelf = self;
    self.setPasswordController.hideMainVCBlock = ^(BOOL animation) {
        
        //hide
        [weakSelf hide:animation];
        if (weakSelf.operationBlock) {
            weakSelf.operationBlock(YES);
        }
    };
    
}


- (void)createGestureUnLockViewController
{
    self.gestureUnLockController = [[FABGestureUnLockViewController alloc] init];
    [self ss_addChildViewController:self.gestureUnLockController atFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    __weak   typeof(self)  weakSelf = self;
    self.gestureUnLockController.forgetPasswordBlock = ^() {
        
        //忘记手势密码
        weakSelf.showLoginType = FABGestureForgotShowLoginType;
        [weakSelf toSecurityView];
        
    };
    
    self.gestureUnLockController.otherLoginBlock = ^() {
        
        //其他方式登录
        [weakSelf clearUserData];
        [weakSelf hide:NO];
        if (weakSelf.operationBlock) {
            weakSelf.operationBlock(NO);
        }
//        [FABAppDelegate windowRootWithType:FABWindowRootTypeIdentity];
        
    };
    
    self.gestureUnLockController.hideMainVCBlock = ^(BOOL animation) {
        
        [weakSelf hide:animation];
        if (weakSelf.operationBlock) {
            weakSelf.operationBlock(YES);
        }
    };
    
    self.gestureUnLockController.maxCountErrorBlock = ^() {
        
        //达到最大错误次数
//        [weakSelf clearUserData];
//        [weakSelf hide:NO];
        if (weakSelf.operationBlock) {
            weakSelf.operationBlock(NO);
        }
        
        [weakSelf showAlertView];
        
    };
}

-(void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sorry",nil) message:@"您手势密码验证失败次数已达5次，是否继续验证密保问题！"preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Exit immediately",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        exit(0);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Verify security question",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self toSecurityView];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)toSecurityView
{
    FABSecurityViewController *securityView = [[FABSecurityViewController alloc] init];
    securityView.isToAuth = YES;
    [self presentViewController:securityView animated:YES completion:^{
        
    }];
}


-(void)clearUserData
{
    [self.myEntity clearGesture];
    [self upDateGestureEntity];
}


- (void)skipToTabBar
{
    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate skipToTabBar];
    
}

-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.myEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
}

-(void)getGestureEntity{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(myData){
        self.myEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
}

@end
