//
//  FABAccountingRecentRecordEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABAccountingRecentRecordEntity.h"

@implementation FABAccountingRecentRecordEntity

- (NSString *)recordMoneyDesc{
    NSString *desc = [NSString stringWithFormat:@"%.2f",[self.recordMoney doubleValue]];
    return desc;
}

/* 收入OR支出类型的描述 */
- (NSString *)accountingTypeDesc{
    NSString *desc = @"" ;
    switch (self.accountingType) {
        case FABAccountingType_Income:
            desc = NSLocalizedString(@"Income",nil);
            break;
        case FABAccountingType_Expenditure:
            desc = NSLocalizedString(@"Expenditure",nil);
            break;
        default:
            break;
    }
    return desc;
    
}

/* 支付类型的描述 */
- (NSString *)payTypeDesc{
    
    NSString *desc = @"" ;
    switch (self.payType) {
        case FABAccountingPayType_Cash:
            desc = NSLocalizedString(@"Cash Pay",nil);
            break;
        case FABAccountingPayType_UnionPay:
            desc = NSLocalizedString(@"Union Pay",nil);
            break;
        case FABAccountingPayType_WeChatPay:
            desc = NSLocalizedString(@"Wechat Pay",nil);
            break;
        case FABAccountingPayType_AliPay:
            desc = NSLocalizedString(@"Ali Pay",nil);
            break;
        default:
            break;
    }
    return desc;
}

/* 支出类型的描述 */
- (NSString *)ependitureClassificationTypeDesc{
    
    NSString *desc = @"";
    
    switch (self.ependitureClassificationType) {
        case FABExpenditureClassificationType_Clothes:
            desc = NSLocalizedString(@"Clothes",nil)
;
            break;
        case FABExpenditureClassificationType_Foods:
            desc = NSLocalizedString(@"Foods",nil);
            break;
        case FABExpenditureClassificationType_Rents:
            desc = NSLocalizedString(@"Rent",nil);
            break;
        case FABExpenditureClassificationType_Fares:
            desc = NSLocalizedString(@"Traffic",nil);
            break;
        case FABExpenditureClassificationType_Entertainments:
            desc = NSLocalizedString(@"Entertainment",nil);
            break;
        case FABExpenditureClassificationType_Others:
            desc = NSLocalizedString(@"Other expenses",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem1:
            desc = NSLocalizedString(@"Medical Care",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem2:
            desc = NSLocalizedString(@"Necessary",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem3:
            desc = NSLocalizedString(@"Cosmetology",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem4:
            desc = NSLocalizedString(@"Social",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem5:
            desc = NSLocalizedString(@"Education",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem6:
            desc = NSLocalizedString(@"Cash gift",nil);
            break;
        case FABExpenditureClassificationType_AdditionalItem7:
            desc = NSLocalizedString(@"Donate",nil);
            break;
        default:
            break;
    }
    
    return desc;
    
}

/* 收入类型的描述 */
- (NSString *)incomeClassificationTypeDesc{
    
    NSString *desc = @"";
    
    switch (self.incomeClassificationType) {
        case FABIncomeClassificationType_Salary:
            desc = NSLocalizedString(@"Salary",nil);
            break;
        case FABIncomeClassificationType_bonus:
            desc = NSLocalizedString(@"Bonus",nil);
            break;
        case FABIncomeClassificationType_interest:
            desc = NSLocalizedString(@"Financing Income",nil);
            break;
        case FABIncomeClassificationType_others:
            desc = NSLocalizedString(@"Other income",nil);
            break;
        case FABIncomeClassificationType_AdditionalItem1:
            desc = NSLocalizedString(@"Part-time Income",nil);
            break;
        case FABIncomeClassificationType_AdditionalItem2:
            desc = NSLocalizedString(@"Rent",nil);
            break;
        case FABIncomeClassificationType_AdditionalItem3:
            desc = NSLocalizedString(@"Cash gift",nil);
            break;
        case FABIncomeClassificationType_AdditionalItem4:
            desc = NSLocalizedString(@"Red Packet",nil);
            break;
        default:
            break;
    }
    return desc;
    
}

/* 收入类型的描述 */
- (NSString *)expenditureObjectTypeeDesc{
    
    NSString *desc = @"";
    switch (self.expenditureObjectType) {
        case FABExpenditureObjectType_family:
            desc = NSLocalizedString(@"Family",nil);
            break;
        case FABExpenditureObjectType_wife:
            desc = NSLocalizedString(@"Me",nil);
            break;
        case FABExpenditureObjectType_husband:
            desc = NSLocalizedString(@"Spouse",nil);
            break;
        case FABExpenditureObjectType_parents:
            desc = NSLocalizedString(@"Parents",nil);
            break;
        case FABExpenditureObjectType_child:
            desc = NSLocalizedString(@"Children",nil);
            break;
//        case FABExpenditureObjectType_friend:
//            desc = @"朋友";
//            break;
        case FABExpenditureObjectType_thers:
            desc = NSLocalizedString(@"Other people",nil);
            break;
        default:
            break;
    }
    
    return desc;
    
}


- (FABAccountingPayType)accountingPayTypeFromIndex:(NSInteger)index{
    FABAccountingPayType type = 0;
    switch (index) {
        case 0:
            type = FABAccountingPayType_Cash;
            break;
        case 1:
            type = FABAccountingPayType_UnionPay;
            break;
        case 2:
            type = FABAccountingPayType_WeChatPay;
            break;
        case 3:
            type = FABAccountingPayType_AliPay;
            break;
        default:
            break;
    }
    return type;
}

- (FABExpenditureClassificationType)expenditureClassificationTypeFromIndex:(NSInteger)index{
    FABExpenditureClassificationType type = 0;
    switch (index) {
        case 0:
            type = FABExpenditureClassificationType_Clothes;
            break;
        case 1:
            type = FABExpenditureClassificationType_Foods;
            break;
        case 2:
            type = FABExpenditureClassificationType_Rents;
            break;
        case 3:
            type = FABExpenditureClassificationType_Fares;
            break;
        case 4:
            type = FABExpenditureClassificationType_Entertainments;
            break;
        case 5:
            type = FABExpenditureClassificationType_Others;
            break;
        case 6:
            type = FABExpenditureClassificationType_AdditionalItem1;
            break;
        case 7:
            type = FABExpenditureClassificationType_AdditionalItem2;
            break;
        case 8:
            type = FABExpenditureClassificationType_AdditionalItem3;
            break;
        case 9:
            type = FABExpenditureClassificationType_AdditionalItem4;
            break;
        case 10:
            type = FABExpenditureClassificationType_AdditionalItem5;
            break;
        case 11:
            type = FABExpenditureClassificationType_AdditionalItem6;
            break;
        case 12:
            type = FABExpenditureClassificationType_AdditionalItem7;
            break;
        default:
            break;
    }
    return type;
}

- (FABExpenditureObjectType)expenditureObjectTypeFromIndex:(NSInteger)index{
    FABExpenditureObjectType type = 0;
    switch (index) {
        case 0:
            type = FABExpenditureObjectType_family;
            break;
        case 1:
            type = FABExpenditureObjectType_wife;
            break;
        case 2:
            type = FABExpenditureObjectType_husband;
            break;
        case 3:
            type = FABExpenditureObjectType_parents;
            break;
        case 4:
            type = FABExpenditureObjectType_child;
            break;
//        case 5:
//            type = FABExpenditureObjectType_friend;
//            break;
        case 5:
            type = FABExpenditureObjectType_thers;
            break;
        default:
            break;
    }
    return type;
}

- (FABIncomeClassificationType)incomeClassificationTypeFromIndex:(NSInteger)index{
    FABIncomeClassificationType type = 0;
    switch (index) {
        case 0:
            type = FABIncomeClassificationType_Salary;
            break;
        case 1:
            type = FABIncomeClassificationType_bonus;
            break;
        case 2:
            type = FABIncomeClassificationType_interest;
            break;
        case 3:
            type = FABIncomeClassificationType_others;
            break;
        case 4:
            type = FABIncomeClassificationType_AdditionalItem1;
            break;
        case 5:
            type = FABIncomeClassificationType_AdditionalItem2;
            break;
        case 6:
            type = FABIncomeClassificationType_AdditionalItem3;
            break;
        case 7:
            type = FABIncomeClassificationType_AdditionalItem4;
            break;
        default:
            break;
    }
    return type;
}



- (FABAccountingType)accountingTypeFromIndex:(NSInteger)index{
    FABAccountingType type = 0;
    switch (index) {
        case 0:
            type = FABAccountingType_Income;
            break;
        case 1:
            type = FABAccountingType_Expenditure;
            break;
        default:
            break;
    }
    return type;
}

@end
