//
//  FABGestureEntity.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureEntity.h"

@implementation FABGestureEntity


/**
 *  关闭(禁用)手势密码
 */
- (void)disableGesture
{
    self.gesturePassword = @"";
    
    self.enableGesture   = NO;
    self.errorCount      = kFABGestureDefaultErrorMaxCount;
}


- (void)clearGesture
{

    self.gesturePassword = @"";
    
    self.enableGesture   = NO; //默认开启
    self.errorCount      = kFABGestureDefaultErrorMaxCount;
}



#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"password = %@, enableGesture = %d\n",
            self.gesturePassword,
            self.enableGesture];
}


@end
