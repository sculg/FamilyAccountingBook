//
//  FABGestureMainViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseViewController.h"
#import "GesturePasswordConstants.h"

typedef void(^FABGestureOperationSuccessed)(BOOL);

NS_ASSUME_NONNULL_BEGIN
@interface FABGestureMainViewController : FABBaseViewController

@property (nonatomic, copy) FABGestureOperationSuccessed operationBlock;

-(void)changeViewWithType:(FABGestureMangerViewType)viewType;


/**
 是不是一定弹出手势密码  (在启动app时如果已设置则一定弹出 如果进入后台之后 再进入前台则需要满足时间要求)
 
 @param definite 是否一定弹出 YES 为一定弹出
 */
+ (FABGestureMainViewController *)showMainGestureDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type;

+ (FABGestureMainViewController *)showMainGestureDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type animate:(BOOL)isAnimate;


/**
 根据类型和是否立即弹出 返回是否弹出手势解锁
 
 @param definite 是否一定弹出 YES 为一定弹出
 @param type     手势密码的类型
 
 @return 是否可以弹出
 */
+ (BOOL)isCanShowMainGestureWithDefinitely:(BOOL)definite type:(FABGestureMangerViewType)type ;


@end
NS_ASSUME_NONNULL_END
