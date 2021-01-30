//
//  FABBaseEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "LKDBHelper.h"

NS_ASSUME_NONNULL_BEGIN


@interface FABBaseEntity : NSObject

//字典转换为Model
+ (instancetype)parserEntityWithDictionary:(NSDictionary *)dictionary;

//字典数组转换为Model数组
+ (NSMutableArray *)parserEntityArrayWithArray:(NSArray *)arr;

@end
NS_ASSUME_NONNULL_END
