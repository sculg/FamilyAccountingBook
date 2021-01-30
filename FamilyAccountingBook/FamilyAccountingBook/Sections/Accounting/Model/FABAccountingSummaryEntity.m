//
//  FABAccountingSummaryEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABAccountingSummaryEntity.h"
#import "FABAccountingRecentRecordEntity.h"


@implementation FABAccountingSummaryEntity


-(NSInteger )allRecordNum{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:nil orderBy:nil offset:0 count:1000];
    return [myRecordArray count];
}

-(NSInteger)monthRecordNum{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"monthId":_accountingId} orderBy:nil offset:0 count:1000];
    return [myRecordArray count];
}

/*  *************************************   收入数据处理   **************************************** */


-(double)inquireIncomeSumWithType:(NSInteger)typeId{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"monthId":_accountingId,@"incomeClassificationType":@(typeId)} orderBy:@"recordTime desc" offset:0 count:1000];
    for (FABAccountingRecentRecordEntity *entity in myRecordArray) {
        sum += [entity.recordMoney doubleValue];
    }
    return sum;
}

//工资收入总金额
-(double)salarySum{
    return [self inquireIncomeSumWithType:0];
}
//奖金收入总金额
-(double)bonusSum{
    return [self inquireIncomeSumWithType:1];
}
//理财收入总金额
-(double)interestSum{
    return [self inquireIncomeSumWithType:2];
}
//其他收入总金额
-(double)incomOthersSum{
    return [self inquireIncomeSumWithType:3];
}

//增加1
-(double)additionalIncomeItem1{
    return [self inquireIncomeSumWithType:4];
}

//增加2
-(double)additionalIncomeItem2{
    return [self inquireIncomeSumWithType:5];
}

//增加3
-(double)additionalIncomeItem3{
    return [self inquireIncomeSumWithType:6];
}

//增加4
-(double)additionalIncomeItem4{
    return [self inquireIncomeSumWithType:7];
}


//收入数据数组
-(NSArray *)incomeItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"incomeClassificationSelected"];
    NSMutableArray *myArray = [@[@(self.salarySum),@(self.bonusSum),@(self.interestSum),@(self.incomOthersSum)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        double sum = [self additionalItemSum:itemStr];
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

-(NSArray *)incomeImageItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"incomeClassificationSelected"];
    NSMutableArray *myArray = [@[@"record_salary.png",@"record_bonus.png",@"record_interest.png",@"record_others.png"] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        NSString *imageStr = [self additionalItemImage:itemStr];
        [myArray insertObject:imageStr atIndex:[myArray count] - 1];
    }
    return myArray;
}

-(double)additionalItemSum:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Part-time Income",nil)]) {
        return [self inquireIncomeSumWithType:4];
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return [self inquireIncomeSumWithType:5];
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return [self inquireIncomeSumWithType:6];
    }else{
        return [self inquireIncomeSumWithType:7];
    }
}

-(NSString *)additionalItemImage:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Part-time Income",nil)]) {
        return @"record_pluralism.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return @"record_rent_income.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return @"record_gift.png";
    }else{
        return @"record_hongbao.png";
    }
}


/*  *********************************************** 支出 ******************************************/
-(double)inquireEpenditureSumWithType:(NSInteger)typeId{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"monthId":_accountingId,@"ependitureClassificationType":@(typeId)} orderBy:@"recordTime desc" offset:0 count:1000];
    for (FABAccountingRecentRecordEntity *entity in myRecordArray) {
        sum += [entity.recordMoney doubleValue];
    }
    return sum;
}


//衣支出总金额
-(double)clothesSum{
     return [self inquireEpenditureSumWithType:0];
}
//食支出总金额
-(double)foodsSum{
    return [self inquireEpenditureSumWithType:1];
}
//住支出总金额
-(double)rentsSum{
    return [self inquireEpenditureSumWithType:2];
}
//行支出总金额
-(double)faresSum{
    return [self inquireEpenditureSumWithType:3];
}
//娱乐支出总金额
-(double)entertainmentsSum{
    return [self inquireEpenditureSumWithType:4];
}
//其他支出总金额
-(double)outcomOthersSum{
    return [self inquireEpenditureSumWithType:5];
}

-(double)additionalExpenditureItem1{
    return [self inquireEpenditureSumWithType:6];
}
-(double)additionalExpenditureItem2{
    return [self inquireEpenditureSumWithType:7];
}
-(double)additionalExpenditureItem3{
    return [self inquireEpenditureSumWithType:8];
}
-(double)additionalExpenditureItem4{
    return [self inquireEpenditureSumWithType:9];
}
-(double)additionalExpenditureItem5{
    return [self inquireEpenditureSumWithType:10];
}
-(double)additionalExpenditureItem6{
    return [self inquireEpenditureSumWithType:11];
}
-(double)additionalExpenditureItem7{
    return [self inquireEpenditureSumWithType:12];
}


//收入数据数组
-(NSArray *)expenditureValueItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"expenditureClassificationSelected"];
    NSMutableArray *myArray = [@[@(self.clothesSum),@(self.foodsSum),@(self.rentsSum),@(self.faresSum),@(self.entertainmentsSum),@(self.outcomOthersSum)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        double sum = [self additionalExpenditureItemSum:itemStr];
        [myArray insertObject:@(sum) atIndex:[myArray count] - 1];
    }
    return myArray;
}
//收入数据标题数组
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

-(NSArray *)expenditureImageItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"expenditureClassificationSelected"];
    NSMutableArray *myArray = [@[@"record_clothes.png",@"record_foods.png",@"record_rent.png",@"record_fare.png",@"record_Entertainments.png",@"record_others.png"] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        NSString *imageStr = [self additionalExpenditureItemImage:itemStr];
        [myArray insertObject:imageStr atIndex:[myArray count] - 1];
    }
    return myArray;
}

-(double)additionalExpenditureItemSum:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Medical Care",nil)]) {
        return [self inquireEpenditureSumWithType:6];
    }else if ([str isEqualToString:NSLocalizedString(@"Necessary",nil)]) {
        return [self inquireEpenditureSumWithType:7];
    }else if ([str isEqualToString:NSLocalizedString(@"Cosmetology",nil)]) {
        return [self inquireEpenditureSumWithType:8];
    }else if ([str isEqualToString:NSLocalizedString(@"Social",nil)]) {
        return [self inquireEpenditureSumWithType:9];
    }else if ([str isEqualToString:NSLocalizedString(@"Education",nil)]) {
        return [self inquireEpenditureSumWithType:10];
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return [self inquireEpenditureSumWithType:11];
    }else{
        return [self inquireEpenditureSumWithType:12];
    }
}

-(NSString *)additionalExpenditureItemImage:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Medical Care",nil)]) {
        return @"record_medicine.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Necessary",nil)]) {
        return @"record_necessary.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Cosmetology",nil)]) {
        return @"record_beauty.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Social",nil)]) {
        return @"record_social.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Education",nil)]) {
        return @"record_education.png";
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return @"record_gift.png";
    }else{
        return @"record_donate.png";
    }
}






-(double)inquireEpenditureSumWithPayType:(NSInteger)typeId{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"monthId":_accountingId,@"accountingType":@1,@"payType":@(typeId)} orderBy:@"recordTime desc" offset:0 count:1000];
    for (FABAccountingRecentRecordEntity *entity in myRecordArray) {
        sum += [entity.recordMoney doubleValue];
    }
    return sum;
}



//现金支付总金额
-(double)cashSum{
    return [self inquireEpenditureSumWithPayType:0];
}
//银联支付总金额
-(double)unionPaySum{
    return [self inquireEpenditureSumWithPayType:1];
}
//微信支付总金额
-(double)weChatPaySum{
    return [self inquireEpenditureSumWithPayType:2];
}
//支付宝支付总金额
-(double)aliPaySum{
    return [self inquireEpenditureSumWithPayType:3];
}


-(double)inquireEpenditureSumWithObjectType:(NSInteger)typeId{
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray ;
    double sum = 0;
    myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:@{@"monthId":_accountingId,@"accountingType":@1,@"expenditureObjectType":@(typeId)} orderBy:@"recordTime desc" offset:0 count:1000];
    for (FABAccountingRecentRecordEntity *entity in myRecordArray) {
        sum += [entity.recordMoney doubleValue];
    }
    return sum;
}

//家庭支出总金额
-(double)familySum{
    return [self inquireEpenditureSumWithObjectType:0];
}
//自己支出总金额
-(double)wifeSum{
    return [self inquireEpenditureSumWithObjectType:1];
}
//配偶支出总金额
-(double)husbandSum{
    return [self inquireEpenditureSumWithObjectType:2];
}
//父母支出总金额
-(double)parentsSum{
    return [self inquireEpenditureSumWithObjectType:3];
}
//孩子支出总金额
-(double)childSum{
    return [self inquireEpenditureSumWithObjectType:4];
}
//其他人支出总金额
-(double)expenditureObjectOthersSum{
    return [self inquireEpenditureSumWithObjectType:5];
}


//支付方式数据数组
-(NSArray *)accountingPayTypeItems{
    return @[@(self.cashSum),@(self.unionPaySum),@(self.weChatPaySum),@(self.aliPaySum)];
}


//支付方式数据数组
-(NSArray *)expenditureObjectItems{
    return @[@(self.familySum),@(self.wifeSum),@(self.husbandSum),@(self.parentsSum),@(self.childSum),@(self.expenditureObjectOthersSum)];
}
@end
