//
//  FABTextFieldTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

@interface FABTextFieldTableViewCell : FABBaseTableViewCell<UITextFieldDelegate>

@property (nonatomic, copy) void(^editingBlock)(NSString *);

@property (nonatomic, strong) UITextField *textField;



@end
