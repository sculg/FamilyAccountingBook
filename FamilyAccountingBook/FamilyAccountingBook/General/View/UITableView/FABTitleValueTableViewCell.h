//
//  FABTitleValueTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

@interface FABTitleValueTableViewCell : FABBaseTableViewCell

-(void)configCellWithTitle:(NSString *)title;

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset;

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                   bgColor:(UIColor *)bgColor;

-(void)configCellWithTitle:(NSString *)title
                     image:(NSString *)image;

-(void)configCellWithTitle:(NSString *)title
                    detail:(NSString *)detail;

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail;

-(void)configCellWithTitle:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail
     detailLabelLeftOffset:(CGFloat)detailLabelLeftOffset;

-(void)configCellWithTitle:(NSString *)title
                     image:(NSString *)image
                    detail:(NSString *)detail;

-(void)configCellWithImage:(NSString *)image
                     title:(NSString *)title
           titleLeftOffset:(CGFloat)leftOffset
                    detail:(NSString *)detail
           detailAlignment:(NSTextAlignment)detailAlignment
     detailLabelLeftOffset:(CGFloat)detailLabelLeftOffset
                   bgColor:(UIColor *)bgColor;

//-(void)configCellWithTitle:(NSString *)title image:(NSString *)image detail:(NSString *)detail titleLeftOffset:(CGFloat)leftOffset;


@end
