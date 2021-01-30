//
//  FABFontMacro.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#ifndef FABFontMacro_h
#define FABFontMacro_h
#define kFontSizeScale autoSizeScale()

//#define kFontSize(x)         [UIFont systemFontOfSize:(x) * kFontSizeScale]
//#define kBoldFontSize(x)     [UIFont boldSystemFontOfSize:(x) * kFontSizeScale]

#define kFontSize(x)         [UIFont systemFontOfSize:(x)]
#define kBoldFontSize(x)     [UIFont boldSystemFontOfSize:(x)]

//屏幕尺寸
#define kScreenWidth                            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight                           ([UIScreen mainScreen].bounds.size.height)


#define kCashUnit                             [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrencyUnit"] ? :  NSLocalizedString(@"¥",nil)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define YYISiPhoneX [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& YYIS_IPHONE
#define YYIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//状态栏高度
#define kStatusBarHeight            (CGFloat)(YYISiPhoneX?(44):(20))
// 导航栏高度
#define kNavBarHBelow7              (44)
// 状态栏和导航栏总高度
#define kNavBarHAbove7              (CGFloat)(YYISiPhoneX?(88):(64))
// TabBar高度
#define kTabBarHeight               (CGFloat)(YYISiPhoneX?(49+34):(49))
// 顶部安全区域远离高度
#define kTopBarSafeHeight           (CGFloat)(YYISiPhoneX?(44):(0))
// 底部安全区域远离高度
#define kBottomSafeHeight           (CGFloat)(YYISiPhoneX?(34):(0))
// iPhoneX的状态栏高度差值
#define kTopBarDifHeight            (CGFloat)(YYISiPhoneX?(24):(0))

#endif /* FABFontMacro_h */
