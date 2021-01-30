//
//  FABGesturePasswordText.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#ifndef FABGesturePasswordText_h
#define FABGesturePasswordText_h

#pragma mark- Common
#define kGesturePasswordText         NSLocalizedString(@"Gesture password",nil)
#define kGesturePasswordSureText     NSLocalizedString(@"Confirm success",nil)

#define kGestureSkipText             @"跳过"
#define kGestureOtherLoginText       @"其他账号登录"
#define kForgetGestureText           @"忘记手势密码"
#define kForgetGestureErrorText      NSLocalizedString(@"Password is wrong",nil)
#define kForgetGestureNumberText     NSLocalizedString(@"Times",nil)

#pragma mark-XNOGestureClose
#define kGestureCloseTitle           NSLocalizedString(@"Close gesture password",nil)

#pragma mark-XNOGestureSetting
#define kGestureSettingTitle            @"设置手势密码"
#define kGestureAlertTitle              NSLocalizedString(@"Modify gesture password",nil)
#define kGestureSettingSuccessText      @"✔︎设置成功"

#define kGestureSettingDrawText         NSLocalizedString(@"Please draw the gesture password",nil)
#define kGestureSettingRedrawText       NSLocalizedString(@"Draw again to confirm",nil)
#define kGestureSettingDrawDifferText   NSLocalizedString(@"Inconsistent",nil)

#define kGestureMissCountHintText       NSLocalizedString(@"Connect at least 4 points, please redraw",nil)
#define kGestureSettingHintText         @"使用手势密码，可以更好地保护您的隐私信息"

#pragma mark-XNOGestureAuth
#define kGestureAuthUnlockText          NSLocalizedString(@"Please draw the gesture to unlock",nil)
#define kGestureAuthPerLockText         NSLocalizedString(@"Original gesture password",nil)
#define kGestureSettingNewDrawText      NSLocalizedString(@"Please draw a new gesture password",nil)

//#pragma mark-XNOLoginAuth
//#define kGestureLoginAuthPlaceholder    @"请输入登录密码验证"
//#define kGestureLoginAuthEmptyText      @"请输入登录密码验证"



#endif /* FABGesturePasswordText_h */
