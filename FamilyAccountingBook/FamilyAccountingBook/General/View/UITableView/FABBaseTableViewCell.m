//
//  FABBaseTableViewCell.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseTableViewCell.h"


@interface FABBaseTableViewCell()

@end

@implementation FABBaseTableViewCell

#pragma mark - Initialize Methods

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (instancetype)initWithCellIdentifier:(NSString *)cellId
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
}

+ (id)cellForTableView:(UITableView *)tableView
{
    NSString *cellId = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellId];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

@end
