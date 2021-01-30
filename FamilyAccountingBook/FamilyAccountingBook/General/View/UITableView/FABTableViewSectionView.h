//
//  FABTableViewSectionView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FABTableViewSectionView : UITableViewHeaderFooterView

- (void)configHeadViewWithTitle:(NSString *)title;

- (void)configHeadViewWithTitle:(NSString *)title titleFont:(UIFont *)font value:(NSString *)value isTitleCenter:(BOOL)isCenter;

- (void)configHeadViewWithTitle:(NSString *)title value:(NSString *)value;

- (void)configHeadViewWithTitle:(NSString *)title titleLeftOffset:(CGFloat)leftOffset;


@end
