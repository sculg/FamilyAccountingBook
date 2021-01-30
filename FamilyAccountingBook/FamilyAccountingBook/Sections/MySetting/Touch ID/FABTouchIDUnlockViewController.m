
//
//  FABTouchIDUnlockViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/11/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABTouchIDUnlockViewController.h"
#import "FABUnlockManager.h"
#import "FABNavigationController.h"

@interface FABTouchIDUnlockViewController ()
@property (nonatomic, strong, nullable) UILabel *userNameLabel;

@property (nonatomic, strong, nullable) UIImageView *touchIDImageView;

@property (nonatomic, strong, nullable) UILabel *touchIDLabel;

@end

@implementation FABTouchIDUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutTouchIDUI];
    [self touchEvaluateTouchID];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    if (self.isSetTouchID) {
        self.touchIDLabel.text = NSLocalizedString(@"kTouchIDClickSetUnlock",nil);
    }
    else {
        self.touchIDLabel.text = NSLocalizedString(@"kTouchIDClickEvaluateUnlock",nil);;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UNLOCK_MANAGER laContextInvalidate];
}

- (void)layoutTouchIDUI {
    
    if ([self.navigationController isKindOfClass:[FABNavigationController class]]) {
        ((FABNavigationController *)self.navigationController).canDragBack = NO;
    }
    
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.touchIDImageView];
    [self.view addSubview:self.touchIDLabel];

    
    [self autoLayoutTouchIDUI];
}
- (void)autoLayoutTouchIDUI {
    @weakify(self);
    [self.touchIDImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(@197);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.centerX.equalTo(self.view);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self.touchIDImageView.mas_top).offset(-27);
        make.centerX.equalTo(self.view);
    }];
    
    [self.touchIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.touchIDImageView.mas_bottom).offset(27);
        make.centerX.equalTo(self.view);
    }];
    
}
- (void)evaluateTouchID {
    [UNLOCK_MANAGER evaluateTouchIDSuccess:^{
//        [FABUtils shared].curGestureEntity.touchIDErrorCount = 0;
//        [FABUtils shared].curGestureEntity.touchIDFlag = kYES;
//        [FABUtils shared].curGestureEntity.touchIDEnable = kYES;
//        [[FABUtils shared] saveGestureEntity];
        if (self.isSetTouchID) {
            [ProgressHUD showSuccess:NSLocalizedString(@"kTouchIDEvaluateSuccess",nil)];
        }
        [self dismissViewController];
    } failed:^(FABTouchIDType type) {
        switch (type) {
            case FABTouchIDTypeAuthFailed:
            case FABTouchIDTypeCancel: {
                [ProgressHUD showError:NSLocalizedString(@"kTouchIDEvaluateFailed",nil)];
                break;
            }
            case FABTouchIDTypeNotEnrolled: {
                [ProgressHUD showError:NSLocalizedString(@"kTouchIDNotEvaluatePolicyKey",nil)];
                break;
            }
            case FABTouchIDTypeLockout: {
                [ProgressHUD showError:NSLocalizedString(@"kTouchIDResetSystemTouchIDTips",nil)];
                break;
            }
            default: {
                [ProgressHUD showError:NSLocalizedString(@"kTouchIDResetSystemTouchIDTips",nil)];
                break;
            }
        }
    }];
}


- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)nHideTouchID {
    [self dismissViewController];
}

- (void)touchEvaluateTouchID {
    FABTouchIDType type = [UNLOCK_MANAGER isSupportTouchID];
    switch (type) {
        case FABTouchIDTypeNotEnrolled: {
            [ProgressHUD showError:NSLocalizedString(@"kTouchIDNotEvaluatePolicyKey",nil)];
            break;
        }
        default: {
            [self evaluateTouchID];
            break;
        }
    }
}


- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = UIColorFromRGB(0x111111);
        _userNameLabel.font = kFontSize(20);
        _userNameLabel.text = NSLocalizedString(@"Dear User",nil);
    }
    return _userNameLabel;
}

- (UIImageView *)touchIDImageView {
    if (!_touchIDImageView) {
        _touchIDImageView = [[UIImageView alloc] init];
        _touchIDImageView.userInteractionEnabled = YES;
        _touchIDImageView.image = [UIImage imageNamed:@"xn_touch_id"];
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[gestureRecognizer rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self touchEvaluateTouchID];
        }];
        [_touchIDImageView addGestureRecognizer:gestureRecognizer];
    }
    return _touchIDImageView;
}


- (UILabel *)touchIDLabel {
    if (!_touchIDLabel) {
        _touchIDLabel = [[UILabel alloc] init];
        _touchIDLabel.textColor = kHighlightedTextColor;
        _touchIDLabel.font = kFontSize(16);
        _touchIDLabel.userInteractionEnabled = YES;
        _touchIDLabel.text = NSLocalizedString(@"kTouchIDClickSetUnlock",nil);
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[gestureRecognizer rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            [self touchEvaluateTouchID];
        }];
        [_touchIDLabel addGestureRecognizer:gestureRecognizer];
    }
    return _touchIDLabel;
}

@end
