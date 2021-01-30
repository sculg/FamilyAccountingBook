//
//  FABAcumulativeEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAcumulativeEntity.h"
#import "FABAccountingSummaryEntity.h"

@interface FABAcumulativeEntity()

@property (nonatomic, assign) double acumuSalarySum;
@property (nonatomic, assign) double acumuBonusSum;
@property (nonatomic, assign) double acumuInterestSum;
@property (nonatomic, assign) double acumuIncomOthersSum;
@property (nonatomic, assign) double acumuAdditionalIncomeItem1;
@property (nonatomic, assign) double acumuAdditionalIncomeItem2;
@property (nonatomic, assign) double acumuAdditionalIncomeItem3;
@property (nonatomic, assign) double acumuAdditionalIncomeItem4;

@property (nonatomic, assign) double acumuClothesSum;
@property (nonatomic, assign) double acumuFoodsSum;
@property (nonatomic, assign) double acumuRentsSum;
@property (nonatomic, assign) double acumuFaresSum;
@property (nonatomic, assign) double acumuEntertainmentsSum;
@property (nonatomic, assign) double acumuOutcomOthersSum;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem1;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem2;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem3;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem4;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem5;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem6;
@property (nonatomic, assign) double acumuAdditionalExpenditureItem7;




@property (nonatomic, assign) double acumuCashSum;
@property (nonatomic, assign) double acumuUnionPaySum;
@property (nonatomic, assign) double acumuWeChatPaySum;
@property (nonatomic, assign) double acumuAliPaySum;


@property (nonatomic, assign) double acumuFamilySum;
@property (nonatomic, assign) double acumuWifeSum;
@property (nonatomic, assign) double acumuHusbandSum;
@property (nonatomic, assign) double acumuParentsSum;
@property (nonatomic, assign) double acumuChildSum;
@property (nonatomic, assign) double acumuExpenditureObjectOthersSum;



@end

@implementation FABAcumulativeEntity

- (instancetype)init{
    self = [super init];
    if (self) {
        LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
        NSArray *myRecordArray ;
        
        
        _acumuSalarySum = 0.00;
        _acumuBonusSum = 0.00;
        _acumuInterestSum = 0.00;
        _acumuIncomOthersSum = 0.00;
        _acumuAdditionalIncomeItem1 = 0.00;
        _acumuAdditionalIncomeItem2 = 0.00;
        _acumuAdditionalIncomeItem3 = 0.00;
        _acumuAdditionalIncomeItem3 = 0.00;
        
        
        _acumuClothesSum = 0.00;
        _acumuFoodsSum = 0.00;
        _acumuRentsSum = 0.00;
        _acumuFaresSum = 0.00;
        _acumuEntertainmentsSum = 0.00;
        _acumuOutcomOthersSum = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;
        _acumuAdditionalExpenditureItem1 = 0.00;

        
        
        _acumuCashSum = 0.00;
        _acumuUnionPaySum = 0.00;
        _acumuWeChatPaySum = 0.00;
        _acumuAliPaySum = 0.00;
        
        _acumuFamilySum = 0.00;
        _acumuWifeSum = 0.00;
        _acumuHusbandSum = 0.00;
        _acumuParentsSum = 0.00;
        _acumuChildSum = 0.00;
        _acumuExpenditureObjectOthersSum = 0.00;
        
        myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
        for (FABAccountingSummaryEntity *entity in myRecordArray) {
            _acumuSalarySum += entity.salarySum;
            _acumuBonusSum = entity.bonusSum;;
            _acumuInterestSum = entity.interestSum;
            _acumuIncomOthersSum = entity.incomOthersSum;
            _acumuAdditionalIncomeItem1 = entity.additionalIncomeItem1;
            _acumuAdditionalIncomeItem2 = entity.additionalIncomeItem2;
            _acumuAdditionalIncomeItem3 = entity.additionalIncomeItem3;
            _acumuAdditionalIncomeItem3 = entity.additionalIncomeItem4;
            
            _acumuClothesSum = entity.clothesSum;
            _acumuFoodsSum = entity.foodsSum;
            _acumuRentsSum = entity.rentsSum;
            _acumuFaresSum = entity.faresSum;
            _acumuEntertainmentsSum = entity.entertainmentsSum;
            _acumuOutcomOthersSum = entity.outcomOthersSum;
            _acumuAdditionalExpenditureItem1 = entity.additionalExpenditureItem1;
            _acumuAdditionalExpenditureItem2 = entity.additionalExpenditureItem2;
            _acumuAdditionalExpenditureItem3 = entity.additionalExpenditureItem3;
            _acumuAdditionalExpenditureItem4 = entity.additionalExpenditureItem4;
            _acumuAdditionalExpenditureItem5 = entity.additionalExpenditureItem5;
            _acumuAdditionalExpenditureItem6 = entity.additionalExpenditureItem6;
            _acumuAdditionalExpenditureItem7 = entity.additionalExpenditureItem7;            
            
            _acumuCashSum = entity.cashSum;
            _acumuUnionPaySum = entity.unionPaySum;
            _acumuWeChatPaySum = entity.weChatPaySum;
            _acumuAliPaySum = entity.aliPaySum;
            
            _acumuFamilySum = entity.familySum;
            _acumuWifeSum = entity.wifeSum;
            _acumuHusbandSum = entity.husbandSum;
            _acumuParentsSum = entity.parentsSum;
            _acumuChildSum = entity.childSum;
            _acumuExpenditureObjectOthersSum = entity.expenditureObjectOthersSum;
        }
    }
    return self;
}


//收入数据数组
-(NSArray *)acumuIncomeItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"incomeClassificationSelected"];
    NSMutableArray *myArray = [@[@(self.acumuSalarySum),@(self.acumuBonusSum),@(self.acumuInterestSum),@(self.acumuIncomOthersSum)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        double sum = [self additionalAcumuItemSum:itemStr];
        [myArray insertObject:@(sum) atIndex:[myArray count] - 1];
    }
    return myArray;
}

//收入数据标题数组
-(NSArray *)incomeTitleItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"incomeClassificationSelected"];
    NSMutableArray *myArray = [@[NSLocalizedString(@"Salary",nil),NSLocalizedString(@"Bonus",nil),NSLocalizedString(@"Financing Income",nil),NSLocalizedString(@"Other income",nil)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        [myArray insertObject:itemStr atIndex:[myArray count] - 1];
    }
    return myArray;
}

-(double)additionalAcumuItemSum:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Part-time Income",nil)]) {
        return _acumuAdditionalIncomeItem1;
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return _acumuAdditionalIncomeItem2;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return _acumuAdditionalIncomeItem3;
    }else{
        return _acumuAdditionalIncomeItem4;
    }
}



//支出数据数组
-(NSArray *)acumuExpenditureValueItems{
    
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"expenditureClassificationSelected"];
    NSMutableArray *myArray = [@[@(self.acumuClothesSum),@(self.acumuFoodsSum),@(self.acumuRentsSum),@(self.acumuFaresSum),@(self.acumuEntertainmentsSum),@(self.acumuOutcomOthersSum)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        double sum = [self additionalExpenditureAcumuItemSum:itemStr];
        [myArray insertObject:@(sum) atIndex:[myArray count] - 1];
    }
    return myArray;
}

-(double)additionalExpenditureAcumuItemSum:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Medical Care",nil)]) {
        return _acumuAdditionalExpenditureItem1;
    }else if ([str isEqualToString:NSLocalizedString(@"Necessary",nil)]) {
        return _acumuAdditionalExpenditureItem2;
    }else if ([str isEqualToString:NSLocalizedString(@"Cosmetology",nil)]) {
        return _acumuAdditionalExpenditureItem3;
    }else if ([str isEqualToString:NSLocalizedString(@"Social",nil)]) {
        return _acumuAdditionalExpenditureItem4;
    }else if ([str isEqualToString:NSLocalizedString(@"Education",nil)]) {
        return _acumuAdditionalExpenditureItem5;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return _acumuAdditionalExpenditureItem6;
    }else{
        return _acumuAdditionalExpenditureItem7;
    }
}


//支出数据标题数组
-(NSArray *)expenditureTitleItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"expenditureClassificationSelected"];
    NSMutableArray *myArray = [@[NSLocalizedString(@"Clothes",nil)
,NSLocalizedString(@"Foods",nil),NSLocalizedString(@"Rent",nil),NSLocalizedString(@"Traffic",nil),NSLocalizedString(@"Entertainment",nil),NSLocalizedString(@"Other expenses",nil)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        [myArray insertObject:itemStr atIndex:[myArray count] - 1];
    }
    return myArray;
}




//支付方式数据数组
-(NSArray *)acumuAccountingPayTypeItems{
    return @[@(self.acumuCashSum),@(self.acumuUnionPaySum),@(self.acumuWeChatPaySum),@(self.acumuAliPaySum)];
}


//支付方式数据数组
-(NSArray *)acumuExpenditureObjectItems{
    return @[@(self.acumuFamilySum),@(self.acumuWifeSum),@(self.acumuHusbandSum),@(self.acumuParentsSum),@(self.acumuChildSum),@(self.acumuExpenditureObjectOthersSum)];
}


































//工资收入总金额
-(double)acumuSalarySum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.salarySum;
    }
    return sum;
}
//奖金收入总金额
-(double)acumuBonusSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.bonusSum;
    }
    return sum;
}
//理财收入总金额
-(double)acumuInterestSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.interestSum;
    }
    return sum;
}
//其他收入总金额
-(double)acumuIncomOthersSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.incomOthersSum;
    }
    return sum;
}

//衣支出总金额
-(double)acumuClothesSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.clothesSum;
    }
    return sum;
}
//食支出总金额
-(double)acumuFoodsSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.foodsSum;
    }
    return sum;
}
//住支出总金额
-(double)acumuRentsSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.rentsSum;
    }
    return sum;
}
//行支出总金额
-(double)acumuFaresSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.faresSum;
    }
    return sum;
}
//娱乐支出总金额
-(double)acumuEntertainmentsSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.entertainmentsSum;
    }
    return sum;
}
//其他支出总金额
-(double)acumuOutcomOthersSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.outcomOthersSum;
    }
    return sum;
}

/*  按照支付方式分类 */
//现金支付总金额
-(double)acumuCashSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.cashSum;
    }
    return sum;
}
//银联支付总金额
-(double)acumuUnionPaySum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.unionPaySum;
    }
    return sum;
}
//微信支付总金额
-(double)acumuWeChatPaySum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.weChatPaySum;
    }
    return sum;
}
//支付宝支付总金额
-(double)acumuAliPaySum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.aliPaySum;
    }
    return sum;
}


/*  按照支付对象分类 */
//家庭支出总金额
-(double)acumuFamilySum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.familySum;
    }
    return sum;
}
//自己支出总金额
-(double)acumuWifeSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.wifeSum;
    }
    return sum;
}
//配偶支出总金额
-(double)acumuHusbandSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.husbandSum;
    }
    return sum;
}
//父母支出总金额
-(double)acumuParentsSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.parentsSum;
    }
    return sum;
}
//孩子支出总金额
-(double)acumuChildSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.childSum;
    }
    return sum;
}
//其他人支出总金额
-(double)acumuExpenditureObjectOthersSum{
    LKDBHelper* globalHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingSummaryEntity class] where:nil orderBy:@"accountingId desc" offset:0 count:1000];
    for (FABAccountingSummaryEntity *entity in myRecordArray) {
        sum += entity.expenditureObjectOthersSum;
    }
    return sum;
}




@end
