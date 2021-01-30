//
//  FABAcumulativeEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

@interface FABAcumulativeEntity : FABBaseEntity

/** 累计收入 */
@property (nonatomic, strong) NSNumber *acumuIncome;

/** 累计支出 */
@property (nonatomic, strong) NSNumber *acumuExpenditure;

/** 累计笔数 */
@property (nonatomic, strong) NSNumber *acumuCount;
/** 累计总结余 */
@property (nonatomic, strong) NSNumber *acumuCashSurplus;

/** 累计时间段 */
@property (nonatomic, strong) NSString *acumuTime;

/** 初始资产 */
@property (nonatomic, strong) NSNumber *initialAssets;

/** 资产总额 */
@property (nonatomic, strong) NSNumber *totalAssets;

////工资收入总金额
//-(NSInteger)acumuSalarySum;
////奖金收入总金额
//-(NSInteger)acumuBonusSum;
////理财收入总金额
//-(NSInteger)acumuInterestSum;
////其他收入总金额
//-(NSInteger)acumuIncomOthersSum;
//
////衣支出总金额
//-(NSInteger)acumuClothesSum;
////食支出总金额
//-(NSInteger)acumuFoodsSum;
////住支出总金额
//-(NSInteger)acumuRentsSum;
////行支出总金额
//-(NSInteger)acumuFaresSum;
////娱乐支出总金额
//-(NSInteger)acumuEntertainmentsSum;
////其他支出总金额
//-(NSInteger)acumuOutcomOthersSum;
//
///*  按照支付方式分类 */
////现金支付总金额
//-(NSInteger)acumuCashSum;
////银联支付总金额
//-(NSInteger)acumuUnionPaySum;
////微信支付总金额
//-(NSInteger)acumuWeChatPaySum;
////支付宝支付总金额
//-(NSInteger)acumuAliPaySum;
//
//
///*  按照支付对象分类 */
////家庭支出总金额
//-(NSInteger)acumuFamilySum;
////自己支出总金额
//-(NSInteger)acumuWifeSum;
////配偶支出总金额
//-(NSInteger)acumuHusbandSum;
////父母支出总金额
//-(NSInteger)acumuParentsSum;
////孩子支出总金额
//-(NSInteger)acumuChildSum;
////其他人支出总金额
//-(NSInteger)acumuExpenditureObjectOthersSum;
//
//


//收入数据数组
-(NSArray *)acumuIncomeItems;
//收入数据标题数组
-(NSArray *)incomeTitleItems;

//支出数据数组
-(NSArray *)acumuExpenditureValueItems;
-(NSArray *)expenditureTitleItems;


//支付方式数据数组
-(NSArray *)acumuAccountingPayTypeItems;
//支付对象数据数组
-(NSArray *)acumuExpenditureObjectItems;

@end
