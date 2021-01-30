//
//  FABMonthSummaryCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABMonthSummaryCell.h"
#import "FABAccountingSummaryEntity.h"
#import "FABSummaryBlockView.h"

@interface FABMonthSummaryCell ()

@property (nonatomic, strong) FABAccountingSummaryEntity *itemEntity;
@property (nonatomic, copy) NSString *accountingId;


@property (nonatomic, strong) UIView *containerView;
////收入预算
//@property (nonatomic, strong) UILabel *incomeBudgetLabel;
////实际收入
//@property (nonatomic, strong) UILabel *incomeLabel;
//收入状态
@property (nonatomic, strong) UILabel *incomeStatusLabel;
////支出预算
//@property (nonatomic, strong) UILabel *expenditureBudgetLabel;
////实际支出
//@property (nonatomic, strong) UILabel *expenditureLabel;
//支出状态
@property (nonatomic, strong) UILabel *expenditureStatusLabel;
//支出预算余额
@property (nonatomic, strong) UILabel *budgetBalanceLabel;

/** 收入预算 */
@property (nonatomic, strong) FABSummaryBlockView *incomeBudgetBlockView;

/** 实际收入 */
@property (nonatomic, strong) FABSummaryBlockView *incomeBlockView;

/** 支出预算 */
@property (nonatomic, strong) FABSummaryBlockView *expenditureBudgetBlockView;

/** 实际支出 */
@property (nonatomic, strong) FABSummaryBlockView *expenditureBlockView;


//本月总结余
@property (nonatomic, strong) UILabel *cashSurplusLabel;

@end

@implementation FABMonthSummaryCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kTCellLineTopOrBottomColor;
//        [self.contentView addSubview:self.containerView];
////        [self.containerView addSubview:self.incomeBudgetLabel];
////        [self.containerView addSubview:self.incomeLabel];
//        [self.containerView addSubview:self.incomeStatusLabel];
////        [self.containerView addSubview:self.expenditureBudgetLabel];
////        [self.containerView addSubview:self.expenditureLabel];
//        [self.containerView addSubview:self.expenditureStatusLabel];
////        [self.containerView addSubview:self.budgetBalanceLabel];
//        [self.containerView addSubview:self.incomeBudgetBlockView];
//        [self.containerView addSubview:self.incomeBlockView];
//
//        [self.containerView addSubview:self.expenditureBudgetBlockView];
//        [self.containerView addSubview:self.expenditureBlockView];
//
//        [self.containerView addSubview:self.cashSurplusLabel];
//        [self customLayout];
    }
    return self;
}
#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger titleFontDefault = 12;
    NSInteger ValueFontDefault = 16;
    
//    [self labelFormat:self.incomeBudgetLabel
//                title:NSLocalizedString(@"Income budget",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.incomeBudget doubleValue]]
//            valueFont:ValueFontDefault
//     ];
//    self.incomeBudgetLabel.adjustsFontSizeToFitWidth = YES;
//
//    [self labelFormat:self.incomeLabel
//                title:NSLocalizedString(@"Real income",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.income doubleValue]]
//            valueFont:ValueFontDefault
//
//     ];
//    self.incomeLabel.adjustsFontSizeToFitWidth = YES;

    
    NSString *incomeStatus;
    int incomeRate = (self.itemEntity.income.intValue + 1)/(self.itemEntity.incomeBudget.intValue + 1);
    if (incomeRate > 1) {
        if (incomeRate > 1.2) {
            incomeStatus = NSLocalizedString(@"Over budget",nil);
        }else{
            incomeStatus = NSLocalizedString(@"Normal",nil);
        }
    }else{
        if (incomeRate < 0.8) {
            incomeStatus = NSLocalizedString(@"Fail to accomplish",nil);
        }else{
            incomeStatus = NSLocalizedString(@"Normal",nil);
        }
    }
    
    
    [self.incomeStatusLabel ss_setText:incomeStatus
                                  Font:kBoldFontSize(14)
                             TextColor:kMainCommonOppositionColor
                       BackgroundColor:nil];
    self.incomeStatusLabel.adjustsFontSizeToFitWidth = YES;

    
//    [self labelFormat:self.expenditureBudgetLabel
//                title:NSLocalizedString(@"Expenditure budget",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditureBudget doubleValue]]
//            valueFont:ValueFontDefault
//     ];
    
//    self.expenditureBudgetLabel.adjustsFontSizeToFitWidth = YES;

//    [self labelFormat:self.expenditureLabel
//                title:NSLocalizedString(@"Real Expenditure",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditure doubleValue]]
//            valueFont:ValueFontDefault
//
//     ];
//    self.expenditureLabel.adjustsFontSizeToFitWidth = YES;

    
    NSString *expenditureStatus;
    int expenditureRate = (self.itemEntity.expenditure.intValue + 1)/(self.itemEntity.expenditureBudget.intValue + 1);
    if (expenditureRate > 1.2) {
        expenditureStatus = NSLocalizedString(@"Over budget",nil);
    }else{
        expenditureStatus = NSLocalizedString(@"Normal",nil);
    }
    
    [self.expenditureStatusLabel ss_setText:expenditureStatus
                                       Font:kBoldFontSize(14)
                                  TextColor:kMainCommonOppositionColor
                            BackgroundColor:nil];
    self.expenditureStatusLabel.adjustsFontSizeToFitWidth = YES;

    [self labelFormat:self.budgetBalanceLabel
                title:@"预算余额:  "
            titleFont:titleFontDefault
                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.budgetBalance doubleValue]]
            valueFont:ValueFontDefault
     
     ];
    [self labelFormat:self.cashSurplusLabel
                title:NSLocalizedString(@"Balance for this month",nil)
            titleFont:18
                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.cashSurplus doubleValue]]
            valueFont:18
     
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
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-6);
        
    }];
    
    [self.incomeBudgetBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(13);
        make.left.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.40 - 3));
        make.height.equalTo(@(47));

    }];
    
    [self.incomeBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.incomeBudgetBlockView);
        make.left.equalTo(@(kScreenWidth * 0.42));
        make.width.height.equalTo(self.incomeBudgetBlockView);
        
    }];
    
    [self.expenditureBudgetBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.incomeBudgetBlockView.mas_bottom);
        make.left.equalTo(self.incomeBudgetBlockView);
        make.width.height.equalTo(self.incomeBudgetBlockView);
        
    }];
    
    [self.expenditureBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.expenditureBudgetBlockView);
        make.left.equalTo(self.incomeBlockView);
        make.width.height.equalTo(self.incomeBudgetBlockView);
        
    }];
    
//    [self.incomeBudgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.containerView.mas_top).offset(10);
//        make.left.equalTo(self.containerView.mas_left).offset(10);
//        make.width.equalTo(@(kScreenWidth * 0.35));
//
//    }];
//
//    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.incomeBudgetLabel.mas_top);
//        if(IS_IPAD){
//            make.left.equalTo(self).offset(kScreenWidth * 0.65);
//            make.width.equalTo(@(kScreenWidth * 0.20));
//        }else{
//        make.left.equalTo(self.incomeBudgetLabel.mas_right).offset(16);
//        make.width.equalTo(@(kScreenWidth * 0.33));
//        }
//
//    }];

    [self.incomeStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.incomeBudgetBlockView.mas_top);
        make.right.equalTo(self).offset(-20);
        make.width.equalTo(@(kScreenWidth * 0.15));
    }];
//    [self.expenditureBudgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.incomeBudgetLabel.mas_bottom).offset(10);
//        make.left.equalTo(self.containerView.mas_left).offset(10);
//        make.width.equalTo(@(kScreenWidth * 0.35));
//    }];
//
//    [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.expenditureBudgetLabel.mas_top);
//        make.left.equalTo(self.incomeLabel);
//        make.width.equalTo(self.incomeLabel);
//
//    }];
    
    [self.expenditureStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.expenditureBudgetBlockView.mas_top);
        make.right.equalTo(self).offset(-20);
        make.width.equalTo(@(kScreenWidth * 0.15));
    }];
//    [self.budgetBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.top.equalTo(self.expenditureBudgetLabel.mas_bottom).offset(10);
//        make.left.equalTo(self.containerView.mas_left).offset(10);
//        make.width.equalTo(@(kScreenWidth * 0.35));
//
//    }];
    [self.cashSurplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.expenditureBudgetBlockView.mas_bottom).offset(0);
        make.left.equalTo(self.containerView.mas_left).offset(16);
        make.width.equalTo(@(kScreenWidth * 0.90));
    }];
}

- (void)setUpItemEntity:(FABAccountingSummaryEntity *)itemEntity {
    self.itemEntity = itemEntity;
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.incomeBlockView];
    [self.containerView addSubview:self.incomeBudgetBlockView];
    [self.containerView addSubview:self.incomeStatusLabel];

    [self.containerView addSubview:self.expenditureBlockView];
    [self.containerView addSubview:self.expenditureBudgetBlockView];
    [self.containerView addSubview:self.expenditureStatusLabel];

    [self.containerView addSubview:self.cashSurplusLabel];
    
    SSTextAttributedItem *incomeBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.income doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *incomeBudgetBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.incomeBudget doubleValue]], kFontSize(16), kMainCommonColor);

    SSTextAttributedItem *expenditureBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditure doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *expenditureBudgetBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.expenditureBudget doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *Unit = SSTextAttrItem(kCashUnit, kFontSize(14), kTitleTextColor);
    
    [self.incomeBlockView.valueLabel ss_setAttrTextWithItems:@[incomeBlockViewValue, Unit]];
    [self.incomeBudgetBlockView.valueLabel ss_setAttrTextWithItems:@[incomeBudgetBlockViewValue, Unit]];
    [self.expenditureBlockView.valueLabel ss_setAttrTextWithItems:@[expenditureBlockViewValue, Unit]];
    [self.expenditureBudgetBlockView.valueLabel ss_setAttrTextWithItems:@[expenditureBudgetBlockViewValue, Unit]];
    
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

//- (UILabel *)incomeBudgetLabel {
//    if (!_incomeBudgetLabel) {
//        _incomeBudgetLabel = [[UILabel alloc] init];
//
//    }
//    return _incomeBudgetLabel;
//}

//- (UILabel *)incomeLabel {
//    if (!_incomeLabel) {
//        _incomeLabel = [[UILabel alloc] init];
//    }
//    return _incomeLabel;
//}

- (FABSummaryBlockView *)incomeBlockView {
    if (!_incomeBlockView) {
        _incomeBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Real income",nil) color:kMainCommonColor];
    }
    return _incomeBlockView;
}

- (FABSummaryBlockView *)incomeBudgetBlockView {
    if (!_incomeBudgetBlockView) {
        _incomeBudgetBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Income budget",nil) color:UIColorFromRGB(0xC1BAC1)];
    }
    return _incomeBudgetBlockView;
}

- (UILabel *)incomeStatusLabel {
    if (!_incomeStatusLabel) {
        _incomeStatusLabel = [[UILabel alloc] init];
        _incomeStatusLabel.textAlignment = NSTextAlignmentRight;
    }
    return _incomeStatusLabel;
}

//- (UILabel *)expenditureLabel {
//    if (!_expenditureLabel) {
//        _expenditureLabel = [[UILabel alloc] init];
//    }
//    return _expenditureLabel;
//}
//
//- (UILabel *)expenditureBudgetLabel {
//    if (!_expenditureBudgetLabel) {
//        _expenditureBudgetLabel = [[UILabel alloc] init];
//    }
//    return _expenditureBudgetLabel;
//}

- (FABSummaryBlockView *)expenditureBudgetBlockView {
    if (!_expenditureBudgetBlockView) {
        _expenditureBudgetBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Expenditure budget",nil) color:UIColorFromRGB(0xF7D08A)];
    }
    return _expenditureBudgetBlockView;
}
- (FABSummaryBlockView *)expenditureBlockView {
    if (!_expenditureBlockView) {
        _expenditureBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Real Expenditure",nil) color:kMainCommonOppositionColor];
    }
    return _expenditureBlockView;
}

- (UILabel *)expenditureStatusLabel {
    if (!_expenditureStatusLabel) {
        _expenditureStatusLabel = [[UILabel alloc] init];
        _expenditureStatusLabel.textAlignment = NSTextAlignmentRight;
    }
    return _expenditureStatusLabel;
}

- (UILabel *)budgetBalanceLabel {
    if (!_budgetBalanceLabel) {
        _budgetBalanceLabel = [[UILabel alloc] init];
    }
    return _budgetBalanceLabel;
}

- (UILabel *)cashSurplusLabel {
    if (!_cashSurplusLabel) {
        _cashSurplusLabel = [[UILabel alloc] init];
    }
    return _cashSurplusLabel;
}

@end
