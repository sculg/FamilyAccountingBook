//
//  FABTitleTextFieldTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/8.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

@interface FABTitleTextFieldTableViewCell : FABBaseTableViewCell


//@property (nonatomic, copy) void(^editingBlock)(NSString *);

@property (nonatomic, copy) void(^textValueChangedBlock)(NSString *);
@property (nonatomic, copy) void(^editDidBeginBlock)(NSString *);
@property (nonatomic, copy) void(^editDidEndBlock)(NSString *);

@property (nonatomic, strong, readonly) UITextField *valueTextField;

- (void)configCellWithTitle:(NSString *)title
                textFieldValue:(NSString *)textFieldValue;

- (void)configCellWithTitle:(NSString *)title
                 leftOffset:(CGFloat)leftOffset
                textFieldValue:(NSString *)textFieldValue;

- (void)configCellWithTitle:(NSString *)title
                 leftOffset:(CGFloat)leftOffset
                textFieldValue:(NSString *)textFieldValue
         textFieldValueOffset:(CGFloat)textFieldValueOffset;

@end
