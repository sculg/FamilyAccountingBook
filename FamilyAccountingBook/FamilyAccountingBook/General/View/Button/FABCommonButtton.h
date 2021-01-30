//
//  FABCommonButtton.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface FABCommonButtton : UIButton

-(void)setSubmitBtnBackgroundColor:(UIColor *)backgroundColor
                          forState:(UIControlState)controlState;

-(void)setSubmitBtnBackgroundColor:(UIColor *)backgroundColor
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                          forState:(UIControlState)controlState;


@end
NS_ASSUME_NONNULL_END
