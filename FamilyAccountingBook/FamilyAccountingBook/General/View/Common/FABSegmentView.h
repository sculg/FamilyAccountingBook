//
//  FABSegmentView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^XNOSegmentViewSelectedIndexBlock)(NSInteger index);

@interface FABSegmentView : UIView

/** 点击触发Block回调 */
@property (nonatomic, copy, nullable) XNOSegmentViewSelectedIndexBlock selectedBlock;

/** 按钮数组 */
@property (nonatomic, strong, readonly) NSMutableArray<UIButton *> *buttons;

/** 底部水平线（不滚动） */
@property (nonatomic, strong, readonly) UIView *horizonLineView;

/** 底部水平标签线（滚动） */
@property (nonatomic, strong, readonly) UIView *bottomLineView;

/** 选择索引位置 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

/** 底部分割线视图 */
@property (nonatomic, strong, readonly) UIView *lineView;

/** 底部水平标签线（滚动） */
@property (nonatomic, strong, readonly) UIView *bottomTagView;

/** 禁止构造方法 */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithSize:(CGSize)size NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/** 指定构造方法 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titiles selectedIndex:(NSInteger)index;

/** 设置索引位置 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/** 设置底部线滚动位置 */
- (void)setBottomLineOriginX:(CGFloat)originX;

/** 隐藏底部分隔线 */
- (void)setLineViewHidden;

@end

NS_ASSUME_NONNULL_END
