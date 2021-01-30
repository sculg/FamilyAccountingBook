//
//  FABTitleTextFieldTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/8.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABTitleTextFieldTableViewCell.h"

@interface FABTitleTextFieldTableViewCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *bottomLineView;

@property (nonatomic, strong) UIImageView *textFieldLineView;

@property (nonatomic, strong) UITextField *valueTextField;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *textFieldValue;
@property (nonatomic, assign) CGFloat leftOffset;
@property (nonatomic, assign) CGFloat textFieldValueOffset;
@end


@implementation FABTitleTextFieldTableViewCell


- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        
        self.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.valueTextField];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.textFieldLineView];
        
    }
    return self;
}

#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel ss_setText:self.title
                           Font:kFontSize(16)
                      TextColor:kTitleTextColor
                BackgroundColor:nil];
    
    
    NSMutableParagraphStyle *style = [self.valueTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    self.valueTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Unfilled",nil)  attributes:@{NSFontAttributeName:kFontSize(16),NSForegroundColorAttributeName:kTitleTextColor,NSParagraphStyleAttributeName:style}];
  
    @weakify(self);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(self.leftOffset);
        make.width.equalTo(@(kScreenWidth * 0.5));
    }];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.left.equalTo(self.titleLabel.mas_left).offset(120);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
    
    [self.textFieldLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.valueTextField.mas_left);
        make.right.equalTo(self).offset(-20.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.5);
        make.height.equalTo(@(0.5));
    }];
    
    
}


#pragma mark - Property
- (UITextField *)valueTextField {
    if (!_valueTextField) {
        _valueTextField = [[UITextField alloc] init];
        _valueTextField.textAlignment = NSTextAlignmentCenter;
        [_valueTextField setDelegate:self];
        [_valueTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_valueTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_valueTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_valueTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_valueTextField setFont:kFontSize(15) ];
        [_valueTextField setReturnKeyType:UIReturnKeyDone];
//        _valueTextField.inputAccessoryView = [self addToolbar];
        [_valueTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_valueTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [_valueTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_valueTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _valueTextField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIImageView alloc] init];
        _bottomLineView.backgroundColor = kTCellLineMiddleColor;
    }
    return _bottomLineView;
}

- (UIImageView *)textFieldLineView{
    if (!_textFieldLineView) {
        _textFieldLineView = [[UIImageView alloc] init];
        _textFieldLineView.backgroundColor = [UIColor grayColor];
    }
    return _textFieldLineView;
}


#pragma mark - public Methods

- (void)configCellWithTitle:(NSString *)title
             textFieldValue:(NSString *)textFieldValue;{
    
    [self configCellWithTitle:title
                   leftOffset:20
               textFieldValue:textFieldValue];
}

- (void)configCellWithTitle:(NSString *)title
                 leftOffset:(CGFloat)leftOffset
             textFieldValue:(NSString *)textFieldValue{
    
    [self configCellWithTitle:title
                   leftOffset:leftOffset
               textFieldValue:textFieldValue
         textFieldValueOffset:kScreenWidth * 0.2];
}

- (void)configCellWithTitle:(NSString *)title
                 leftOffset:(CGFloat)leftOffset
             textFieldValue:(NSString *)textFieldValue
       textFieldValueOffset:(CGFloat)textFieldValueOffset{
    
    self.title = title;
    self.leftOffset = leftOffset;
    self.textFieldValueOffset = textFieldValueOffset;
    
    NSMutableParagraphStyle *style = [self.valueTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    self.valueTextField.attributedText = [[NSAttributedString alloc] initWithString:textFieldValue attributes:@{NSFontAttributeName:kBoldFontSize(16),NSForegroundColorAttributeName:kMainCommonColor,NSParagraphStyleAttributeName:style}];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.valueTextField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_valueTextField isExclusiveTouch]) {
        [_valueTextField resignFirstResponder];
    }
}


#pragma mark TextField
- (void)editDidBegin:(id)sender {
    //    self.lineView.backgroundColor = [UIColor whiteColor];
    //    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    
    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.valueTextField.text);
    }
}

- (void)editDidEnd:(id)sender {
    //    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
    //    self.clearBtn.hidden = YES;
    
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.valueTextField.text);
    }
}

- (void)textValueChanged:(id)sender {
    //    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.valueTextField.text);
    }
}
//- (UIToolbar *)addToolbar
//{
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
//    toolbar.tintColor = [UIColor blueColor];
//    toolbar.backgroundColor = [UIColor whiteColor];
////    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
//    [bar setTitleTextAttributes:@{
//                                        NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
//                                        NSForegroundColorAttributeName: kMainCommonColor,
//                                        } forState:UIControlStateNormal];
//
//    toolbar.items = @[space, bar];
//    return toolbar;
//}

-(void)dealloc{
    [_valueTextField resignFirstResponder];
}

//-(void)textFieldDone{
//    [_valueTextField resignFirstResponder];
//}
@end
