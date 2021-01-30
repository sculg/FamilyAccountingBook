//
//  FABTouchIDDefine.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#ifndef FABTouchIDDefine_h
#define FABTouchIDDefine_h

//static NSString * const kTouchIDLocalizedReasonKey =
//static NSString * const kTouchIDNotEvaluatePolicyKey = @"您尚未设置指纹（Touch ID），请在手机系统 \"设置->Touch ID与密码\"中添加指纹";
//static NSString * const kTouchIDEvaluateSuccess = @"成功开启指纹解锁";
//static NSString * const kTouchIDEvaluateFailed = @"验证失败";
//static NSString * const kTouchIDResetSystemTouchIDTips = @"指纹校验失败，请重启系统Touch ID后验证";
//
//static NSString * const kTouchIDClickEvaluateUnlock = @"点击验证指纹解锁";
//static NSString * const kTouchIDClickSetUnlock = @"点击设置指纹解锁";
//static NSString * const kTouchIDCloseSuccess = @"指纹解锁关闭成功";
//
typedef NS_ENUM(NSUInteger,FABTouchIDType){
    /** 设备支持且有指纹 */
    FABTouchIDTypeSupport = 0,
    /** 用户验证没有通过 */
    FABTouchIDTypeAuthFailed,
    /** 设备不支持Touch ID */
    FABTouchIDTypeNotAvailable,
    /**  用户取消了Touch ID验证 */
    FABTouchIDTypeCancel,
    /**  没有录入指纹 */
    FABTouchIDTypeNotEnrolled,
    /**  系统锁住 */
    FABTouchIDTypeLockout,
    /**  App取消 */
    FABTouchIDTypeAppCancel,
};

typedef void(^FABTouchIDSuccessBlock)(void);

typedef void(^FABTouchIDFailedBlock)(FABTouchIDType type);

#endif /* FABTouchIDDefine_h */
