//
//  FABRecordCommonViewController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/5.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABListViewController.h"

@interface FABRecordCommonViewController : FABListViewController

@property (nonatomic, assign) BOOL isIncome;

@property (nonatomic, copy) NSString *monthId;

@property (nonatomic, assign) NSInteger typeId;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, assign) NSInteger payTarget;


@end
