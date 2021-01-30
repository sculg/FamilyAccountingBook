//
//  FABAcumulativeCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"
#import "FABAcumulativeEntity.h"

@interface FABAcumulativeCell : FABBaseTableViewCell

- (void)setUpItemEntity:(FABAcumulativeEntity *)itemEntity;

@end
