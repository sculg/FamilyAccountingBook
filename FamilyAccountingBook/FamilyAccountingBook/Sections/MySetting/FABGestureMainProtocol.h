//
//  FABGestureMainProtocol.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#ifndef FABGestureMainProtocol_h
#define FABGestureMainProtocol_h

@protocol XNOGestureMainProtocol <NSObject>
@required
- (void)forgetToLogin:(BOOL)otherUser;
- (void)hideMainController:(BOOL)animation;
- (void)gestureMaxCoutError;
- (void)gestureMainEvaluateTouchID;
@end

typedef NS_ENUM(NSInteger, XNOGestureMainVCType) {
    /** 验证 */
    XNOGestureMainVCTypeVerity = 0x21,
    /** 设置 */
    XNOGestureMainVCTypeSet = 0x22,
};

typedef NS_ENUM(NSInteger, XNOGestureMainErrorType) {
    /** 默认 */
    XNOGestureMainErrorTypeDefault = 0x20,
    /** 最大错误次数 */
    XNOGestureMainErrorTypeMaxCount = 0x21,
    /** 忘记手势 */
    XNOGestureMainErrorTypeForget = 0x22,
};


#endif /* FABGestureMainProtocol_h */
