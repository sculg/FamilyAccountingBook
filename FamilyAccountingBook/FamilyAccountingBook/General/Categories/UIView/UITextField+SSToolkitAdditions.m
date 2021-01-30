//
//  UITextField+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import "UITextField+SSToolkitAdditions.h"

@implementation UITextField (SSToolkitAdditions)



- (void)ss_setTextAttrItem:(SSTextAttributedItem *)textAttrItem
             PlaceAttrItem:(SSTextAttributedItem *)placeAttrItem
{
    
    if (textAttrItem) {
        [self ss_setTitle:textAttrItem.text Font:textAttrItem.font Color:textAttrItem.color];
    }
    
    if (placeAttrItem) {
        [self ss_setPlaceHolderTitle:placeAttrItem.text font:placeAttrItem.font color:placeAttrItem.color];
    }
    
    
}


- (void)ss_setTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color {
//    self.text              = title;
//    self.font              = font;
//    self.textColor         = color;

    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = self.font.lineHeight - (self.font.lineHeight - font.lineHeight) / 2.0;
    
    
    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:title];
    
    
    NSDictionary *attrDic = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:color,
                              NSParagraphStyleAttributeName:style};
    [attrString addAttributes:attrDic range:NSMakeRange(0, title.length)];
    
    self.attributedText = attrString;
    
//    // Default property
//    self.returnKeyType                  = UIReturnKeyNext;
//    self.enablesReturnKeyAutomatically  = YES;
//    self.contentVerticalAlignment       = UIControlContentVerticalAlignmentCenter;
//    self.clearButtonMode                = UITextFieldViewModeWhileEditing;
//    self.borderStyle                    = UITextBorderStyleNone;
//    self.autocapitalizationType         = UITextAutocapitalizationTypeNone;
//    self.autocorrectionType             = UITextAutocorrectionTypeNo;
    
}



- (void)ss_setPlaceHolderTitle:(NSString *)placeHolderTitle
                          font:(UIFont *)font
                         color:(UIColor *)color {
    
    
    NSMutableParagraphStyle *style = [self.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = self.font.lineHeight - (self.font.lineHeight - font.lineHeight) / 2.0;
    

    NSMutableAttributedString *attrString =
    [[NSMutableAttributedString alloc] initWithString:placeHolderTitle];
    

    NSDictionary *attrDic = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:color,
                              NSParagraphStyleAttributeName:style};
    [attrString addAttributes:attrDic range:NSMakeRange(0, placeHolderTitle.length)];
    
    self.attributedPlaceholder = attrString;
    
    //self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}




- (void)ss_setKeyboardType:(UIKeyboardType)keyboardType
                    Secure:(BOOL)secure
                  Delegate:(id)delegate {

    self.keyboardType      = keyboardType;
    self.secureTextEntry   = secure;
    self.delegate          = delegate;
    
}






- (void)ss_selectAllText {
    
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)ss_setSelectedRange:(NSRange)range {
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


@end
