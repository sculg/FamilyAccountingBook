//
//  FABAccountingButtonCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"
#import "FABCommonButtton.h"


typedef void (^BtnPressedBlock)();


@interface FABAccountingButtonCell : FABBaseTableViewCell

@property (nonatomic, strong) FABCommonButtton *button;

@property (nonatomic, copy) BtnPressedBlock btnPressedBlock;


-(void)configButtonWithTitle:(NSString *)title;

-(void)configButtonWithTitle:(NSString *)title
                   topOffset:(CGFloat)topOffset;

-(void)configButtonWithTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                     bgColor:(UIColor *)bgColor
                   topOffset:(CGFloat)topOffset;

@end
