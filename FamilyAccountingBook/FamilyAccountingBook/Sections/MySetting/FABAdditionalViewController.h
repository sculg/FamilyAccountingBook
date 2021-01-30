//
//  FABAdditionalViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/24.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABListViewController.h"

typedef NS_ENUM(NSUInteger, FABAdditionalType){
    FABAdditionalType_ExpenditureClassification        = 0,       //
    FABAdditionalType_IncomeClassification             = 1,       //
    FABAdditionalType_ExpenditureObjectType            = 2,       //
};

@interface FABAdditionalViewController : FABListViewController

@property (nonatomic, assign) FABAdditionalType additionalType;


@end
