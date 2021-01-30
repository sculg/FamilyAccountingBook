//
//  FABGestureView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "KKGestureLockView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FABGestureView : UIView

- (instancetype)initWithFrame:(CGRect)frame GestureDelegate:(id<KKGestureLockViewDelegate>)touchDelegate;

/* 标题 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/* 状态 */
@property (nonatomic, strong, readonly) UILabel *stateLabel;


@property (nonatomic, strong, readonly) KKGestureLockView *gestureView;



- (void)setStateWithText:(NSString *)stateText Color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
