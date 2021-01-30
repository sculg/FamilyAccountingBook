//
//  FABAccountingExpenditureViewController.h
//  FinancialHousekeeper
//
//  Created by lg on 2017/6/6.
//  Copyright © 2017年 financialhousekeeper. All rights reserved.
//

#import "FABListViewController.h"
#import "FABAccountingRecentRecordEntity.h"


@interface FABAccountingExpenditureViewController : FABListViewController

@property (nonatomic, strong) FABAccountingRecentRecordEntity *myEntity;

@property (nonatomic, assign) BOOL isToChangeData;
@property (nonatomic, assign) BOOL isToSetTemplate;

@end
