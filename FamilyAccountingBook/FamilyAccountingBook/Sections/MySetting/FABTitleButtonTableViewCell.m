//
//  FABTitleButtonTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/4.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABTitleButtonTableViewCell.h"
#import "FABCommonButtton.h"


@interface FABTitleButtonTableViewCell ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FABCommonButtton *button;

@end


@implementation FABTitleButtonTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.button];
        self.titleLabel.backgroundColor = [UIColor redColor];

        [self.button addTarget:self action:@selector(deleteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

-(void)configCellWithTitle:(NSString *)title{
    self.title = title;
}


-(void)deleteBtnPressed{
    if (_deleteBtnPressedBlock) {
        _deleteBtnPressedBlock();
    }
}


#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel ss_setText:self.title
                           Font:kFontSize(16)
                      TextColor:kTitleTextColor
                BackgroundColor:nil];

    [self.button setSubmitBtnBackgroundColor:kMainCommonOppositionColor
                                       title:NSLocalizedString(@"Delete",nil)
                                  titleColor:kWhiteColor
                                    forState:UIControlStateNormal];

    [self customLayout];
}

- (void)customLayout {
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(8);
        make.width.equalTo(@(kScreenWidth * 0.6));
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(6);
        make.right.equalTo(self).offset(-8);
        make.width.equalTo(@120);
        make.bottom.equalTo(self).offset(-6);
    }];
    
}

#pragma mark - Property
- (FABCommonButtton *)button {
    if (!_button) {
        _button = [[FABCommonButtton alloc] init];
    }
    return _button;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end
