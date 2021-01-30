//
//  FABAccountingButtonCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABAccountingButtonCell.h"


@interface FABAccountingButtonCell ()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *bgColor;


@property (nonatomic, assign) CGFloat topOffset;

@end

@implementation FABAccountingButtonCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        [self.contentView addSubview:self.button];
        [self.button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = kTCellLineTopOrBottomColor;
        
    }
    return self;
}

-(void)configButtonWithTitle:(NSString *)title{
    
    [self configButtonWithTitle:title
                     titleColor:kMainCommonColor
                        bgColor:kWhiteColor
                      topOffset:6];
}

-(void)configButtonWithTitle:(NSString *)title topOffset:(CGFloat )topOffset{
    
    [self configButtonWithTitle:title
                     titleColor:kMainCommonColor
                        bgColor:kWhiteColor
                      topOffset:topOffset];
}

-(void)configButtonWithTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                     bgColor:(UIColor *)bgColor
                   topOffset:(CGFloat)topOffset{
    
    self.title = title;
    self.topOffset = topOffset;
    self.bgColor = bgColor;
    self.titleColor = titleColor;
    
    [self customLayout];
}

-(void)buttonPressed{
    if (_btnPressedBlock) {
        _btnPressedBlock();
    }
}


#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.backgroundColor = self.bgColor;
    [self.button setSubmitBtnBackgroundColor:self.bgColor
                                       title:self.title
                                  titleColor:self.titleColor
                                    forState:UIControlStateNormal];
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 230.0/255, 230.0/255, 230.0/255, 1 });
//    [self.button.layer setBorderColor:colorref];
//    CGColorSpaceRelease(colorSpace);
//    CGColorRelease(colorref);
//    [self.button.layer setMasksToBounds:YES];
//    [self.button.layer setBorderWidth:0.5];
}

- (void)customLayout {
    @weakify(self);
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.top.equalTo(self).offset(_topOffset);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-6);
        
    }];
    
}

#pragma mark - Property
- (FABCommonButtton *)button {
    if (!_button) {
        _button = [[FABCommonButtton alloc] init];
    }
    return _button;
}



@end
