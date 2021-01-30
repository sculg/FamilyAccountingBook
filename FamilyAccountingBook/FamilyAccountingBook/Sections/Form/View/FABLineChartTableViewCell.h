//
//  FABLineChartTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/29.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"
#import "FamilyAccountingBook-Bridging-Header.h"

@interface FABLineChartTableViewCell : FABBaseTableViewCell

@property (nonatomic, strong) LineChartView *myChartView;

-(void)configCellWithTitle:(NSString *)title
                 incomeArr:(NSArray *)incomeItems
            expenditureArr:(NSArray *)expenditureItems
                  monthArr:(NSArray *)monthItems;

@end
