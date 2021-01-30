//
//  FABTitleButtonTableViewCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/4.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

typedef void (^DeleteBtnPressedBlock)();


@interface FABTitleButtonTableViewCell : FABBaseTableViewCell

@property (nonatomic, copy) DeleteBtnPressedBlock deleteBtnPressedBlock;


-(void)configCellWithTitle:(NSString *)title;

@end
