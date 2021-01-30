//
//  FABSummaryBlockViewEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/8.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

@interface FABSummaryBlockViewEntity : FABBaseEntity

/** 颜色 */
@property (nonatomic, strong, readonly) UIColor *color;

/** 名字 */
@property (nonatomic, copy, readonly) NSString *name;

/** 数值 */
@property (nonatomic, copy, readonly) NSString *value;

/** 指定构造方法 */
- (instancetype)initWithColor:(UIColor *)color
                         name:(NSString *)name
                        value:(NSString *)value NS_DESIGNATED_INITIALIZER;

@end
