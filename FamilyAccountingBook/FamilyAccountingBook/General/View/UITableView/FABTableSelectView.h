//
//  FABTableSelectView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/1.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FABTableSelectViewBlock)(NSString *selectValue);


@interface FABTableSelectView : UIView

@property(nonatomic, copy) FABTableSelectViewBlock tableSelectedViewBlock;

+ (instancetype)initTableSelectViewWithItems:(NSArray *)tableViewItems
                             curSelectedItem:(NSString *)curSelectedItem
                              selectedResult:(FABTableSelectViewBlock)selectedResult;

+ (instancetype)initTableSelectViewWithTopOffset:(CGFloat)topOffset
                            tableSelectViewItems:(NSArray *)tableViewItems
                                 curSelectedItem:(NSString *)curSelectedItem
                                  selectedResult:(FABTableSelectViewBlock)selectedResult;

+ (instancetype)initTableSelectViewWithTopOffset:(CGFloat)topOffset
                                      leftOffset:(CGFloat)leftOffset
                            tableSelectViewItems:(NSArray *)tableViewItems
                                 curSelectedItem:(NSString *)curSelectedItem
                                  selectedResult:(FABTableSelectViewBlock)selectedResult;

-(void)hideView;

@end
