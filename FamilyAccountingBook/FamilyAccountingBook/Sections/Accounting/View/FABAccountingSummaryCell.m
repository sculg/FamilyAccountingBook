//
//  FABAccountingSummaryCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABAccountingSummaryCell.h"
#import "FABAccountingSummaryEntity.h"
#import "FABSummaryBlockViewEntity.h"
#import "FABSummaryBlockView.h"

@interface FABAccountingSummaryCell ()

@property (nonatomic, strong) FABAccountingSummaryEntity *itemEntity;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *accountingIdLabel;
/** 收入 */
@property (nonatomic, strong) FABSummaryBlockView *incomeBlockView;

/** 支出 */
@property (nonatomic, strong) FABSummaryBlockView *expenditureBlockView;

/** 支出预算 */
@property (nonatomic, strong) FABSummaryBlockView *budgetBlockView;

/** 支出预算余额 */
@property (nonatomic, strong) FABSummaryBlockView *budgetBalanceBlockView;

/** 总结余 */
@property (nonatomic, strong) UILabel *cashSurplusLabel;

@property (nonatomic, strong) NSArray <FABSummaryBlockViewEntity *> *summaryBlockViewArray;

@property (nonatomic, strong) UIView *topLineView;

//@property (nonatomic, strong) UIView *buttomLineView;

@end

@implementation FABAccountingSummaryCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kTCellLineTopOrBottomColor;
    }
    return self;
}
#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSInteger titleFontDefault = 12;
//    NSInteger ValueFontDefault = 16;
//    
    
    NSString *accountingId = [NSString stringWithFormat:@"%@%@",self.itemEntity.accountingId,NSLocalizedString(@"Income and expenditure",nil)];
    [self.accountingIdLabel ss_setText:accountingId
                                  Font:kBoldFontSize(18)
                             TextColor:kMainCommonColor
                       BackgroundColor:nil];

    [self labelFormat:self.cashSurplusLabel
                title:NSLocalizedString(@"Balance for this month",nil)
            titleFont:18
                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.cashSurplus doubleValue]]            valueFont:18
     
     ];
    self.cashSurplusLabel.adjustsFontSizeToFitWidth = YES;

}


#pragma mark - Private Methods

- (void)labelFormat:(UILabel *)label
              title:(NSString *)title
          titleFont:(NSInteger)titleFont
              value:(NSString *)value
          valueFont:(NSInteger)valueFont{
    NSString *unit = kCashUnit;
    SSTextAttributedItem *item1 = SSTextAttrItem(title, kFontSize(titleFont), kTitleTextColor);
    SSTextAttributedItem *item2 = SSTextAttrItem(value, kBoldFontSize(valueFont), kMainCommonColor);
    SSTextAttributedItem *item3 = SSTextAttrItem(unit, kFontSize(titleFont), kTitleTextColor);
    [label ss_setAttrTextWithItems:@[item1, item2, item3]];
    
}


- (void)customLayout {
    @weakify(self);
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(6);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-6);
        
    }];
    
    [self.accountingIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView).offset(10);
        make.centerX.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.8));
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.accountingIdLabel.mas_bottom).offset(10);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.height.equalTo(@(0.5));
    }];
    
    [self.incomeBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.topLineView.mas_bottom).offset(10);
        make.left.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.40 - 3));
        make.height.equalTo(@(47));
    }];
    
    [self.expenditureBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.incomeBlockView);
        make.left.equalTo(@(kScreenWidth * 0.56));
        make.width.height.equalTo(self.incomeBlockView);
    }];
    
    [self.budgetBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.incomeBlockView.mas_bottom);
        make.left.equalTo(self.incomeBlockView);
        make.width.height.equalTo(self.incomeBlockView);
    }];
    
    [self.budgetBalanceBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.budgetBlockView);
        make.left.equalTo(self.expenditureBlockView);
        make.width.height.equalTo(self.incomeBlockView);
    }];
    
//    [self.buttomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.budgetBalanceBlockView.mas_bottom).offset(0);
//        make.left.equalTo(self.containerView);
//        make.right.equalTo(self.containerView);
//        make.height.equalTo(@(0.5));
//    }];
    
    [self.cashSurplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(@(15));
        make.top.equalTo(self.budgetBalanceBlockView.mas_bottom).offset(0);
        make.width.equalTo(@(kScreenWidth * 0.8));
    }];
}

- (void)setUpItemEntity:(FABAccountingSummaryEntity *)itemEntity {
    self.itemEntity = itemEntity;
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.accountingIdLabel];
    [self.containerView addSubview:self.cashSurplusLabel];
    [self.containerView addSubview:self.incomeBlockView];
    [self.containerView addSubview:self.expenditureBlockView];
    [self.containerView addSubview:self.budgetBlockView];
    [self.containerView addSubview:self.budgetBalanceBlockView];
    [self.containerView addSubview:self.topLineView];
//    [self.containerView addSubview:self.buttomLineView];
    
    SSTextAttributedItem *incomeBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.income doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *expenditureBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditure doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *budgetBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditureBudget doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *budgetBalanceBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.budgetBalance doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *Unit = SSTextAttrItem(kCashUnit, kFontSize(14), kTitleTextColor);
    
    [self.incomeBlockView.valueLabel ss_setAttrTextWithItems:@[incomeBlockViewValue, Unit]];
    [self.expenditureBlockView.valueLabel ss_setAttrTextWithItems:@[expenditureBlockViewValue, Unit]];
    [self.budgetBlockView.valueLabel ss_setAttrTextWithItems:@[budgetBlockViewValue, Unit]];
    [self.budgetBalanceBlockView.valueLabel ss_setAttrTextWithItems:@[budgetBalanceBlockViewValue, Unit]];
    [self customLayout];
}


#pragma mark - Property
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.layer.masksToBounds = YES;
        self.containerView.layer.cornerRadius = 5;
    }
    return _containerView;
}

- (UILabel *)accountingIdLabel {
    if (!_accountingIdLabel) {
        _accountingIdLabel = [[UILabel alloc] init];
        self.accountingIdLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountingIdLabel;
}


- (UILabel *)cashSurplusLabel {
    if (!_cashSurplusLabel) {
        _cashSurplusLabel = [[UILabel alloc] init];
    }
    return _cashSurplusLabel;
}

- (FABSummaryBlockView *)incomeBlockView {
    if (!_incomeBlockView) {
        _incomeBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Income this month",nil) color:kMainCommonColor];
    }
    return _incomeBlockView;
}
- (FABSummaryBlockView *)expenditureBlockView {
    if (!_expenditureBlockView) {
        _expenditureBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"expenditure this month",nil) color:kMainCommonOppositionColor];
    }
    return _expenditureBlockView;
}

- (FABSummaryBlockView *)budgetBlockView {
    if (!_budgetBlockView) {
        _budgetBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Expenditure budget",nil) color:UIColorFromRGB(0xF7D08A)];
    }
    return _budgetBlockView;
}

- (FABSummaryBlockView *)budgetBalanceBlockView {
    if (!_budgetBalanceBlockView) {
        _budgetBalanceBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Budget balance",nil) color:UIColorFromRGB(0xC1BAC1)];
    }
    return _budgetBalanceBlockView;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = kTCellLineMiddleColor;
    }
    return _topLineView;
}

//- (UIView *)buttomLineView {
//    if (!_buttomLineView) {
//        _buttomLineView = [[UIView alloc] init];
//        _buttomLineView.backgroundColor = kTCellLineMiddleColor;
//    }
//    return _buttomLineView;
//}
@end
