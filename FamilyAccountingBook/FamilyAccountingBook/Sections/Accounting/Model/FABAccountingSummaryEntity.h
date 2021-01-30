//
//  FABAccountingSummaryEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FABAccountingSummaryEntity : FABBaseEntity

/** 月记录编号 例：2017-05 **/
@property (nonatomic, copy) NSString *accountingId;

/** 本月收入预算 */
@property (nonatomic, copy) NSNumber *incomeBudget;
/** 本月实际收入 */
@property (nonatomic, copy) NSNumber *income;
/** 本月实际支出 */
@property (nonatomic, copy) NSNumber *expenditure;
/** 本月支出预算 */
@property (nonatomic, copy) NSNumber *expenditureBudget;
/** 支出预算余额 */
@property (nonatomic, copy) NSNumber *budgetBalance;
/** 总结余 */
@property (nonatomic, copy) NSNumber *cashSurplus;


//所有记录的条数
-(NSInteger)allRecordNum;

//本月记录的条数
-(NSInteger)monthRecordNum;

//工资收入总金额
-(double)salarySum;
//奖金收入总金额
-(double)bonusSum;
//理财收入总金额
-(double)interestSum;
//其他收入总金额
-(double)incomOthersSum;

-(double)additionalIncomeItem1;
-(double)additionalIncomeItem2;
-(double)additionalIncomeItem3;
-(double)additionalIncomeItem4;


//衣支出总金额
-(double)clothesSum;
//食支出总金额
-(double)foodsSum;
//住支出总金额
-(double)rentsSum;
//行支出总金额
-(double)faresSum;
//娱乐支出总金额
-(double)entertainmentsSum;
//其他支出总金额
-(double)outcomOthersSum;

-(double)additionalExpenditureItem1;
-(double)additionalExpenditureItem2;
-(double)additionalExpenditureItem3;
-(double)additionalExpenditureItem4;
-(double)additionalExpenditureItem5;
-(double)additionalExpenditureItem6;
-(double)additionalExpenditureItem7;






/*  按照支付方式分类 */
//现金支付总金额
-(double)cashSum;
//银联支付总金额
-(double)unionPaySum;
//微信支付总金额
-(double)weChatPaySum;
//支付宝支付总金额
-(double)aliPaySum;


/*  按照支付对象分类 */
//家庭支出总金额
-(double)familySum;
//自己支出总金额
-(double)wifeSum;
//配偶支出总金额
-(double)husbandSum;
//父母支出总金额
-(double)parentsSum;
//孩子支出总金额
-(double)childSum;
//其他人支出总金额
-(double)expenditureObjectOthersSum;


//收入数据数组
-(NSArray *)incomeItems;
//收入数据标题数组
-(NSArray *)incomeTitleItems;
//收入数据图片数组
-(NSArray *)incomeImageItems;

//支出数据数组
-(NSArray *)expenditureValueItems;
//支出数据标题数组
-(NSArray *)expenditureTitleItems;
//支出数据图片数组
-(NSArray *)expenditureImageItems;

//支付方式数据数组
-(NSArray *)accountingPayTypeItems;
//支付对象数据数组
-(NSArray *)expenditureObjectItems;





NS_ASSUME_NONNULL_END
@end
