//
//  FABSummaryBlockView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/8.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABSummaryBlockView.h"
@interface FABSummaryBlockView()
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FABSummaryBlockView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
        self.title = title;
        [self setupSubViews];
        [self setupContaints];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.colorView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
}

- (void)setupContaints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(36.0f);
        make.top.equalTo(self);
    }];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.0f);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(16.0f, 16.0f));
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2.0f);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(@(kScreenWidth*0.30));
    }];
}

- (UIView *)colorView{
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = self.color;
        _colorView.layer.cornerRadius = 8;
        _colorView.layer.masksToBounds = YES;

    }
    return _colorView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFontSize(14);
        _titleLabel.text = self.title;
        _titleLabel.textColor = UIColorFromRGB(0x222222);
    }
    return _titleLabel;
}
- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = UIColorFromRGB(0x222222);
        _valueLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _valueLabel;
}
@end
