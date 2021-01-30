//
//  FABSegmentView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABSegmentView.h"

static const CGFloat kBottomLineWidth = 50.0f;

@interface FABSegmentView ()

/** 底部水平线（不滚动） */
@property (nonatomic, strong) UIView *horizonLineView;

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

/** 按钮标题数组 */
@property (nonatomic, copy) NSArray<NSString *> *titles;

/** 选择索引位置 */
@property (nonatomic, assign) NSInteger selectedIndex;

/** 底部水平标签线（滚动） */
@property (nonatomic, strong) UIView *bottomTagView;

/** 点击切换动画 */
@property (nonatomic, assign) BOOL isAnimating;

@end


@implementation FABSegmentView

#pragma mark - Initialize Methods

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titiles selectedIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = [titiles copy];
        if (index >= 0 && index < _titles.count) {
            _selectedIndex = index;
        }
        [self setupLayout];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (selectedIndex >= 0 && selectedIndex < self.titles.count) {
        [self updateButtonStatusWithSelectedButton:self.buttons[selectedIndex] animated:animated];
    }
}

- (void)setBottomLineOriginX:(CGFloat)originX
{
    if (self.isAnimating) {
        return;
    }
    CGRect rect = self.bottomTagView.frame;
    rect.origin.x = originX;
    self.bottomTagView.frame = rect;
}

- (void)setLineViewHidden {
    self.lineView.hidden = YES;
}

#pragma mark - Private Methods

- (void)setupLayout
{
    self.backgroundColor = kWhiteColor;
    
    self.horizonLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.bounds) - 0.5f, CGRectGetWidth(self.bounds), 0.5f)];
    self.horizonLineView.backgroundColor = kTCellLineMiddleColor;
    [self addSubview:self.horizonLineView];
    
    [self addSubview:self.bottomTagView];
    
    NSInteger buttonCount = self.titles.count;
    CGFloat buttonWidth = CGRectGetWidth(self.bounds) / buttonCount;
    CGFloat buttonHeight = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth * i, 0.0f, buttonWidth, buttonHeight);
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = kFontSize(18);
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(touchUpOutsideAction:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
    [self updateButtonStatusWithSelectedButton:self.buttons[self.selectedIndex] animated:NO];
}

- (void)updateButtonStatusWithSelectedButton:(UIButton *)selectedButton animated:(BOOL)animated
{
    [self dimAllButtonsExcept:selectedButton];
    
    CGRect rect = self.bottomTagView.frame;
    rect.origin.x = selectedButton.frame.origin.x;
    
    @weakify(self)
    
    if (animated) {
        if (self.isAnimating) {
            self.isAnimating = YES;
            
            [UIView animateWithDuration:0.3f animations:^{
                @strongify(self)
                
                self.bottomTagView.frame = rect;
            } completion:^(BOOL finished) {
                @strongify(self)
                
                self.isAnimating = NO;
            }];
        }
    }
    else {
        self.bottomTagView.frame = rect;
    }
}

#pragma mark - Event

- (void)touchUpInsideAction:(UIButton *)button
{
    [self updateButtonStatusWithSelectedButton:button animated:YES];
    
    self.selectedIndex = [self.buttons indexOfObject:button];
    if (self.selectedBlock) {
        self.selectedBlock(self.selectedIndex);
    }
}

- (void)touchUpOutsideAction:(UIButton *)button
{
    [self dimAllButtonsExcept:[self.buttons objectAtIndex:self.selectedIndex]];
}

- (void)touchDownAction:(UIButton *)button
{
    [self dimAllButtonsExcept:button];
}

- (void)dimAllButtonsExcept:(UIButton *)selectedButton
{
    for (UIButton *button in self.buttons) {
        if (button == selectedButton) {
            button.selected = YES;
            button.highlighted = button.selected ? NO : YES;
        }
        else {
            button.selected = NO;
            button.highlighted = NO;
        }
    }
}

#pragma mark - Property

- (UIView *)bottomTagView
{
    if (!_bottomTagView) {
        CGFloat height = 1.0f;
        CGFloat width = CGRectGetWidth(self.bounds) / self.titles.count;
        CGFloat colorWidth = kBottomLineWidth;
        _bottomTagView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.bounds) - height, width, height)];
        
        UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake((width - colorWidth)/2, 0, colorWidth, height)];
        colorView.backgroundColor = kHighlightedTextColor;
        [_bottomTagView addSubview:colorView];
    }
    return _bottomTagView;
}

- (NSMutableArray<UIButton *> *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIView *)bottomLineView
{
    return self.bottomTagView;
}

- (UIView *)lineView
{
    return self.horizonLineView;
}

@end
