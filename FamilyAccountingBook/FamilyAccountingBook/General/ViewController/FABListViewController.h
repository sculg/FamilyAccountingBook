//
//  FABListViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseViewController.h"
#import "FABTableViewSectionView.h"

@interface FABListViewController : FABBaseViewController

/**
 *  列表数据
 */
@property (nonatomic, strong) NSMutableArray *entities;
/**
 *  列表
 */
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UITableView *tableView;

/**
 *  隐藏上拉刷更多
 */
@property (nonatomic, assign) BOOL hideFooterLoadMore;
/**
 *  键盘弹起，表格自适应Textfield位置  YES:自适应  NO:不自适应
 *  默认为NO
 */
@property (nonatomic, assign) BOOL resizeWhenKeyboardPresented;

/**
 *  自动画Cell线
 *
 *  @param cell         需要画线的Cell
 *  @param indexPath    列表的indexPath
 */
- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath leftOffset:(CGFloat)leftOffset;
- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath leftOffset:(CGFloat)leftOffset rowHeight:(CGFloat)rowHeight;

@end
