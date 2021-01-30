//
//  FABUnlockManager.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABUnlockManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "FABTouchIDUnlockViewController.h"
#import "FABNavigationController.h"

@interface FABUnlockManager()

@property (nonatomic, strong, nullable) LAContext *curLaContext;
@property (nonatomic, strong, nonnull) FABNavigationController *touchIDNC;

@end

@implementation FABUnlockManager
/** 单例 */
+ (FABUnlockManager *)sharedManager {
    static dispatch_once_t onceToken;
    static FABUnlockManager *sharedObject;
    dispatch_once(&onceToken, ^{
        sharedObject = [[FABUnlockManager alloc] init];
    });
    return sharedObject;
}

- (FABTouchIDType)isSupportTouchID {
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return FABTouchIDTypeNotAvailable;
    }
    
    LAContext *laContext = [[LAContext alloc] init];
    laContext.localizedFallbackTitle = @"";
    LAPolicy laPolicy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    NSError *error = nil;
    
    BOOL isSupport = [laContext canEvaluatePolicy:laPolicy error:&error];
    
    FABTouchIDType touchIDType = [self handleIsSupportTouchID:isSupport error:error];
    
    [laContext invalidate];
    
    return touchIDType;
}

- (void)evaluateTouchIDSuccess:(FABTouchIDSuccessBlock)successBlock failed:(FABTouchIDFailedBlock)failedBlock {
    
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        if (failedBlock) {
            failedBlock(FABTouchIDTypeNotAvailable);
        }
        return ;
    }
    LAContext *laContext = [[LAContext alloc] init];
    laContext.localizedFallbackTitle = @"";
    
    LAPolicy laPolicy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    laPolicy = [self setupLAPolicy];

    [laContext evaluatePolicy:laPolicy localizedReason:NSLocalizedString(@"kTouchIDLocalizedReasonKey",nil) reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            NSLog(@"验证成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successBlock) {
                    successBlock();
                }
            });
        }
        else {
            NSLog(@"验证失败");
            FABTouchIDType type = [self handleIsSupportTouchID:NO error:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failedBlock) {
                    failedBlock(type);
                }
            });
        }
    }];
    
    self.curLaContext = laContext;
}

- (LAPolicy)setupLAPolicy {
    LAPolicy laPolicy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        laPolicy = LAPolicyDeviceOwnerAuthentication;
    }
    return laPolicy;
}

- (FABTouchIDType)handleIsSupportTouchID:(BOOL)isSupport error:(NSError *)error {
    
    FABTouchIDType touchIDType = FABTouchIDTypeSupport;
    
    if (!isSupport) {
        NSLog(@"isSupportTouchID : %@", error);
        switch (error.code) {
            case  LAErrorAuthenticationFailed: {
                touchIDType = FABTouchIDTypeAuthFailed;
                break;
            }
            case  LAErrorUserCancel:
            case  LAErrorSystemCancel: {
                touchIDType = FABTouchIDTypeCancel;
                break;
            }
            case  LAErrorTouchIDNotAvailable: {
                touchIDType = FABTouchIDTypeNotAvailable;
                break;
            }
            case  LAErrorTouchIDNotEnrolled: {
                touchIDType = FABTouchIDTypeNotEnrolled;
                break;
            }
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
            case  LAErrorTouchIDLockout:
                touchIDType = FABTouchIDTypeLockout;
                break;
            case  LAErrorAppCancel:
                touchIDType = FABTouchIDTypeAppCancel;
                break;
#endif
            default:
                touchIDType = FABTouchIDTypeAuthFailed;
                break;
        }
    }
    else {
        NSLog(@"支持的设备");
    }
    
//    if (touchIDType == FABTouchIDTypeNotAvailable) {
//        [FABUtils shared].curGestureEntity.touchIDFlag = kNO;
//        [FABUtils shared].curGestureEntity.touchIDEnable = kNO;
//        [FABUtils shared].curGestureEntity.touchIDErrorCount = 0;
//        [[FABUtils shared] saveGestureEntity];
//    }
    
    return touchIDType;
}

- (void)laContextInvalidate {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        if (self.curLaContext) {
            [self.curLaContext invalidate];
            self.curLaContext = nil;
        }
    }
}

- (FABNavigationController *)touchIDVC {
    FABTouchIDUnlockViewController *touchIDVC = (FABTouchIDUnlockViewController *)self.touchIDNC.viewControllers[0];
    if (![touchIDVC isKindOfClass:[FABTouchIDUnlockViewController class]]) {
        return nil;
    }
    return touchIDVC;
}
- (FABNavigationController *)touchIDNC {
    if (!_touchIDNC) {
        FABTouchIDUnlockViewController *touchIDVC = [[FABTouchIDUnlockViewController alloc] init];
        touchIDVC.isSetTouchID = YES;
        _touchIDNC = [[FABNavigationController alloc] initWithRootViewController:touchIDVC];
    }
    return _touchIDNC;
}
@end
