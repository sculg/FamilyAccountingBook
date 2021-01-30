//
//  KKGestureLineView.h
//  XNOnline
//
//  Created by xia on 15/11/26.
//  Copyright © 2015年 xiaoniu88. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kTrackedLocationInvalidInContentView = -1.0;

NS_ASSUME_NONNULL_BEGIN
@interface KKGestureLineView : UIView
@property (nonatomic, strong) NSMutableArray *selectedButtons;
@property (nonatomic, assign) CGPoint trackedLocationInContentView;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) BOOL isErrorState;
@end
NS_ASSUME_NONNULL_END