//
//  FABSecurityEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

@interface FABSecurityEntity : FABBaseEntity

@property (nonatomic, assign) NSInteger NumberOneId;
@property (nonatomic, assign) NSInteger NumberTwoId;
@property (nonatomic, assign) NSInteger NumberThreeId;

@property (nonatomic, copy) NSString *NumberOneAnswer;
@property (nonatomic, copy) NSString *NumberTwoAnswer;
@property (nonatomic, copy) NSString *NumberThreeAnswer;

@end
