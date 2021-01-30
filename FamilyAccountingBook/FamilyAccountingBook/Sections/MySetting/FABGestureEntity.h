//
//  FABGestureEntity.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABBaseEntity.h"

#define kFABGestureDefaultErrorMaxCount  5


@interface FABGestureEntity : FABBaseEntity

@property (nonatomic, strong) NSString *gesturePassword;

@property (nonatomic, assign) NSInteger errorCount;

@property (nonatomic, assign) NSTimeInterval enterBackgroundTime;

/* 是否启用手势密码 */
@property (nonatomic, assign) BOOL enableGesture;

@property (nonatomic, assign) BOOL touchIDSwithState;

/**
 *  关闭(禁用)手势密码
 */
- (void)disableGesture;


- (void)clearGesture;


@end
