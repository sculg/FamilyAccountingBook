//
//  FABAcumulativeCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAcumulativeCell.h"
#import "FABSummaryBlockView.h"

@interface FABAcumulativeCell ()

@property (nonatomic, strong) FABAcumulativeEntity *itemEntity;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *acumuCashSurplusLabel;
//
//@property (nonatomic, strong) UILabel *acumuIncomeLabel;
//@property (nonatomic, strong) UILabel *acumuExpenditureLabel;
//@property (nonatomic, strong) UILabel *acumuCountLabel;
//@property (nonatomic, strong) UILabel *acumuTimeLabel;
//@property (nonatomic, strong) UILabel *initialAssetsLabel;
//@property (nonatomic, strong) UILabel *totalAssetsLabel;

/** 累计收入 */
@property (nonatomic, strong) FABSummaryBlockView *acumuIncomeBlockView;

/** 累计支出 */
@property (nonatomic, strong) FABSummaryBlockView *acumuExpenditureBlockView;

/** 初始资产 */
@property (nonatomic, strong) FABSummaryBlockView *initialAssetsBlockView;

/** 资产合计 */
@property (nonatomic, strong) FABSummaryBlockView *totalAssetsBlockView;

/** 记录笔数 */
@property (nonatomic, strong) FABSummaryBlockView *acumuCountBlockView;

/** 起始时间 */
@property (nonatomic, strong) FABSummaryBlockView *acumuTimeBlockView;

@end


@implementation FABAcumulativeCell
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
    
    NSInteger titleFontDefault = 12;
    NSInteger ValueFontDefault = 16;
    
//    [self labelFormat:self.acumuIncomeLabel
//                title:NSLocalizedString(@"Accumulated income",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.acumuIncome doubleValue]]
//            valueFont:ValueFontDefault
//              unitStr:nil
//     ];
//    self.acumuIncomeLabel.adjustsFontSizeToFitWidth = YES;
//
//    [self labelFormat:self.acumuExpenditureLabel
//                title:NSLocalizedString(@"Cumulative expenditures",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.acumuExpenditure doubleValue]]
//            valueFont:ValueFontDefault
//              unitStr:nil
//
//     ];
//    self.acumuExpenditureLabel.adjustsFontSizeToFitWidth = YES;
//
//    [self labelFormat:self.acumuCountLabel
//                title:NSLocalizedString(@"Number of records",nil)
//            titleFont:titleFontDefault
//                value:self.itemEntity.acumuCount.stringValue
//            valueFont:ValueFontDefault
//              unitStr:@" "
//
//     ];
//    [self labelFormat:self.acumuTimeLabel
//                title:NSLocalizedString(@"Start time",nil)
//            titleFont:titleFontDefault
//                value:self.itemEntity.acumuTime
//            valueFont:ValueFontDefault
//              unitStr:@" "
//
//     ];
    [self labelFormat:self.acumuCashSurplusLabel
                title:NSLocalizedString(@"Accumulated balance",nil)
            titleFont:18
                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.acumuCashSurplus doubleValue]]
            valueFont:18
              unitStr:nil
     
     ];
    self.acumuCashSurplusLabel.adjustsFontSizeToFitWidth = YES;

//    NSString *initialAssets  = [NSString stringWithFormat:@"%@：",NSLocalizedString(@"Initial Assets",nil)];
//    [self labelFormat:self.initialAssetsLabel
//                title:initialAssets
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.initialAssets doubleValue]]
//            valueFont:ValueFontDefault
//              unitStr:nil
//
//     ];
//
//    self.initialAssetsLabel.adjustsFontSizeToFitWidth = YES;
//
//    [self labelFormat:self.totalAssetsLabel
//                title:NSLocalizedString(@"Total Assets",nil)
//            titleFont:titleFontDefault
//                value:[StringHelper numberDoubleFormatterValue:[self.itemEntity.totalAssets doubleValue]]
//            valueFont:ValueFontDefault
//              unitStr:nil
//
//     ];
//    self.totalAssetsLabel.adjustsFontSizeToFitWidth = YES;

}

#pragma mark - Private Methods

- (void)labelFormat:(UILabel *)label
              title:(NSString *)title
          titleFont:(NSInteger)titleFont
              value:(NSString *)value
          valueFont:(NSInteger)valueFont
            unitStr:(NSString *)unit
{
    if (!unit) {
        unit = kCashUnit;
    }
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
        make.bottom.equalTo(self).offset(-0);
        
    }];
    
    [self.acumuCashSurplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView).offset(16);
        make.centerX.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.8));
    }];
    
    [self.acumuIncomeBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.acumuCashSurplusLabel.mas_bottom).offset(13);
        make.left.equalTo(self.containerView);
        make.width.equalTo(@(kScreenWidth * 0.40 - 3));
        make.height.equalTo(@(47));
        
    }];
    
    [self.acumuExpenditureBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.acumuIncomeBlockView);
        make.left.equalTo(@(kScreenWidth * 0.54));
        make.width.height.equalTo(self.acumuIncomeBlockView);
        
    }];
    
    [self.initialAssetsBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.acumuIncomeBlockView.mas_bottom);
        make.left.equalTo(self.acumuIncomeBlockView);
        make.width.height.equalTo(self.acumuIncomeBlockView);
        
    }];
    
    [self.totalAssetsBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.initialAssetsBlockView);
        make.left.equalTo(self.acumuExpenditureBlockView);
        make.width.height.equalTo(self.acumuIncomeBlockView);
        
    }];
    
    [self.acumuCountBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.initialAssetsBlockView.mas_bottom);
        make.left.equalTo(self.acumuIncomeBlockView);
        make.width.height.equalTo(self.acumuIncomeBlockView);
        
    }];
    
    [self.acumuTimeBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.acumuCountBlockView);
        make.left.equalTo(self.acumuExpenditureBlockView);
        make.width.height.equalTo(self.acumuIncomeBlockView);
        
    }];
    
//    [self.acumuIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.left.equalTo(self.containerView).offset(10);
//        make.top.equalTo(self.acumuCashSurplusLabel.mas_bottom).offset(15);
//        make.width.equalTo(@(kScreenWidth * 0.46 - 10));
//    }];
//    [self.acumuExpenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.right.equalTo(@(-10));
//        make.centerY.equalTo(self.acumuIncomeLabel);
//        if(IS_IPAD){
//            make.width.equalTo(@(kScreenWidth * 0.2 - 10));
//        }else{
//        make.width.equalTo(@(kScreenWidth * 0.46 - 10));
//        }
//    }];
//
//    [self.initialAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.left.equalTo(self.acumuIncomeLabel.mas_left);
//        make.top.equalTo(self.acumuExpenditureLabel.mas_bottom).offset(8);
//        make.width.equalTo(self.acumuIncomeLabel);
//    }];
//
//    [self.totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.centerY.equalTo(self.initialAssetsLabel);
//        make.right.equalTo(self.acumuExpenditureLabel.mas_right);
//        make.width.equalTo(self.acumuExpenditureLabel);
//    }];
//
//    [self.acumuCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.left.equalTo(self.acumuIncomeLabel.mas_left);
//        make.top.equalTo(self.initialAssetsLabel.mas_bottom).offset(8);
//        make.width.equalTo(self.acumuIncomeLabel);
//    }];
//
//    [self.acumuTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.centerY.equalTo(self.acumuCountLabel);
//        make.right.equalTo(self.acumuExpenditureLabel.mas_right);
//        make.width.equalTo(self.acumuExpenditureLabel);
//    }];
//
    

}

- (void)setUpItemEntity:(FABAcumulativeEntity *)itemEntity {
    self.itemEntity = itemEntity;
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.acumuCashSurplusLabel];

    [self.containerView addSubview:self.acumuIncomeBlockView];
    [self.containerView addSubview:self.acumuExpenditureBlockView];
    [self.containerView addSubview:self.initialAssetsBlockView];
    [self.containerView addSubview:self.totalAssetsBlockView];
    [self.containerView addSubview:self.acumuCountBlockView];
    [self.containerView addSubview:self.acumuTimeBlockView];
    
    
    SSTextAttributedItem *acumuIncomeBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.acumuIncome doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *acumuExpenditureBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.acumuExpenditure doubleValue]], kFontSize(16), kMainCommonColor);
    
    SSTextAttributedItem *initialAssetsBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.initialAssets doubleValue]], kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *totalAssetsBlockViewValue = SSTextAttrItem([StringHelper numberDoubleFormatterValue:[self.itemEntity.totalAssets doubleValue]], kFontSize(16), kMainCommonColor);
    
    
    SSTextAttributedItem *acumuCountBlockViewValue = SSTextAttrItem(self.itemEntity.acumuCount.stringValue, kFontSize(16), kMainCommonColor);
    SSTextAttributedItem *acumuTimeBlockViewValue = SSTextAttrItem(self.itemEntity.acumuTime, kFontSize(16), kMainCommonColor);
    
    SSTextAttributedItem *Unit = SSTextAttrItem(kCashUnit, kFontSize(14), kTitleTextColor);
    
    [self.acumuIncomeBlockView.valueLabel ss_setAttrTextWithItems:@[acumuIncomeBlockViewValue, Unit]];
    [self.acumuExpenditureBlockView.valueLabel ss_setAttrTextWithItems:@[acumuExpenditureBlockViewValue, Unit]];
    [self.initialAssetsBlockView.valueLabel ss_setAttrTextWithItems:@[initialAssetsBlockViewValue, Unit]];
    [self.totalAssetsBlockView.valueLabel ss_setAttrTextWithItems:@[totalAssetsBlockViewValue, Unit]];
    [self.acumuCountBlockView.valueLabel ss_setAttrTextWithItems:@[acumuCountBlockViewValue]];
    [self.acumuTimeBlockView.valueLabel ss_setAttrTextWithItems:@[acumuTimeBlockViewValue]];

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

//- (UILabel *)acumuIncomeLabel {
//    if (!_acumuIncomeLabel) {
//        _acumuIncomeLabel = [[UILabel alloc] init];
//        _acumuIncomeLabel.adjustsFontSizeToFitWidth = YES;
//
//
//    }
//    return _acumuIncomeLabel;
//}
//
//- (UILabel *)acumuExpenditureLabel {
//    if (!_acumuExpenditureLabel) {
//        _acumuExpenditureLabel = [[UILabel alloc] init];
//        _acumuExpenditureLabel.adjustsFontSizeToFitWidth = YES;
//
//    }
//    return _acumuExpenditureLabel;
//}
//
//- (UILabel *)acumuCountLabel {
//    if (!_acumuCountLabel) {
//        _acumuCountLabel = [[UILabel alloc] init];
//        _acumuCountLabel.adjustsFontSizeToFitWidth = YES;
//
//    }
//    return _acumuCountLabel;
//}
//
//- (UILabel *)acumuTimeLabel {
//    if (!_acumuTimeLabel) {
//        _acumuTimeLabel = [[UILabel alloc] init];
//        _acumuTimeLabel.adjustsFontSizeToFitWidth = YES;
//
//    }
//    return _acumuTimeLabel;
//}

- (UILabel *)acumuCashSurplusLabel {
    if (!_acumuCashSurplusLabel) {
        _acumuCashSurplusLabel = [[UILabel alloc] init];
        self.acumuCashSurplusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _acumuCashSurplusLabel;
}

//- (UILabel *)initialAssetsLabel {
//    if (!_initialAssetsLabel) {
//        _initialAssetsLabel = [[UILabel alloc] init];
//    }
//    return _initialAssetsLabel;
//}
//
//- (UILabel *)totalAssetsLabel {
//    if (!_totalAssetsLabel) {
//        _totalAssetsLabel = [[UILabel alloc] init];
//    }
//    return _totalAssetsLabel;
//}

- (FABSummaryBlockView *)acumuIncomeBlockView {
    if (!_acumuIncomeBlockView) {
        _acumuIncomeBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Accumulated income",nil) color:kMainCommonColor];
    }
    return _acumuIncomeBlockView;
}

- (FABSummaryBlockView *)acumuExpenditureBlockView {
    if (!_acumuExpenditureBlockView) {
        _acumuExpenditureBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Cumulative expenditures",nil) color:kMainCommonOppositionColor];
    }
    return _acumuExpenditureBlockView;
}

- (FABSummaryBlockView *)initialAssetsBlockView {
    if (!_initialAssetsBlockView) {
        NSString *initialAssets  = [NSString stringWithFormat:@"%@：",NSLocalizedString(@"Initial Assets",nil)];
        _initialAssetsBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:initialAssets color:UIColorFromRGB(0xC1BAC1)];
    }
    return _initialAssetsBlockView;
}

- (FABSummaryBlockView *)totalAssetsBlockView {
    if (!_totalAssetsBlockView) {
        _totalAssetsBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Total Assets",nil) color:UIColorFromRGB(0xF7D08A)];
    }
    return _totalAssetsBlockView;
}

- (FABSummaryBlockView *)acumuCountBlockView {
    if (!_acumuCountBlockView) {
        _acumuCountBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Number of records",nil) color:UIColorFromRGB(0xDDA59D)];
    }
    return _acumuCountBlockView;
}

- (FABSummaryBlockView *)acumuTimeBlockView {
    if (!_acumuTimeBlockView) {
        _acumuTimeBlockView = [[FABSummaryBlockView alloc] initWithFrame:CGRectZero title:NSLocalizedString(@"Start time",nil) color:UIColorFromRGB(0xE3F09B)];
    }
    return _acumuTimeBlockView;
}


@end
