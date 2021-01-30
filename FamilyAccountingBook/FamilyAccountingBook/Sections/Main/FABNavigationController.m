//
//  FABNavigationController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/2.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABNavigationController.h"

@interface FABNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *horizontalLine;

@end

@implementation FABNavigationController

#pragma mark - Life Cycle
+(void)initialize {
//    [[UIBarButtonItem appearanceWhenContainedIn:[FABNavigationController class], nil] setBackButtonBackgroundImage:[UIImage imageNamed:@"default_back_normal"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[FABNavigationController class], nil] setTintColor:UIColorFromRGB(0x333333)];
    [[UINavigationBar appearanceWhenContainedIn:[FABNavigationController class], nil] setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearanceWhenContainedIn:[FABNavigationController class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x333333),NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [[UINavigationBar appearanceWhenContainedIn:[FABNavigationController class], nil] setTintColor:kWhiteColor];
    [[UINavigationBar appearanceWhenContainedIn:[FABNavigationController class], nil] setShadowImage:[UIImage new]];
}

#pragma mark -- Initialier Methods
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.canDragBack = NO;
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)loadView
{
    [super loadView];
    
    self.horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.navigationBar.bounds)-0.5f, CGRectGetWidth(self.navigationBar.bounds), 0.5f)];
    self.horizontalLine.backgroundColor = kSplitLineColor;
//    self.horizontalLine.backgroundColor = [UIColor redColor];

    [self.navigationBar addSubview:self.horizontalLine];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBarTitleTextColor,NSFontAttributeName:[UIFont systemFontOfSize:19.0f]};
//    self.navigationBar.tintColor = kBarHighlightedTextColor;
//    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark - Override Super Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers firstObject]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.viewControllers.count <= 1 || !self.canDragBack) return NO;
    return YES;
}



@end
