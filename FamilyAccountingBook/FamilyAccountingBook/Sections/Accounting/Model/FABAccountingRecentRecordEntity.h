//
//  FABAccountingRecentRecordEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseEntity.h"

NS_ASSUME_NONNULL_BEGIN

/**  收入OR支出 **/
typedef NS_ENUM(NSUInteger, FABAccountingType){
    FABAccountingType_Income        = 0,       //收入
    FABAccountingType_Expenditure   = 1,       //支出
};

/**  支付方式 **/
typedef NS_ENUM(NSUInteger, FABAccountingPayType){
    FABAccountingPayType_Cash       = 0,       //现金支付
    FABAccountingPayType_UnionPay   = 1,       //银联支付
    FABAccountingPayType_WeChatPay  = 2,       //微信支付
    FABAccountingPayType_AliPay     = 3,       //支付宝支付
//    FABAccountingPayType_AliPay     = 3,       //支付宝支付
};

/** 支出分类 **/
typedef NS_ENUM(NSUInteger, FABExpenditureClassificationType){
    FABExpenditureClassificationType_Clothes          = 0,       //衣
    FABExpenditureClassificationType_Foods            = 1,       //食
    FABExpenditureClassificationType_Rents            = 2,       //住
    FABExpenditureClassificationType_Fares            = 3,       //行
    FABExpenditureClassificationType_Entertainments   = 4,       //娱乐
    FABExpenditureClassificationType_Others           = 5,       //其他支出
    FABExpenditureClassificationType_AdditionalItem1  = 6,       //用户新增条目1 医疗
    FABExpenditureClassificationType_AdditionalItem2  = 7,       //用户新增条目2 日用品
    FABExpenditureClassificationType_AdditionalItem3  = 8,       //用户新增条目3 美容
    FABExpenditureClassificationType_AdditionalItem4  = 9,       //用户新增条目4 社交
    FABExpenditureClassificationType_AdditionalItem5  = 10,      //用户新增条目5 教育
    FABExpenditureClassificationType_AdditionalItem6  = 11,      //用户新增条目6 礼金
    FABExpenditureClassificationType_AdditionalItem7  = 12,      //用户新增条目7 捐赠

};

/** 收入分类 **/
typedef NS_ENUM(NSUInteger, FABIncomeClassificationType){
    FABIncomeClassificationType_Salary              = 0,             //工资收入
    FABIncomeClassificationType_bonus               = 1,             //奖金收入
    FABIncomeClassificationType_interest            = 2,             //理财收入
    FABIncomeClassificationType_others              = 3,             //其他收入
    FABIncomeClassificationType_AdditionalItem1     = 4,             //用户新增条目一兼职
    FABIncomeClassificationType_AdditionalItem2     = 5,             //用户新增条目一房租
    FABIncomeClassificationType_AdditionalItem3     = 6,             //用户新增条目一礼金
    FABIncomeClassificationType_AdditionalItem4     = 7,             //用户新增条目一红包


};

/** 支出对象 **/
typedef NS_ENUM(NSUInteger, FABExpenditureObjectType){
    FABExpenditureObjectType_family             = 0,             //家庭
    FABExpenditureObjectType_wife               = 1,             //自己
    FABExpenditureObjectType_husband            = 2,             //配偶
    FABExpenditureObjectType_parents            = 3,             //父母
    FABExpenditureObjectType_child              = 4,             //孩子
    FABExpenditureObjectType_thers              = 5,             //其他人
    FABExpenditureObjectType_AdditionalItem1    = 6,             //用户新增条目一
    FABExpenditureObjectType_AdditionalItem2    = 7,             //用户新增条目二

};

@interface FABAccountingRecentRecordEntity : FABBaseEntity

/** 记录编号 例：2017-05-23 12:10 **/
@property (nonatomic, strong) NSString *recordId;
/** 记录产品 */
@property (nonatomic, strong, readwrite) NSString *recordProduct;
/** 收支金额 */
@property (nonatomic, strong, readwrite) NSNumber *recordMoney;
/** 记录类型 **/
@property (nonatomic, assign) FABAccountingType accountingType;
/** 支付类型 */
@property (nonatomic, assign) FABAccountingPayType payType;
/** 支出类型 */
@property (nonatomic, assign) FABExpenditureClassificationType ependitureClassificationType;
/** 收入类型 */
@property (nonatomic, assign) FABIncomeClassificationType incomeClassificationType;
/** 支出对象 */
@property (nonatomic, assign) FABExpenditureObjectType expenditureObjectType;
/** 记录时间 */
@property (nonatomic, copy) NSString *recordTime;
/** 月份id */
@property (nonatomic, copy) NSString *monthId;
/** 记录地点 */
@property (nonatomic, strong, readwrite) NSString *recordAddress;

/* 金额的描述*/

- (NSString *)recordMoneyDesc;

/* 收入OR支出类型的描述 */
- (NSString *)accountingTypeDesc;

/* 支付类型的描述 */
- (NSString *)payTypeDesc;

/* 支出类型的描述 */
- (NSString *)ependitureClassificationTypeDesc;

/* 收入类型的描述 */
- (NSString *)incomeClassificationTypeDesc;

/* 支出对象的描述 */
- (NSString *)expenditureObjectTypeeDesc;


- (FABAccountingPayType)accountingPayTypeFromIndex:(NSInteger)index;

- (FABExpenditureClassificationType)expenditureClassificationTypeFromIndex:(NSInteger)index;

- (FABExpenditureObjectType)expenditureObjectTypeFromIndex:(NSInteger)index;

- (FABIncomeClassificationType)incomeClassificationTypeFromIndex:(NSInteger)index;

- (FABAccountingType)accountingTypeFromIndex:(NSInteger)index;




NS_ASSUME_NONNULL_END
@end
