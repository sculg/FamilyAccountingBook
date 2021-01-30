//
//  KKGestureLockView.h
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKGestureLockItemView.h"

@class KKGestureLockView;

@protocol KKGestureLockViewDelegate <NSObject>
@optional
- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;
@end

@interface KKGestureLockView : UIView

@property (nonatomic, assign) CGSize buttonSize;

@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) BOOL isShowInner;
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, weak) id<KKGestureLockViewDelegate> delegate;

/*
 清空手势数据
*/
-(void)clearPasscode;

/*
 显示出错情况
 */
-(void)showErrorState;

/*
 设置手势
*/
- (void)setGestureWithPasscode:(NSString *)passcode;
@end
