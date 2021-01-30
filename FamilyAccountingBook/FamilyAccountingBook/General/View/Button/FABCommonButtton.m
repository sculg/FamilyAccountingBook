//
//  FABCommonButtton.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABCommonButtton.h"
#import "UIImage+ConvertToUIImageAddtions.h"


@implementation FABCommonButtton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.titleLabel.font = kFontSize(15);
//        [self setBackgroundImage:[UIImage imageWithColor:kButtonNormalColor] forState:UIControlStateNormal];
//        [self setBackgroundImage:[UIImage imageWithColor:kButtonHighlightColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageWithColor:kButtonDisableColor] forState:UIControlStateDisabled];
//        [self setTitleColor:kButtonTitleColor forState:UIControlStateNormal];
//        [self setTitleColor:kButtonTitleColor forState:UIControlStateHighlighted];
        [self setTitleColor:kButtonDisableTitleColor forState:UIControlStateDisabled];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 2.0f, 0.0f, 2.0f);
    }
    return self;
}

-(void)setSubmitBtnBackgroundColor:(UIColor *)backgroundColor
                          forState:(UIControlState)controlState{
    
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor]
                    forState:controlState];
    
}

-(void)setSubmitBtnBackgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                          forState:(UIControlState)controlState{
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:controlState];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitle:title forState:controlState];
}

@end
