//
//  FABDayReportFormViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABListViewController.h"
#import "FABDaySummaryEntity.h"

@interface FABDayReportFormViewController : FABListViewController

@property (nonatomic, strong) NSString *curSelectedDate;
@property (nonatomic, strong) NSArray *incomeOfDays;
@property (nonatomic, strong) NSArray *expenditureOfDays;
@property (nonatomic, strong) NSArray *daysDesc;

@property (nonatomic, strong) FABDaySummaryEntity *dayEntity;

@end
