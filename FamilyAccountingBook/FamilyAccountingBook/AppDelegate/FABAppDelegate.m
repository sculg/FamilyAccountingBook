//
//  FABAppDelegate.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAppDelegate.h"
#import "FABAccountingSummaryEntity.h"
#import "FABAppUtils.h"
#import "FABNavigationController.h"
#import "FABGestureEntity.h"
#import "FABGestureMainViewController.h"
#import "FABTouchIDUnlockViewController.h"
//激光
 #import "JANALYTICSService.h"
//友盟
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件

@interface FABAppDelegate ()

@property (nonatomic, strong)FABGestureEntity *curGestureEntity;
@end

@implementation FABAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self setupAppearance];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.mainViewController;
    [self createMonthRecord];
    [self creatGesturePassword];
    
    if (self.curGestureEntity.touchIDSwithState) {
        UIViewController *topCtl = [FABAppUtils currentVC];
        FABTouchIDUnlockViewController *touchIDVC = [[FABTouchIDUnlockViewController alloc] init];
        touchIDVC.isSetTouchID = NO;
        [topCtl presentViewController:touchIDVC animated:YES completion:nil];
    }else if(self.curGestureEntity.enableGesture) {
        [FABGestureMainViewController showMainGestureDefinitely:YES type:FABGestureMangerViewType_UnLock];
    }
    
    [self statistics];
    
    // 配置友盟SDK产品并并统一初始化
    [UMConfigure setEncryptEnabled:YES]; // optional: 设置加密传输, 默认NO.
//    [UMConfigure setLogEnabled:YES]; // 开发调试时可在console查看友盟日志显示，发布产品必须移除。
#ifdef DEBUG
    [UMConfigure initWithAppkey:@"" channel:@"App Store"];
#else
    [UMConfigure initWithAppkey:@"59a7e91c310c9329c90002f2" channel:@"App Store"];
#endif
    /* appkey: 开发者在友盟后台申请的应用获得（可在统计后台的 “统计分析->设置->应用信息” 页面查看）*/
    return YES;
}

+ (void)gotoMainViewController
{
    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.window.rootViewController != appDelegate.rootNavigationController) {
        appDelegate.window.rootViewController = appDelegate.rootNavigationController;
    }
    
    [appDelegate.rootNavigationController popToRootViewControllerAnimated:NO];
}

- (void)statistics {
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    #ifdef DEBUG
    config.appKey = @"";
    #else
    config.appKey = @"f78f130e8e940ba0fc3824e5";
    #endif
    config.channel = @"channel";
    [JANALYTICSService setupWithConfig:config];
//    [JANALYTICSService setDebug:NO];
}

- (void)skipToTabBar
{
    FABNavigationController* controller_f = (FABNavigationController*)_mainViewController.myTabBarController.selectedViewController;
    controller_f.canDragBack = YES;
    [controller_f popToRootViewControllerAnimated:YES];
}


- (void)setRootOfMainViewController
{
    self.window.rootViewController = self.mainViewController;
}



- (void)setupAppearance
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [UITabBar appearance].barStyle = UIBarStyleBlack;
    [UITabBar appearance].barTintColor = kWhiteColor;
}

/* 先查询是否有本月的月记录，没有则创建一条 */
-(void)createMonthRecord{
    
    LKDBHelper* summaryEntityHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    FABAccountingSummaryEntity *myEntity = [[FABAccountingSummaryEntity alloc] init];
    
    NSArray *monthArray = [summaryEntityHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":[NSDate monthId]} orderBy:@"accountingId desc" offset:0 count:1000];
    if (monthArray.count == 0) {
        myEntity.accountingId = [NSDate monthId];
        myEntity.incomeBudget = @(0.0);
        myEntity.income = @(0.0);
        myEntity.expenditure = @(0.0);
        myEntity.expenditureBudget = @(0.0);
        myEntity.budgetBalance = @([myEntity.expenditureBudget integerValue]- [myEntity.expenditure integerValue]);
        myEntity.cashSurplus = @(0.0);
        [myEntity saveToDB];
    }
}




-(void)creatGesturePassword{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(!myData){
        FABGestureEntity *myEntity = nil;
        //没有当前用户的手势密码，则新建一个GestureInfoEntity
        myEntity = [[FABGestureEntity alloc] init];
        myEntity.errorCount = 5;            //还可以错5次
        myEntity.enableGesture = NO;
        NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:myEntity];
        NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
        [myDefault setObject:data forKey:@"gestureEntity"];
        [myDefault synchronize];
    }
    [self getGestureEntity];
}

- (FABMainViewController *)mainViewController
{
    if (!_mainViewController) {
        _mainViewController = [[FABMainViewController alloc] init];
    }
    return _mainViewController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    [self cacheEnterBackGroundTime];
    [FABGestureMainViewController showMainGestureDefinitely:NO type:FABGestureMangerViewType_UnLock];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self creatGesturePassword];
    ///app即将进入前台
    if (self.curGestureEntity.touchIDSwithState) {
        UIViewController *topCtl = [FABAppUtils currentVC];
        FABTouchIDUnlockViewController *touchIDVC = [[FABTouchIDUnlockViewController alloc] init];
        touchIDVC.isSetTouchID = NO;
        [topCtl presentViewController:touchIDVC animated:YES completion:nil];
    }else if(self.curGestureEntity.enableGesture) {
        [FABGestureMainViewController showMainGestureDefinitely:NO type:FABGestureMangerViewType_UnLock];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self cacheEnterBackGroundTime];
    [self saveContext];
}

- (void)cacheEnterBackGroundTime
{
    [self getGestureEntity];
    if (self.curGestureEntity.enableGesture) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        self.curGestureEntity.enterBackgroundTime = currentTime;
        [self upDateGestureEntity];
    }
    
}

-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.curGestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
}

-(void)getGestureEntity{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(myData){
        self.curGestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FamilyAccountingBook"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
