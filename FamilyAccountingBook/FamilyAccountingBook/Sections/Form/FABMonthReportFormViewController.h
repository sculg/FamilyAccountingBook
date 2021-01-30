//
//  FABMonthReportFormViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABListViewController.h"
#import "FABAccountingSummaryEntity.h"
#import "FABPieChartTableViewCell.h"

@interface FABMonthReportFormViewController : FABListViewController

@property (nonatomic, strong) NSString *curSelectedItem;
@property (nonatomic, strong) NSArray *incomeItems;
@property (nonatomic, strong) NSArray *expenditureItems;
@property (nonatomic, strong) NSArray *monthItems;
@property (nonatomic, strong) NSArray *tableSelectViewItems;
@property (nonatomic, strong) FABAccountingSummaryEntity *myMonthEntity;
@property (nonatomic, strong) PieChartDataEntry *pieEntry;


@end
