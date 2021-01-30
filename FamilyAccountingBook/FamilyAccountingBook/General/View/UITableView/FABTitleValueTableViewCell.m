//
//  FABTitleValueTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABTitleValueTableViewCell.h"

@interface FABTitleValueTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
//@property (nonatomic, strong) UIImageView *bottomLineView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) UIImage *iconImg;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat detailLabelLeftOffset;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign) NSTextAlignment detailAlignment;

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, assign) CGFloat bottomLineViewWidth;

@end

@implementation FABTitleValueTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.bottomLineView];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.backgroundColor = self.bgColor;

    [self.titleLabel ss_setText:self.title
                           Font:kFontSize(16)
                      TextColor:kTitleTextColor
                BackgroundColor:nil];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.detailLabel.textAlignment = self.detailAlignment;


    if (!self.iconImg) {
        self.iconView.hidden = YES;
    }else{
        self.iconView.image = self.iconImg;
    }
    
    @weakify(self);
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(18);
        make.width.height.equalTo(@(25));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(self.leftOffset);
        make.width.equalTo(@(kScreenWidth * 0.80));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@(kScreenWidth - 152));
        make.left.equalTo(@(self.detailLabelLeftOffset));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(@(self.bottomLineViewWidth));
    }];
    
}


#pragma mark - Property
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
    }
    return _detailLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = kTCellLineMiddleColor;
    }
    return _bottomLineView;
}


#pragma mark - public Methods

-(void)configCellWithTitle:(NSString *)title{
    
    [self configCellWithTitle:title
                        image:nil
                       detail:nil];
}

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset{
    
    [self configCellWithImage:nil
                        title:title
              titleLeftOffset:leftOffset
                       detail:nil
              detailAlignment:NSTextAlignmentCenter
        detailLabelLeftOffset:0
                      bgColor:kWhiteColor];
}

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                   bgColor:(UIColor *)bgColor{
    
    self.bottomLineViewWidth = 88;
    [self configCellWithImage:nil
                        title:title
              titleLeftOffset:leftOffset
                       detail:nil
              detailAlignment:NSTextAlignmentCenter
        detailLabelLeftOffset:0
                      bgColor:bgColor];

}

-(void)configCellWithTitle:(NSString *)title
                     image:(NSString *)image{
    
    [self configCellWithTitle:title
                        image:image
                       detail:nil];
}

-(void)configCellWithTitle:(NSString *)title
                    detail:(NSString *)detail{
    
    [self configCellWithTitle:title
              titleLeftOffset:20
                       detail:detail];
//    [self configCellWithTitle:title
//                        image:nil
//                       detail:detail];
}

-(void)configCellWithTitle:(NSString *)title
                     image:(NSString *)image
                    detail:(NSString *)detail{
    
    if (IS_IPAD) {
        [self configCellWithImage:image
                            title:title
                  titleLeftOffset:60
                           detail:detail
                  detailAlignment:NSTextAlignmentRight
            detailLabelLeftOffset:80
                          bgColor:kWhiteColor];
    }else{
    [self configCellWithImage:image
                        title:title
              titleLeftOffset:60
                       detail:detail
              detailAlignment:NSTextAlignmentRight
        detailLabelLeftOffset:110
                      bgColor:kWhiteColor];
    }
    
}

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail{
//    if (IS_IPAD) {
//        [self configCellWithTitle:title
//                  titleLeftOffset:leftOffset
//                           detail:detail
//            detailLabelLeftOffset:kScreenWidth * 0.44];
//    }else{
    [self configCellWithTitle:title
              titleLeftOffset:leftOffset
                       detail:detail
        detailLabelLeftOffset:144];
//    }
}

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail
     detailLabelLeftOffset:(CGFloat)detailLabelLeftOffset{
    
    [self configCellWithImage:nil
                        title:title
              titleLeftOffset:leftOffset
                       detail:detail
              detailAlignment:NSTextAlignmentCenter
        detailLabelLeftOffset:detailLabelLeftOffset
                      bgColor:kWhiteColor];
}


-(void)configCellWithImage:(NSString *)image
                     title:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail
           detailAlignment:(NSTextAlignment)detailAlignment
     detailLabelLeftOffset:(CGFloat)detailLabelLeftOffset
                   bgColor:(UIColor *)bgColor{
    self.title = title;
    self.iconImg = [UIImage imageWithContentsOfFileName:image];
    self.leftOffset = leftOffset;
    self.detailAlignment = detailAlignment;
    self.detailLabelLeftOffset = detailLabelLeftOffset;
    self.bgColor = bgColor;
    [self.detailLabel ss_setText:detail
                            Font:kBoldFontSize(16)
                       TextColor:kBarHighlightedTextColor
                 BackgroundColor:nil];

}

@end
