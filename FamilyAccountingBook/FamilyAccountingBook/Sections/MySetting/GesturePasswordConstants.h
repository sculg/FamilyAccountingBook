//
//  GesturePasswordConstants.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#ifndef GesturePasswordConstants_h
#define GesturePasswordConstants_h

typedef NS_ENUM(NSInteger, FABGestureMangerViewType) {
    
    FABGestureMangerViewType_Set_Login_Setting = 0,            // 手势密码设置-登录设置
    FABGestureMangerViewType_Set_PasswordManage_Setting,       // 手势密码设置-密码管理-设置手势密码
    FABGestureMangerViewType_Set_PasswordManage_Modify,        // 手势密码设置-密码管理-修改手势密码
    
    FABGestureMangerViewType_Auth_PasswordManage_Close,         // 校验手势密码(关闭手势密码用到)
    FABGestureMangerViewType_UnLock,                            // 手势密码解锁
};


#define kGestureTitleTextColor              UIColorFromRGB(0xd2adb5)            //浅色
#define kGestureTipsTextColor               UIColorFromRGB(0x191a1a)            //深色
#define KGestureErrorTextColor              UIColorFromRGB(0xe24965)            //错误

#define KGestureButtonTextColor             KGestureErrorTextColor

#endif /* GesturePasswordConstants_h */
