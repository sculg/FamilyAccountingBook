//
//  FABDaySummaryEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/16.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

@interface FABDaySummaryEntity : FABBaseEntity

/** 查询日期 */
@property (nonatomic, copy) NSString *selectedDate;

//本阶段记录的条数
-(NSInteger)periodRecordNum;

//收入总金额
-(double)incomeSum;
//支出总金额
-(double)expenditureSum;
//结余总金额
-(double)cashSurplus;


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


@end
