//
//  XNOKeyboardExtensionView.m
//  XNOnline
//
//  Created by Liuyu on 15/4/30.
//  Copyright (c) 2015年 xiaoniu88. All rights reserved.
//

#import "XNOKeyboardExtensionView.h"

@implementation XNOKeyboardExtensionView

#pragma mark - Initialize Methods
+ (instancetype)createView
{
    XNOKeyboardExtensionView *keyboardExtensionView = [[XNOKeyboardExtensionView alloc] init];
    return keyboardExtensionView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initLayout];
    }
    return self;
}

#pragma mark - Private Methods
- (void)initLayout
{
//    self.frame = [self getHideFrame];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect rect = CGRectMake(0.0f, 0.0f, CGRectGetWidth(screenRect), kKeyboardExtensionViewH);
    self.frame = rect;
    self.backgroundColor = UIColorFromRGB(0xfdfdfd);
    
    UIImage *image = [UIImage imageNamed:@"keyboard_arrow"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    imageView.userInteractionEnabled = YES;
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 60.0f, 0.0f, 60.0f, 44.0f);
    imageView.frame = CGRectMake((CGRectGetWidth(doneButton.frame) - image.size.height)/2, (CGRectGetHeight(doneButton.frame) - image.size.width)/2, image.size.height, image.size.width);
    [doneButton addSubview:imageView];
    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneButton];
}

#pragma mark - Target Actions
- (void)doneButtonPressed
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

//- (CGRect)getHideFrame
//{
//    CGRect screenRect = [UIScreen mainScreen].bounds;
//    CGRect rect = CGRectMake(0.0f, CGRectGetMaxY(screenRect), CGRectGetWidth(screenRect), kViewHeight);
//    return rect;
//}
//
//- (CGRect)getShowFrameWithKeyboardFrame:(CGRect)keyboardFrame
//{
//    CGFloat originalY = CGRectGetMinY(keyboardFrame) - CGRectGetHeight(self.frame);
//    CGRect screenRect = [UIScreen mainScreen].bounds;
//    CGRect rect = CGRectMake(0.0f, originalY, CGRectGetWidth(screenRect), kViewHeight);
//    return rect;
//}

#pragma mark - Public Methods
//- (void)showWithKeyboardFrame:(CGRect)keyboardFrame
//{
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    if (!self.superview) {
//        [keyWindow addSubview:self];
//    }
//    
//    typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.3 animations:^{
//        weakSelf.frame = [weakSelf getShowFrameWithKeyboardFrame:keyboardFrame];
//    }];
//}
//
//- (void)hide
//{
//    typeof(self) weakSelf = self;
//    [UIView animateWithDuration:0.3 animations:^{
//        weakSelf.frame = [weakSelf getHideFrame];
//    } completion:^(BOOL finished) {
//        if (weakSelf.superview)
//        {
//            [weakSelf removeFromSuperview];
//        }
//    }];
//}

#pragma mark - Override Super Method
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0.0f, 0.5f);
    CGContextAddLineToPoint(context, rect.size.width, 0.5f);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 0.0f, CGRectGetMaxY(rect) - 0.5);
    CGContextAddLineToPoint(context, rect.size.width, CGRectGetMaxY(rect) - 0.5f);
    CGContextStrokePath(context);
}

@end
