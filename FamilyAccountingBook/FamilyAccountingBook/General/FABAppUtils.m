//
//  FABAppUtils.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAppUtils.h"
#import "FABAppDelegate.h"
#import "FABBaseViewController.h"
#import "FABNavigationController.h"

@implementation FABAppUtils

#pragma mark - Private Methods

+ (UIViewController *)findCurrentVC:(UIViewController *)vc {
    
    if (vc.presentedViewController) {
        return [self findCurrentVC:vc.presentedViewController];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count) {
            return [self findCurrentVC:svc.topViewController];
        }
        else {
            return vc;
        }
    }
    else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count) {
            return [self findCurrentVC:svc.selectedViewController];
        }
        else {
            return vc;
        }
    }
    else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count) {
            return [self findCurrentVC:svc.viewControllers.lastObject];
        }
        else {
            return vc;
        }
        
    }
    else {
        return vc;
    }
}

#pragma mark - Public Methods

+ (UIWindow *)keyWindow {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return keyWindow;
}

+ (UIViewController *)windowRootVC {
    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    return rootVC;
}

+ (UINavigationController *)windowRootNC {
    
    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    if ([rootVC.navigationController isKindOfClass:[UINavigationController class]]) {
        return rootVC.navigationController;
    }
    return nil;
}


+ (UIViewController *)currentVC {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findCurrentVC:vc];
}


+ (FABBaseViewController *)currentViewController
{
    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
    FABNavigationController *navigationController = (FABNavigationController *)appDelegate.mainViewController.tabBarController.selectedViewController;
    FABBaseViewController *currentViewController = (FABBaseViewController *)navigationController.visibleViewController;
    if (!currentViewController.navigationController) {
        return (FABBaseViewController *)navigationController.topViewController;
    }
    else {
        return currentViewController;
    }
}

@end
