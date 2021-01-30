//
//  FABColorMacro.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/2.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#ifndef FABColorMacro_h
#define FABColorMacro_h
//#define kDefaultBackgroundColor             UIColorFromRGB(0xF8E2CD)
#define kDefaultBackgroundColor             UIColorFromRGB(0xf4f4f4)


#define UIColorFromRGBA(rgbValue, iAlpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:iAlpha]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0f)

#define kSplitLineColor                     UIColorFromRGB(0xd0d0d0)
#define kBarTitleTextColor                  UIColorFromRGB(0x333333)        //navigationbar tabbar默认字，深灰色
#define kBarHighlightedTextColor            UIColorFromRGB(0xff632c)        //navigationbar tabbar高亮字，橙色
#define kWhiteColor                         UIColorFromRGB(0xffffff)

//淡黄色
#define kPieYellowColor                     UIColorFromRGB(0xF79F79)


//主色 橙红色,用于数字，相关文字的显示

#define kMainCommonColor                    UIColorFromRGB(0xff632c)
#define kHighlightedTextColor               kMainCommonColor        //橙色

//对比色，用于首页button，图标等需要对比突出的地方
#define kMainCommonOppositionColor          UIColorFromRGB(0x87B6A7)
//棕色
#define kMainbroumColor                     UIColorFromRGB(0x5B5941)

#define kbuttonBackgroundColor              kMainCommonOppositionColor

#define kBlueColor                          UIColorFromRGB(0x1874CD)        //浅蓝色


#define kTitleTextColor                     UIColorFromRGB(0x6b6d6f)        //浅色
//CommonColor
#define kCommonColor                        UIColorFromRGB(0x118730)

//Button
#define kButtonNormalColor                  UIColorFromRGB(0xff632c)
#define kButtonHighlightColor               UIColorFromRGB(0xde410a)
#define kButtonDisableColor                 UIColorFromRGB(0xa7a7a7)

#define kButtonTitleColor                   kWhiteColor
#define kButtonDisableTitleColor            kWhiteColor


//Cell
#define kTCellLineTopOrBottomColor          [UIColor clearColor]
#define kTCellLineMiddleColor               UIColorFromRGB(0xe7e7e7)
#define kTCellSelectedColor                 UIColorFromRGB(0xe0e0e0)

//charts 图表配色




#endif /* FABColorMacro_h */
