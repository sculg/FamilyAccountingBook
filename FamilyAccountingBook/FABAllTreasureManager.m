//
//  FABAllTreasureManager.m
//  FABAllTreasure
//
//  Created by lg on 2021/1/31.
//

#import "FABAllTreasureManager.h"
#import "FABAllTreasureVC.h"
#import "FABRouter.h"

@implementation FABAllTreasureManager

+ (instancetype)sharedInstance
{
    static FABAllTreasureManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)load {
    [FABRouter registerURLPattern:@"FAB://Setting/AllTreasureVC" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navi = routerParameters[FABRouterParameterUserInfo][@"navigation"];
        FABAllTreasureVC *VC = [[FABAllTreasureVC alloc] init];
        [navi pushViewController:VC animated:YES];
    }];
}

@end
