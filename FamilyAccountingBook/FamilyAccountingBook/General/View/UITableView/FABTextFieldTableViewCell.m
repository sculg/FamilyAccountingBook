//
//  FABTextFieldTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABTextFieldTableViewCell.h"

@implementation FABTextFieldTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.textField];
    }
    return self;
}

#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    @weakify(self);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-0);
    }];
        
}


#pragma mark - Property
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentLeft;
        [_textField setDelegate:self];
        [_textField setKeyboardType:UIKeyboardTypeDefault];
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_textField setFont:kFontSize(15) ];
        _textField.placeholder = NSLocalizedString(@"Please enter the answer",nil);
        [_textField setReturnKeyType:UIReturnKeyDone];
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textFieldEndEditing)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:self.textField];
    }
    return _textField;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self textFieldEndEditing];
    [self.textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_textField isExclusiveTouch]) {
        [self textFieldEndEditing];
        [_textField resignFirstResponder];
    }
}

#pragma mark - private Methods

- (void)textFieldEndEditing{
    [_textField resignFirstResponder];
    !self.editingBlock ? : self.editingBlock(self.textField.text);
    
}


@end
