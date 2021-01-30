//
//  FABAccountingRecentRecordCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/4.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FABAccountingRecentRecordCellType){
    FABAccountingRecentRecordCellTypeDefault  = 0,       //默认cell
    FABAccountingRecentRecordCellTypeFirst    = 1,       //第一个cell
    FABAccountingRecentRecordCellTypeLast     = 2,       //最后一个cell
    FABAccountingRecentRecordCellTypeOnlyOne  = 3,     //只有一个cell


};

@class FABAccountingRecentRecordEntity;

@interface FABAccountingRecentRecordCell : FABBaseTableViewCell

@property (nonatomic, assign) FABAccountingRecentRecordCellType cellType;

//- (void)setUpItemEntity:(FABAccountingRecentRecordEntity *)itemEntity cellType:(FABAccountingRecentRecordCellType)type;
- (void)setUpItemEntity:(FABAccountingRecentRecordEntity *)itemEntity;

@end
NS_ASSUME_NONNULL_END
