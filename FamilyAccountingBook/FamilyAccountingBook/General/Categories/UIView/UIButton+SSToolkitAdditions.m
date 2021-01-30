//
//  UIButton+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import "UIButton+SSToolkitAdditions.h"

@implementation UIButton (SSToolkitAdditions)


- (void)ss_setTarget:(id)target Selector:(SEL)selector {
    
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (void)ss_setTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateNormal];
}


- (void)ss_setTitle:(NSString *)title
           TitleFont:(UIFont  *)font
    NormalTitleColor:(UIColor *)normalTitleColor
 HighLightTitleColor:(UIColor *)highLightTitleColor {
    
    
    [self setTitle:title forState:UIControlStateNormal];
    
    if (font != nil) {
        [self.titleLabel setFont:font];
    }
    
    if (normalTitleColor != nil) {
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    
    if (highLightTitleColor != nil) {
        [self setTitleColor:highLightTitleColor forState:UIControlStateHighlighted];
    }

}


- (void)ss_setTitle:(NSString *)title
          TitleFont:(UIFont  *)font
   NormalTitleColor:(UIColor *)normalTitleColor
 SelectedTitleColor:(UIColor *)selectedTitleColor {
    
    
    [self setTitle:title forState:UIControlStateNormal];
    
    if (font != nil) {
        [self.titleLabel setFont:font];
    }
    
    if (normalTitleColor != nil) {
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    
    if (selectedTitleColor != nil) {
        [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    
}




#pragma mark - 设置图标

- (void)ss_setNormalImage:(UIImage *)normalImage
           HighlightImage:(UIImage *)clickIamge {
    
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (clickIamge != nil) {
        [self setImage:clickIamge forState:UIControlStateHighlighted];
    }
}



- (void)ss_setNormalImage:(UIImage *)normalImage
            SelectedImage:(UIImage *)selectedImage {
    
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
        
    
    if (selectedImage != nil) {
        [self setImage:selectedImage forState:UIControlStateHighlighted];
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}


#pragma mark - 设置背景图

- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
           HighlightBGImage:(UIImage *)clickBGIamge {
    
    if (normalBGImage != nil) {
        [self setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    }
    
    if (clickBGIamge != nil) {
        [self setBackgroundImage:clickBGIamge forState:UIControlStateHighlighted];
    }
}




- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
           SelectedBGImage:(UIImage *)selectedBGIamge {
    
    if (normalBGImage != nil) {
        [self setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    }

    if (selectedBGIamge != nil) {
        [self setBackgroundImage:selectedBGIamge forState:UIControlStateSelected];
    }
}






- (void)layoutButtonWithEdgeInsetsStyle:(SSButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
   
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    if (labelWidth == 0) {
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        labelWidth = titleSize.width;
    }
    
    CGFloat imageInsetsTop    = 0.0f;
    CGFloat imageInsetsLeft   = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight  = 0.0f;

    CGFloat titleInsetsTop    = 0.0f;
    CGFloat titleInsetsLeft   = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight  = 0.0f;
    
    switch (style) {
        case SSButtonEdgeInsetsStyleImageRight:
        {
            space = space * 0.5;
            
            imageInsetsLeft = labelWidth + space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = - (imageViewWidth + space);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case SSButtonEdgeInsetsStyleImageLeft:
        {
            space = space * 0.5;
            
            imageInsetsLeft = -space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = space;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
        case SSButtonEdgeInsetsStyleImageBottom:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5 - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
            
        }
            break;
        case SSButtonEdgeInsetsStyleImageTop:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5 - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}



@end
