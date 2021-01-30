//
//  FABBaseEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

@implementation FABBaseEntity

+(LKDBHelper *)getUsingLKDBHelper{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[LKDBHelper alloc]init];
    });
    return db;
}

+ (instancetype)parserEntityWithDictionary:(NSDictionary *)dictionary {
    
    if(!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [self yy_modelWithJSON:dictionary];
}


+ (NSMutableArray *)parserEntityArrayWithArray:(NSArray *)arr {
    
    if(!arr || ![arr isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        FABBaseEntity *entity = [self parserEntityWithDictionary:dic];
        if (entity){
            [resultArr addObject:entity];
        }
    }
    
    return resultArr;
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}

- (NSUInteger)hash
{
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object
{
    return [self yy_modelIsEqual:object];
}



@end
