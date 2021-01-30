//
//  FABUnlockManager.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FABTouchIDDefine.h"

#define UNLOCK_MANAGER [FABUnlockManager sharedManager]

@interface FABUnlockManager : NSObject

/** 单例 */
+ (FABUnlockManager *)sharedManager;

- (FABTouchIDType)isSupportTouchID;

- (void)evaluateTouchIDSuccess:(FABTouchIDSuccessBlock)successBlock failed:(FABTouchIDFailedBlock)failedBlock;

/** 取消当前弹出的指纹解锁 */
- (void)laContextInvalidate;
@end
