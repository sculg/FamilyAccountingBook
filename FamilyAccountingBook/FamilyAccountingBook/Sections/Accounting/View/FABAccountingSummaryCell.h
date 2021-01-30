//
//  FABAccountingSummaryCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class FABAccountingSummaryEntity;

@interface FABAccountingSummaryCell : FABBaseTableViewCell

- (void)setUpItemEntity:(FABAccountingSummaryEntity *)itemEntity;

@end

NS_ASSUME_NONNULL_END
