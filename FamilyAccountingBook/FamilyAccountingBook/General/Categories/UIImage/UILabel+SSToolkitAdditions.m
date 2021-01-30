//
//  UILabel+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UILabel+SSToolkitAdditions.h"



@implementation SSTextAttributedItem


- (instancetype)initWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color
{
    self = [super init];
    if (self) {
        
        self.text = text;
        self.font = font;
        self.color = color;
    }
    return self;
}



+ (instancetype)itemWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color
{
    
    return [[SSTextAttributedItem alloc] initWithText:text Font:font Color:color];
}





@end

@implementation UILabel (SSToolkitAdditions)


-(void)ss_setText:(NSString *)text
             Font:(UIFont *)font
        TextColor:(UIColor *)textColor
  BackgroundColor:(UIColor *)backgroundColor {

    self.text = text;
    
    
    if (font) {
        self.font = font;
    } else {
        self.font = [UIFont systemFontOfSize:15];
    }

    //文本默认黑色
    if (textColor) {
        self.textColor = textColor;
    } else {
        self.textColor = [UIColor blackColor];
    }
    
    //背景色默认为clearColor
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}




+ (NSMutableParagraphStyle *)ss_paragraphStyleWithAlignment:(NSTextAlignment)aligment
                                               lineSpace:(CGFloat)lineSpace
{
//        //调整行间距
//        NSMutableParagraphStyle *paragraphStyleAA = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyleAA.alignment              = NSTextAlignmentCenter;        //对齐方式
//        paragraphStyleAA.lineSpacing            = 9.0;                          //字体的行间距
//        paragraphStyleAA.firstLineHeadIndent    = 0.0;                          //首行缩进
//        paragraphStyleAA.headIndent             = 0.0;                          //整体缩进(首行除外)
//        paragraphStyleAA.lineBreakMode          = NSLineBreakByTruncatingTail;  //结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
//        paragraphStyleAA.headIndent             = 20;                           //整体缩进(首行除外)
//        paragraphStyleAA.tailIndent             = 20;                           //
//        paragraphStyleAA.minimumLineHeight      = 10;                           //最低行高
//        paragraphStyleAA.maximumLineHeight      = 20;                           //最大行高
//        paragraphStyleAA.paragraphSpacing       = 15;                           //段与段之间的间距
//        paragraphStyleAA.paragraphSpacingBefore = 22.0f;                        //段首行空白空
    
    
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.alignment = aligment;                            //对齐方式
    //paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    if (lineSpace > 0) {
        paragraphStyle.lineSpacing = lineSpace;                     //字体的行间距
    }
    
    return paragraphStyle;
}





-(void)ss_setAttributeText:(NSString *)text
                      Font:(UIFont *)font
                 TextColor:(UIColor *)textColor
           BackgroundColor:(UIColor *)backgroundColor {
    
    if (!text) {
        text = @"";
    }
    
    if (!font) {
        font = [UIFont systemFontOfSize:15];
    }
    
    //文本默认黑色
    if (!textColor) {
        textColor = [UIColor blackColor];
    }

    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    //(字体，颜色)属性
    NSDictionary *attrDic = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:textColor};
    [attrStr addAttributes:attrDic range:NSMakeRange(0, text.length)];

    self.attributedText = attrStr;
    
    //背景色默认为clearColor
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    
}

- (void)ss_setAttrTextWithItems:(NSArray *)itemArr {
    
    NSMutableAttributedString *resultAttrStr =
    [UILabel ss_attributedStringWithAttrItemArr:itemArr];
    
    self.attributedText = resultAttrStr;
}


+ (NSMutableAttributedString *)ss_attributedStringWithAttrItemArr:(NSArray *)attrItemArr
{
    NSMutableAttributedString *resultAttrStr = [[NSMutableAttributedString alloc] init];
    
    for (SSTextAttributedItem *item in attrItemArr) {
        
        NSMutableAttributedString *tempAttrString = [[NSMutableAttributedString alloc] initWithString:item.text];
        [tempAttrString addAttributes:@{
                                        NSFontAttributeName : item.font,
                                        NSForegroundColorAttributeName : item.color
                                        }
                                range:NSMakeRange(0, item.text.length)];
        
        [resultAttrStr appendAttributedString:tempAttrString];
    }
    
    
    return resultAttrStr;
}




/**
 *  设置label的paragraphStyle, 调用该方法之前必须先调用ss_setAttributeText: Font: TextColor: BackgroundColor:
 *
 *  @param paragraphStyle
 */
- (void)ss_setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    
    //(字体，颜色)属性
    NSDictionary *attrDic = @{NSParagraphStyleAttributeName:paragraphStyle};
    
    if (self.attributedText) {
        NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [temp addAttributes:attrDic range:NSMakeRange(0, [self.attributedText.string length])];
        self.attributedText = temp;
    }
}



#pragma mark - 计算size




//计算size
- (CGSize)ss_suggestedSizeForWidth:(CGFloat)width {
    
    CGSize size = CGSizeZero;
    if (self.attributedText) {
        size = [UILabel ss_suggestSizeForAttributedString:self.attributedText width:width];
    } else {
        size = [UILabel ss_suggestSizeForString:self.text Font:self.font width:width];
    }
    
    return size;
}

//根据文本计算所需size
- (CGSize)ss_suggestSizeForString:(NSString *)string width:(CGFloat)width
{
    CGSize size = CGSizeZero;
    if (string) {
        size = [UILabel ss_suggestSizeForString:string Font:self.font width:width];
    }
    return size;
}








//根据文本计算所需size
+ (CGSize)ss_suggestSizeForString:(NSString *)string Font:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeZero;
    if (string) {
        
        size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil].size;
    }
    
    return size;
}



+ (CGSize)ss_suggestedSizeForAttrItem:(SSTextAttributedItem *)attrItem Width:(CGFloat)width
{
    return [self ss_suggestSizeForString:attrItem.text
                                    Font:attrItem.font
                                   width:width];
}



//根据属性文本计算所需size
+ (CGSize)ss_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    
    CGSize size = CGSizeZero;
    
    if (string) {
        
        size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size;
    }
    
    return size;
    
}




@end
