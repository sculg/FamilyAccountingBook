//
//  UILabel+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>



#define SSTextAttrItem(text, font, color) [SSTextAttributedItem itemWithText:(text) Font:(font) Color:(color)]

@interface SSTextAttributedItem : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor  *color;
@property (nonatomic, strong) UIFont   *font;

+ (instancetype)itemWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color;




@end


@interface UILabel (SSToolkitAdditions)

#pragma mark - 设置标题
-(void)ss_setText:(NSString *)text
             Font:(UIFont *)font
        TextColor:(UIColor *)textColor
  BackgroundColor:(UIColor *)backgroundColor;




//设置属性文本
-(void)ss_setAttributeText:(NSString *)text
                      Font:(UIFont *)font
                 TextColor:(UIColor *)textColor
           BackgroundColor:(UIColor *)backgroundColor;


//设置属性文本
- (void)ss_setAttrTextWithItems:(NSArray *)itemArr;


- (void)ss_setParagraphStyle:(NSParagraphStyle *)paragraphStyle;


+ (NSMutableAttributedString *)ss_attributedStringWithAttrItemArr:(NSArray *)attrItemArr;



+ (NSMutableParagraphStyle *)ss_paragraphStyleWithAlignment:(NSTextAlignment)aligment
                                                  lineSpace:(CGFloat)lineSpace;




#pragma mark - 计算frame
//计算size
- (CGSize)ss_suggestedSizeForWidth:(CGFloat)width;

//根据文本计算所需size
- (CGSize)ss_suggestSizeForString:(NSString *)string width:(CGFloat)width;


//根据文本计算所需size
+ (CGSize)ss_suggestSizeForString:(NSString *)string Font:(UIFont *)font width:(CGFloat)width;


+ (CGSize)ss_suggestedSizeForAttrItem:(SSTextAttributedItem *)attrItem Width:(CGFloat)width;

//根据属性文本计算所需size
+ (CGSize)ss_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;

@end
