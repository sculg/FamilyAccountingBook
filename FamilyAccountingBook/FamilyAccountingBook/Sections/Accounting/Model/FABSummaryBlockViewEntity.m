//
//  FABSummaryBlockViewEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/8.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABSummaryBlockViewEntity.h"

@interface FABSummaryBlockViewEntity()
/** 颜色 */
@property (nonatomic, strong) UIColor *color;

/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 数值 */
@property (nonatomic, copy) NSString *value;

@end

@implementation FABSummaryBlockViewEntity

- (instancetype)initWithColor:(UIColor *)color
                         name:(NSString *)name
                        value:(NSString *)value {
    if (self = [super init]) {
        _color = color;
        _name = [name copy];
        _value = [value copy];
    }
    return self;
}

- (instancetype)init {
    return [self initWithColor:nil name:nil value:nil];
}
@end
