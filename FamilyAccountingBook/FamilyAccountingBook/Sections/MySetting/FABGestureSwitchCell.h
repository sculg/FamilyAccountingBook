//
//  FABGestureSwitchCell.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseTableViewCell.h"

typedef void(^FABGestureSwitchChangeHandlerBlock)(id sender);


@interface FABGestureSwitchCell : FABBaseTableViewCell

@property(nonatomic, copy) FABGestureSwitchChangeHandlerBlock switchChangedHandlerBlock;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *switchView;

-(void)configCellWithTitle:(NSString *)title;

@end
