//
//  FABPieChartTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/28.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"
#import "FamilyAccountingBook-Bridging-Header.h"

@interface FABPieChartTableViewCell : FABBaseTableViewCell

@property (nonatomic, strong) PieChartView *myChartView;

-(void)configCellWithTitle:(NSString *)title
                  sumValue:(NSNumber *)sum
                   itemArr:(NSArray *)items
              itemValueArr:(NSArray *)itemValues;
@end
