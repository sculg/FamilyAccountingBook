//
//  FABBaseViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/1.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABBaseViewController.h"
#import "PINCache.h"



@interface FABBaseViewController ()

@end

@implementation FABBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kDefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetBackButton];
}


#pragma mark - Private Methods
- (void)resetBackButton
{
    NSInteger count = self.navigationController.viewControllers.count;
    
    if (count == 1) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else {
        self.navigationItem.leftBarButtonItem = [self defaultBackBarItem];
    }
}

#pragma mark - Bar Button
#pragma mark -- Bar Button Private
- (UIBarButtonItem *)defaultBackBarItemWithPressedSelector:(SEL)pressedSelector
                                                     title:(nullable NSString *)title
                                               normalImage:(UIImage *)normalImage
                                          highlightedImage:(UIImage *)highlightedImage
                                          normalTitleColor:(UIColor *)normalTitleColor
                                          highlightedColor:(UIColor *)highlightedColor
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0f, 0.0f, 55.0f, 44.0f);
    [backButton setTitle:title forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [backButton setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [backButton setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton setImage:highlightedImage forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, CGRectGetWidth(backButton.bounds) - normalImage.size.width);
    [backButton addTarget:self action:pressedSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return barButtonItem;
}

- (UIBarButtonItem *)defaultBackBarItem
{
    return [self defaultBackBarItemWithPressedSelector:@selector(backButtonPressed:)
                                                 title:nil
                                           normalImage:[UIImage imageWithContentsOfFileName:@"default_back_normal"]
                                      highlightedImage:[UIImage imageWithContentsOfFileName:@"default_back_highlighted"]
                                      normalTitleColor:kTitleTextColor
                                      highlightedColor:kBarHighlightedTextColor];
}

#pragma mark -- Bar Button Public
- (UIBarButtonItem *)closeBarItemWithPressedSelector:(SEL)pressedSelector
{
    return [self defaultBackBarItemWithPressedSelector:pressedSelector
                                                 title:nil
                                           normalImage:[UIImage imageWithContentsOfFileName:@"default_close_normal"]
                                      highlightedImage:[UIImage imageWithContentsOfFileName:@"default_close_highlighted"]
                                      normalTitleColor:kTitleTextColor
                                      highlightedColor:kBarHighlightedTextColor];
}

- (UIBarButtonItem *)whiteBackBarItem
{
    return [self defaultBackBarItemWithPressedSelector:@selector(backButtonPressed:)
                                                 title:nil
                                           normalImage:[UIImage imageWithContentsOfFileName:@"white_back_normal"]
                                      highlightedImage:[UIImage imageWithContentsOfFileName:@"white_back_normal"]
                                      normalTitleColor:kWhiteColor
                                      highlightedColor:kWhiteColor];
}


- (void)backButtonPressed:(nullable id)sender
{
    [self goBackDirection];
}

/**
 导航栏返回（用于block调用）
 */
- (void)goBackDirection
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBarButtonWithTitle:(NSString *)title isLeft:(BOOL)isLeft TextColor:(UIColor *)defaultColor HighColor:(UIColor *)highColor;
{
    CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(100.0f, 44.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil].size.width;
    
    SEL pressedSelector = nil;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0.0f, 0.0f, 80.0f, 44.0f);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:defaultColor forState:UIControlStateNormal];
    [button setTitleColor:highColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, (CGRectGetWidth(button.bounds) - titleWidth));
        self.navigationItem.leftBarButtonItem = barButtonItem;
        pressedSelector = NSSelectorFromString(@"leftBarButtonPressed:");
    }
    else {
        button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, CGRectGetWidth(button.bounds) - titleWidth, 0.0f, 0.0f);
        self.navigationItem.rightBarButtonItem = barButtonItem;
        pressedSelector = NSSelectorFromString(@"rightBarButtonPressed:");
    }
    [button addTarget:self action:pressedSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBarButtonWithTitle:(NSString *)title isLeft:(BOOL)isLeft{
    [self addBarButtonWithTitle:title isLeft:isLeft TextColor:kTitleTextColor HighColor:kBarHighlightedTextColor];
}

- (void)addBarButtonWithImage:(UIImage *)image isLeft:(BOOL)isLeft
{
    //    CGFloat titleWidth = [image boundingRectWithSize:CGSizeMake(100.0f, 44.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil].size.width;
    
    SEL pressedSelector = nil;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0.0f, 0.0f, 40.0f, 44.0f);
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -10);
        self.navigationItem.leftBarButtonItem = barButtonItem;
        pressedSelector = NSSelectorFromString(@"leftBarButtonPressed:");
    }
    else {
        button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 0, 0.0f, 0.0f);
        self.navigationItem.rightBarButtonItem = barButtonItem;
        pressedSelector = NSSelectorFromString(@"rightBarButtonPressed:");
    }
    [button addTarget:self action:pressedSelector forControlEvents:UIControlEventTouchUpInside];
}
- (void)rightBarButtonPressed:(id)sender
{
    
}

- (void)leftBarButtonPressed:(id)sender
{
    
}

#pragma mark - Custom Push And Pop
#pragma mark -- Custom Push And Pop Public
- (void)pushNormalViewController:(UIViewController *)viewController
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)popToRootAndPushNormalViewController:(UIViewController *)viewController
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    UIViewController *navigationController = self.navigationController.viewControllers[0];
    [self.navigationController popToRootViewControllerAnimated:NO];
    viewController.hidesBottomBarWhenPushed = YES;
    [navigationController.navigationController pushViewController:viewController animated:YES];
}





@end
