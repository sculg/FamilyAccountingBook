//
//  FABBaseViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/1.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FABBaseViewController : UIViewController



#pragma mark - Bar Button
/**
 *  左上角关闭按钮
 *
 *  @param pressedSelector 按钮点击方法
 *
 *  @return 按钮
 */
- (UIBarButtonItem *)closeBarItemWithPressedSelector:(SEL)pressedSelector;
/**
 *  左上角白色关闭按钮
 */
- (UIBarButtonItem *)whiteBackBarItem;
/**
 *  返回按钮点击方法，公开用于重写
 *
 *  @param sender 按钮
 */
- (void)backButtonPressed:(nullable id)sender;

/**
 导航栏返回（用于block调用）
 */
- (void)goBackDirection;

/**
 *  添加导航栏上按钮方法
 *
 *  @param title  按钮标题
 *  @param isLeft 是否加在左边
 */
- (void)addBarButtonWithTitle:(NSString *)title isLeft:(BOOL)isLeft;
/**
 *  添加导航栏上按钮方法
 *
 *  @param image  按钮图片
 *  @param isLeft 是否加在左边
 */
- (void)addBarButtonWithImage:(UIImage *)image isLeft:(BOOL)isLeft;
/**
 *  添加导航栏上右边按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)rightBarButtonPressed:(id)sender;
/**
 *  添加导航栏上左边按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)leftBarButtonPressed:(id)sender;

#pragma mark - Custom Push And Pop
/**
 *  Push方法，默认带动画
 *
 *  @param viewController 需要push的viewController
 */
- (void)pushNormalViewController:(UIViewController *)viewController;
/**
 *  先Pop到根，再Push方法，默认带动画
 *
 *  @param viewController 需要push的viewController
 */
- (void)popToRootAndPushNormalViewController:(UIViewController *)viewController;


#pragma mark - Hud
/**
 *  Hud加载动画
 */
//- (void)showHudLoading;


#pragma mark - PINCache
///**
// *  缓存
// *
// *  @param object 需要缓存的对象
// *  @param key    需要缓存的对象的Key
// */
//- (void)cacheObject:(id<NSCoding>)object forKey:(NSString *)key;
///**
// *  取出缓存
// *
// *  @param key 取出缓存的对象的Key
// *
// *  @return 缓存的对象
// */
//- (id<NSCoding>)cacheObjectForKey:(NSString *)key;


NS_ASSUME_NONNULL_END


@end
