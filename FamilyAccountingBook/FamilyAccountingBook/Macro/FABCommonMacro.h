//
//  FABCommonMacro.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/1.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#ifndef FABCommonMacro_h
#define FABCommonMacro_h

#define kHomePageCommonRecordItemsNumber             10

//隐藏手势密码
#define FAB_NOTIFICATION_HIDE_GESTURE_PASSWORD  @"notification_hide_gesture_password"

//弹手势密码
#define XNL_NOTIFICATION_POP_GESTURE_PASSWORD   @"notification_pop_gesture_password"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif /* FABCommonMacro_h */
