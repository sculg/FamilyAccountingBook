//
//  FABGestureUnLockViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/* 忘记手势密码 */
typedef void(^XNLGestureForgetPasswordHandlerBlock)();

/* 其他登录方式 */
typedef void(^XNLGestureOtherLoginHandlerBlock)();

/* 隐藏mainVC */
typedef void(^XNLGestureHideMainControllerHandlerBlock)(BOOL animation);

/* 达到最大错误次数 */
typedef void(^XNLGestureMaxCountErrorHandlerBlock)();

@interface FABGestureUnLockViewController : FABBaseViewController

@property(nonatomic, copy)XNLGestureForgetPasswordHandlerBlock forgetPasswordBlock;

@property(nonatomic, copy)XNLGestureOtherLoginHandlerBlock otherLoginBlock;

@property(nonatomic, copy)XNLGestureHideMainControllerHandlerBlock hideMainVCBlock;

@property(nonatomic, copy)XNLGestureMaxCountErrorHandlerBlock maxCountErrorBlock;


@end

NS_ASSUME_NONNULL_END
