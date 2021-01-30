//
//  FABSettingManager.m
//  FamilyAccountingBook
//
//  Created by lg on 2021/1/30.
//  Copyright © 2021 com.familyaccountingbook. All rights reserved.
//

#import "FABSettingManager.h"
#import "FABAllTreasureViewController.h"
#import "FABRouter.h"

@implementation FABSettingManager

+ (instancetype)sharedInstance
{
    static FABSettingManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)load {
    [FABRouter registerURLPattern:@"FAB://Setting/AllTreasureVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navi = routerParameters[FABRouterParameterUserInfo][@"navigation"];
        FABAllTreasureViewController *VC = [[FABAllTreasureViewController alloc] init];
        [navi pushViewController:VC animated:YES];
    }];
}
@end
