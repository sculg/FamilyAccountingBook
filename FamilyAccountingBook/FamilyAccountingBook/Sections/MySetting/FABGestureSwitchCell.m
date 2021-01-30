//
//  FABGestureSwitchCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureSwitchCell.h"

@interface FABGestureSwitchCell ()

@property (nonatomic, copy) NSString *title;

@end

@implementation FABGestureSwitchCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.switchView];
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
    
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@(kScreenWidth * 0.80));
    }];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-14.0f));
        make.centerY.equalTo(self);
        make.height.equalTo(@(32.0f));
    }];
    
    [self.switchView bk_addEventHandler:^(id sender) {
        
        if (self.switchChangedHandlerBlock) {
            
            self.switchChangedHandlerBlock(sender);
        }
        
    } forControlEvents:UIControlEventValueChanged];

    
}

-(void)configCellWithTitle:(NSString *)title{
    self.title = title;
}

#pragma mark - Property
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}





@end
