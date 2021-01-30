//
//  FABTableViewSectionView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABTableViewSectionView.h"

@interface FABTableViewSectionView ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) float titleLeftOffset;
@property (nonatomic, assign) BOOL  isTitleCenter;

@end

@implementation FABTableViewSectionView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.titleLabel];
        [self.containerView addSubview:self.valueLabel];
    }
    return self;
}


#pragma mark - Super Methods

- (void)layoutSubviews {
    UIFont *font = (self.titleFont == nil) ? kFontSize(12) : self.titleFont;
    [self.titleLabel ss_setText:self.title
                           Font:font
                      TextColor:kTitleTextColor
                BackgroundColor:nil];
    
    UIFont *valuefont = (self.titleFont == nil) ? kFontSize(14) : self.titleFont;
    [self.valueLabel ss_setText:self.value
                           Font:valuefont
                      TextColor:kBarHighlightedTextColor
                BackgroundColor:nil];
    
    [self customLayout];

}

- (void)configHeadViewWithTitle:(NSString *)title{
    
    [self configHeadViewWithTitle:title value:nil];
    
}

- (void)configHeadViewWithTitle:(NSString *)title titleFont:(UIFont *)font value:(NSString *)value isTitleCenter:(BOOL)isCenter{
    [self configHeadViewWithTitle:title value:value];
    self.titleFont = font;
    self.isTitleCenter = isCenter;
}

- (void)configHeadViewWithTitle:(NSString *)title titleLeftOffset:(CGFloat)leftOffset{
    [self configHeadViewWithTitle:title value:nil];
    self.titleLeftOffset = leftOffset;
}


- (void)configHeadViewWithTitle:(NSString *)title value:(NSString *)value{
    self.titleLeftOffset = 10.0f;
    self.title = title;
    self.value = value;
}

- (void)customLayout {
    @weakify(self);
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-0);
        make.bottom.equalTo(self).offset(-0);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.containerView);
        if (self.isTitleCenter == YES) {
            make.centerX.equalTo(self);
        }else{
        make.left.equalTo(self.containerView).offset(self.titleLeftOffset);
        }
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.containerView);
        make.right.equalTo(self.containerView.mas_right).offset(-10);
    }];
}

#pragma mark - Property
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = kDefaultBackgroundColor;
        self.containerView.layer.masksToBounds = YES;
        self.containerView.layer.cornerRadius = 3;
    }
    return _containerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
    }
    return _valueLabel;
}



@end
