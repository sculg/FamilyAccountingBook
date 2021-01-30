//
//  UITextField+SSToolkitAdditions.h
//  
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+SSToolkitAdditions.h"

@interface UITextField (SSToolkitAdditions)



- (void)ss_setTextAttrItem:(SSTextAttributedItem *)textAttrItem
             PlaceAttrItem:(SSTextAttributedItem *)placeAttrItem;


- (void)ss_setTitle:(NSString *)title
               Font:(UIFont *)font
              Color:(UIColor *)colo;

- (void)ss_setPlaceHolderTitle:(NSString *)placeHolderTitle
                          font:(UIFont *)font
                         color:(UIColor *)color;


- (void)ss_setKeyboardType:(UIKeyboardType)keyboardType
                    Secure:(BOOL)secure
                  Delegate:(id)delegate;



- (void)ss_selectAllText;

- (void)ss_setSelectedRange:(NSRange)range;

@end
