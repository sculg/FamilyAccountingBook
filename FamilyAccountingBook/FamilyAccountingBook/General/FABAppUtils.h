//
//  FABAppUtils.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FABBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FABAppUtils : NSObject

/**
 keyWindow
 
 @return keyWindow
 */
+ (UIWindow *)keyWindow;

/**
 *  Window Root VC
 *
 *  @return VC
 */
+ (UIViewController *)windowRootVC;

/**
 *  Window Root NC
 *
 *  @return NC
 */
+ (UINavigationController *)windowRootNC;

/**
 *  获取当前VC
 *
 *  @return UIViewController
 */
+ (UIViewController *)currentVC;


+ (FABBaseViewController *)currentViewController;
@end

NS_ASSUME_NONNULL_END
