//
//  FABBaseTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FABTableViewCellDelegate;

@interface FABBaseTableViewCell : UITableViewCell


/**
 *  文本框响应键盘是否弹起
 */
@property (nonatomic, assign) BOOL isTextFieldFirstResponder;

/**
 *  表格组信息
 */
@property (nonatomic, assign) NSInteger indexPathSection;

/**
 *  表格行 信息
 */
@property (nonatomic, assign) NSInteger indexPathRow;

/**
 *	通用协议
 */
@property (nonatomic, weak) id<FABTableViewCellDelegate>  xnoDelegate;


#pragma mark - Initialize Methods

/**
 * 用于Cell创建
 *
 * 用法：
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 Cell *cell = [Cell cellForTableView:tableView];
 return cell;
 }
 */
+ (id)cellForTableView:(UITableView *)tableView;

/**
 *  提取当前TableViewCell的标示符
 *
 *  @return 回调Cell的String字符串
 */
+ (NSString *)cellIdentifier;

/**
 * 重写cell需要覆盖此方法
 *
 * 用法：
 @implementation Cell
 
 - (instancetype)initWithCellIdentifier:(NSString *)cellId
 {
 if (self = [super initWithCellIdentifier:cellId]) {
 }
 return self;
 }
 
 @end
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellId;


@end

#pragma mark - FABTableViewCellDelegate

@protocol FABTableViewCellDelegate <NSObject>
@optional
/**
 *	当前选中的行 和选中的值
 *
 *	@param indexRow     下标
 *	@param selectValue  行
 */
- (void)buttonTableViewCellSelect:(NSInteger)indexRow   Value:(id)selectValue;


/**
 *  提醒信息显示
 *
 *  @param message  信息内容
 */
- (void)showWarningMessage:(NSString *)message;

/**
 *  表格行回调
 */
- (void)tableViewCellShouldReturn:(FABBaseTableViewCell *)cell  TextfieldValue:(UITextField *)textField IsButtonClilck:(BOOL)isClick;

/**
 *  文本框编辑
 */
- (void)tableViewCellShouldChangeCharactersInRange:(FABBaseTableViewCell *)cell  TextfieldValue:(UITextField *)textField;
/**
 *文本框编辑实时检查并反馈
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string identifier:(NSString *)identifier;
/**
 *文本框编辑结束
 */
- (void)cellTextFieldEndEditingWithText:(NSString *)textFildText identifier:(NSString *)identifier;

@end
