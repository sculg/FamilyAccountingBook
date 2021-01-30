//
//  KKGestureLockItemView.h
//  XNOnline
//
//  Created by xia on 15/5/14.
//  Copyright (c) 2015年 xiaoniu88. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KKGesture_NormalColor       UIColorFromRGB(0xc6c6c6)
#define KKGesture_SelectColor       UIColorFromRGB(0xff632c)
#define KKGesture_Select_Line_Color UIColorFromRGBA(0xff632c,0.13)

#define KKGesture_ErrorColor        UIColorFromRGB(0xff0000)
#define KKGesture_Error_Line_Color  UIColorFromRGBA(0xff0000,0.13)

/*
 手势密码节点itemview
*/

typedef NS_ENUM(NSInteger, KKGestureLockItemType) {
    KKGestureLockItemTypeNormal = 0x20,
    KKGestureLockItemTypeSelect,
    KKGestureLockItemTypeError,
};

@interface KKGestureLockItemView : UIView
@property (nonatomic ,assign)CGFloat nodeWith;
@property (nonatomic, assign) BOOL isShowInner;
-(void)setItemViewType:(KKGestureLockItemType)type;
-(KKGestureLockItemType)getDrawType;
@end
