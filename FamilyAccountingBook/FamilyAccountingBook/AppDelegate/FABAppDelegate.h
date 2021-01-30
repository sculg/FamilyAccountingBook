//
//  AppDelegate.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FABMainViewController.h"
#import "FABNavigationController.h"
#import "FABSecurityViewController.h"
#import "FABSecurityViewController.h"


@interface FABAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) FABNavigationController *rootNavigationController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) FABMainViewController *mainViewController;

@property (nonatomic, strong) FABSecurityViewController *securityViewController;

- (void)saveContext;

- (void)skipToTabBar;
- (void)setRootOfMainViewController;

+ (void)gotoMainViewController;


@end

