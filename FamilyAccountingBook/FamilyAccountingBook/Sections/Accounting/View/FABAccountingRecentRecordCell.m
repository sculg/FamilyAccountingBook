//
//  FABAccountingRecentRecordCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABAccountingRecentRecordCell.h"
#import "FABAccountingRecentRecordEntity.h"


@interface FABAccountingRecentRecordCell ()

@property (nonatomic, strong) FABAccountingRecentRecordEntity *itemEntity;

@property (nonatomic, strong) UIView *containerView;

//@property (nonatomic, strong) UIView *leftView;


@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *upLineImageView;
@property (nonatomic, strong) UIImageView *downLineImageView;

@property (nonatomic, strong) UIImageView *bottomLineView;

@property (nonatomic, strong) UIImageView *ependitureClassificationTypeView;
@property (nonatomic, strong) UIImageView *payTypeView;

@property (nonatomic, strong) UILabel *recordIdLabel;
@property (nonatomic, strong) UILabel *recordProductLabel;
@property (nonatomic, strong) UILabel *recordMoneyLabel;
@property (nonatomic, strong) UILabel *expenditureObjectLabel;
@property (nonatomic, strong) UILabel *recordTimeLabel;
@property (nonatomic, strong) UILabel *weekDayLabel;

@property (nonatomic, strong) UILabel *recordAddressLabel;

@end

@implementation FABAccountingRecentRecordCell

- (id)initWithCellIdentifier:(NSString *)cellId {
    self = [super initWithCellIdentifier:cellId];
    if (self) {
        self.backgroundColor = kTCellLineTopOrBottomColor;
        [self.contentView addSubview:self.containerView];
        
//        [self.contentView addSubview:self.leftView];
        
        [self.containerView addSubview:self.iconImageView];
        [self.containerView addSubview:self.upLineImageView];
        [self.containerView addSubview:self.downLineImageView];

//        [self.containerView addSubview:self.bottomLineView];
        
        [self.containerView addSubview:self.ependitureClassificationTypeView];
        [self.containerView addSubview:self.payTypeView];
        
        [self.containerView addSubview:self.recordProductLabel];
        [self.containerView addSubview:self.recordMoneyLabel];
        [self.containerView addSubview:self.expenditureObjectLabel];
        [self.containerView addSubview:self.recordTimeLabel];
        [self.containerView addSubview:self.weekDayLabel];
        [self.containerView addSubview:self.recordAddressLabel];
        
        [self customLayout];
    }
    return self;
}
#pragma mark - Super Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImage *iconImage = nil;

    
    
    NSString *recordProduct;
    switch (self.itemEntity.accountingType) {
        case FABAccountingType_Income:
            iconImage = [UIImage imageWithColor:kMainCommonColor];
            [self.recordProductLabel ss_setText:self.itemEntity.incomeClassificationTypeDesc
                                           Font:kFontSize(14)
                                      TextColor:kMainCommonColor
                                BackgroundColor:nil];
            self.ependitureClassificationTypeView.image = [UIImage imageWithContentsOfFileName:self.incomeClassificationImageStr];
            break;
            
        case FABAccountingType_Expenditure:
            iconImage = [UIImage imageWithColor:kMainCommonOppositionColor];
            recordProduct = self.itemEntity.recordProduct;
            [self.recordProductLabel ss_setText:recordProduct
                                           Font:kFontSize(14)
                                      TextColor:kMainCommonOppositionColor
                                BackgroundColor:nil];
            self.ependitureClassificationTypeView.image = [UIImage imageWithContentsOfFileName:self.expenditureClassificationImageStr];
            break;
        default:
            break;
    }
    
    self.iconImageView.image = iconImage;

    NSString *recordMoney = [NSString stringWithFormat:@"%@%@",[StringHelper numberDoubleFormatterValue:[self.itemEntity.recordMoney doubleValue]],kCashUnit];

    [self.recordMoneyLabel ss_setText:recordMoney
                                 Font:kFontSize(16)
                            TextColor:kMainCommonColor
                      BackgroundColor:nil];
    self.recordMoneyLabel.adjustsFontSizeToFitWidth = YES;

    self.payTypeView.image = [UIImage imageWithContentsOfFileName:self.payTypeImageStr];
    
    [self.expenditureObjectLabel ss_setText:self.itemEntity.expenditureObjectTypeeDesc
                                       Font:kFontSize(14)
                                  TextColor:kTitleTextColor
                            BackgroundColor:nil];

    NSString *recordTime = [NSDate convertStr_yyyy_MM_ddToDisplay:self.itemEntity.recordTime];
    NSString *weekDay = [NSDate weekdayStringFromDate:self.itemEntity.recordTime];

    
//    NSString *recordTime = [self.itemEntity.recordTime substringWithRange:NSMakeRange(5,5)];
    NSString *recordAddress = self.itemEntity.recordAddress;
    
    [self.recordTimeLabel ss_setText:recordTime
                                Font:kFontSize(14)
                           TextColor:kTitleTextColor
                     BackgroundColor:nil];
    
    [self.weekDayLabel ss_setText:weekDay
                                Font:kFontSize(14)
                           TextColor:kTitleTextColor
                     BackgroundColor:nil];
//    self.recordTimeLabel.adjustsFontSizeToFitWidth = YES;

    
    [self.recordAddressLabel ss_setText:recordAddress
                                   Font:kFontSize(14)
                              TextColor:kTitleTextColor
                        BackgroundColor:nil];
    
    
//    if (self.cellType == FABAccountingRecentRecordCellTypeFirst) {
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = self.containerView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        self.containerView.layer.mask = maskLayer;
//
//    }else if (self.cellType == FABAccountingRecentRecordCellTypeLast){
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = self.containerView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        self.containerView.layer.mask = maskLayer;
//    }else if (self.cellType == FABAccountingRecentRecordCellTypeOnlyOne){
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight| UIRectCornerBottomLeft| UIRectCornerBottomRight cornerRadii:CGSizeMake(10,10)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = self.containerView.bounds;
//        maskLayer.path = maskPath.CGPath;
//        self.containerView.layer.mask = maskLayer;
//    }


    
    @weakify(self);
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.top.equalTo(self).offset(1);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.bottom.equalTo(self).offset(-1);
        
    }];
    
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        
        make.left.equalTo(@(kScreenWidth*0.17));
        make.width.and.height.equalTo(@(16));
        make.centerY.equalTo(self);
    }];
    
    [self.upLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.centerX.equalTo(self.iconImageView);
        make.width.equalTo(@(1.0));
        make.top.equalTo(self.containerView).offset(2);
        make.bottom.equalTo(self.iconImageView.mas_top).offset(-4);

    }];
    
    [self.downLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.centerX.equalTo(self.iconImageView);
        make.width.equalTo(@(1.0));
        make.bottom.equalTo(self.containerView).offset(-2);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(4);
    }];
//    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.left.equalTo(self.containerView);
//        make.right.equalTo(self.containerView);
//        make.bottom.equalTo(self.containerView.mas_bottom).offset(-0.5);
//        make.height.equalTo(@(0.5));
//    }];
    
    
    [self.recordTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView).offset(8);
        make.left.equalTo(self.containerView.mas_left).offset(15);
        make.right.equalTo(self.upLineImageView.mas_left);
    }];
    
    [self.weekDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.recordTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.containerView.mas_left).offset(15);
        make.right.equalTo(self.upLineImageView.mas_left);
    }];
    
    [self.recordProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.containerView).offset(8);
        make.left.equalTo(@(kScreenWidth*0.23));
        make.width.equalTo(@(kScreenWidth*0.30));
        //        make.width.equalTo(@(valueSise.width + 5));
    }];
    
    [self.ependitureClassificationTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(@(kScreenWidth*0.55));
        make.centerY.equalTo(self.recordProductLabel);
        make.width.height.equalTo(@(18));
    }];
    
    [self.recordMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.containerView).offset(-15);
        make.centerY.equalTo(self.recordProductLabel.mas_centerY);
        make.width.equalTo(@(kScreenWidth*0.28));
        
    }];
    
    [self.recordAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.recordProductLabel.mas_left);
        make.top.equalTo(self.recordProductLabel.mas_bottom).offset(10);
        make.width.equalTo(@(kScreenWidth * 0.29));
    }];
    
    [self.payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.recordAddressLabel);
        make.centerX.equalTo(self.ependitureClassificationTypeView);
        make.width.height.equalTo(@(16));
    }];
    
    [self.expenditureObjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.recordAddressLabel);
        make.left.equalTo(self.recordMoneyLabel);
        make.width.equalTo(self.recordMoneyLabel);
    }];
    
}


#pragma mark - Private Methods
- (void)customLayout {
}

- (void)setUpItemEntity:(FABAccountingRecentRecordEntity *)itemEntity {
    self.itemEntity = itemEntity;
//    self.cellType = FABAccountingRecentRecordCellTypeOnlyOne;

}

//- (void)setUpItemEntity:(FABAccountingRecentRecordEntity *)itemEntity cellType:(FABAccountingRecentRecordCellType)type{
//    self.itemEntity = itemEntity;
//    self.cellType = type;
//}


-(NSString *)payTypeImageStr{
    
    NSString  *payType = nil;
    switch (self.itemEntity.payType) {
        case FABAccountingPayType_Cash:
            payType = @"record_cashpay.png";
            break;
        case FABAccountingPayType_UnionPay:
            payType = @"record_unionpay.png";
            break;
        case FABAccountingPayType_WeChatPay:
            payType = @"record_weixinpay.png";
            break;
        case FABAccountingPayType_AliPay:
            payType = @"record_alipay.png";
            break;
        default:
            break;
    }
    return payType;
}


-(NSString *)incomeClassificationImageStr{
    
    NSString  *incomeClassificationImageStr = nil;
    switch (self.itemEntity.incomeClassificationType) {
        case FABIncomeClassificationType_Salary:
            incomeClassificationImageStr = @"record_salary.png";
            break;
        case FABIncomeClassificationType_bonus:
            incomeClassificationImageStr = @"record_bonus.png";
            break;
        case FABIncomeClassificationType_interest:
            incomeClassificationImageStr = @"record_interest.png";
            break;
        case FABIncomeClassificationType_others:
            incomeClassificationImageStr = @"record_others.png";
            break;
        case FABIncomeClassificationType_AdditionalItem1:
            incomeClassificationImageStr = @"record_pluralism.png";
            break;
        case FABIncomeClassificationType_AdditionalItem2:
            incomeClassificationImageStr = @"record_rent_income.png";
            break;
        case FABIncomeClassificationType_AdditionalItem3:
            incomeClassificationImageStr = @"record_gift.png";
            break;
        case FABIncomeClassificationType_AdditionalItem4:
            incomeClassificationImageStr = @"record_hongbao.png";
            break;
        default:
            break;
    }
    return incomeClassificationImageStr;
}


-(NSString *)expenditureClassificationImageStr{
    
    NSString  *expenditureClassificationImageStr = nil;
    switch (self.itemEntity.ependitureClassificationType) {
        case FABExpenditureClassificationType_Clothes:
            expenditureClassificationImageStr = @"record_clothes.png";
            break;
        case FABExpenditureClassificationType_Foods:
            expenditureClassificationImageStr = @"record_foods.png";
            break;
        case FABExpenditureClassificationType_Rents:
            expenditureClassificationImageStr = @"record_rent.png";
            break;
        case FABExpenditureClassificationType_Fares:
            expenditureClassificationImageStr = @"record_fare.png";
            break;
        case FABExpenditureClassificationType_Entertainments:
            expenditureClassificationImageStr = @"record_Entertainments.png";
            break;
        case FABExpenditureClassificationType_Others:
            expenditureClassificationImageStr = @"record_others.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem1:
            expenditureClassificationImageStr = @"record_medicine.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem2:
            expenditureClassificationImageStr = @"record_necessary.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem3:
            expenditureClassificationImageStr = @"record_beauty.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem4:
            expenditureClassificationImageStr = @"record_social.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem5:
            expenditureClassificationImageStr = @"record_education.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem6:
            expenditureClassificationImageStr = @"record_gift.png";
            break;
        case FABExpenditureClassificationType_AdditionalItem7:
            expenditureClassificationImageStr = @"rrecord_donate.png";
            break;
        default:
            break;
    }
    return expenditureClassificationImageStr;
}



#pragma mark - Property
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.layer.masksToBounds = YES;
        self.containerView.layer.cornerRadius = 8;
    }
    return _containerView;
}

//- (UIView *)leftView {
//    if (!_leftView) {
//        _leftView = [[UIView alloc] init];
//    }
//    return _leftView;
//}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 8;
    }
    return _iconImageView;
}

- (UIImageView *)upLineImageView {
    if (!_upLineImageView) {
        _upLineImageView = [[UIImageView alloc] init];
        _upLineImageView.image = [UIImage imageWithContentsOfFileName:@"xuxian"];
    }
    return _upLineImageView;
}

- (UIImageView *)downLineImageView {
    if (!_downLineImageView) {
        _downLineImageView = [[UIImageView alloc] init];
        _downLineImageView.image = [UIImage imageWithContentsOfFileName:@"xuxian"];
    }
    return _downLineImageView;
}

- (UILabel *)recordTimeLabel {
    if (!_recordTimeLabel) {
        _recordTimeLabel = [[UILabel alloc] init];
    }
    return _recordTimeLabel;
}

- (UILabel *)weekDayLabel {
    if (!_weekDayLabel) {
        _weekDayLabel = [[UILabel alloc] init];
    }
    return _weekDayLabel;
}

- (UILabel *)recordProductLabel {
    if (!_recordProductLabel) {
        _recordProductLabel = [[UILabel alloc] init];
    }
    return _recordProductLabel;
}

- (UILabel *)recordMoneyLabel {
    if (!_recordMoneyLabel) {
        _recordMoneyLabel = [[UILabel alloc] init];
        _recordMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _recordMoneyLabel;
}

- (UIImageView *)ependitureClassificationTypeView{
    if (!_ependitureClassificationTypeView) {
        _ependitureClassificationTypeView = [[UIImageView alloc] init];
    }
    return _ependitureClassificationTypeView;
}

- (UILabel *)expenditureObjectLabel {
    if (!_expenditureObjectLabel) {
        _expenditureObjectLabel = [[UILabel alloc] init];
        _expenditureObjectLabel.textAlignment = NSTextAlignmentRight;
    }
    return _expenditureObjectLabel;
}

- (UILabel *)recordAddressLabel {
    if (!_recordAddressLabel) {
        _recordAddressLabel = [[UILabel alloc] init];
    }
    return _recordAddressLabel;
}

- (UIImageView *)payTypeView {
    if (!_payTypeView) {
        _payTypeView = [[UIImageView alloc] init];
    }
    return _payTypeView;
}

//- (UIImageView *)bottomLineView{
//    if (!_bottomLineView) {
//        _bottomLineView = [[UIImageView alloc] init];
//        _bottomLineView.backgroundColor = kTCellLineMiddleColor;
//    }
//    return _bottomLineView;
//}


@end
