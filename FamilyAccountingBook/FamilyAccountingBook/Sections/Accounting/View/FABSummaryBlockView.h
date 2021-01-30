//
//  FABSummaryBlockView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/8.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FABSummaryBlockView : UIView


@property (nonatomic, strong) UILabel *valueLabel;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color;
@end
