//
//  FABGestureSettingViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseViewController.h"
#import "GesturePasswordConstants.h"
#import "FABGestureUnLockViewController.h"


NS_ASSUME_NONNULL_BEGIN


@interface FABGestureSettingViewController : FABBaseViewController

@property(nonatomic, assign)FABGestureMangerViewType curViewType;

@property(nonatomic, copy)XNLGestureHideMainControllerHandlerBlock hideMainVCBlock;

@end


NS_ASSUME_NONNULL_END
