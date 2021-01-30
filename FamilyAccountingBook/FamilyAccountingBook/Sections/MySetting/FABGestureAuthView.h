//
//  FABGestureAuthView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "KKGestureLockView.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FABGestureAuthView : UIView

- (instancetype)initWithFrame:(CGRect)frame GestureDelegate:(id<KKGestureLockViewDelegate>)touchDelegate;

//top手势密码
@property (nonatomic, strong, readonly) KKGestureLockView *topGestureView;

//状态 + 手势密码
@property (nonatomic, strong, readonly) UILabel *stateLabel;
@property (nonatomic, strong, readonly) KKGestureLockView *bodyGestureView;


- (void)setStateWithText:(NSString *)stateText Color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
