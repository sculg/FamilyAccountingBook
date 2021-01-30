//
//  FABMainViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/2.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABMainViewController.h"

#import "FABNavigationController.h"
 /* 记账 */
#import "FABAccountingViewController.h"
/* 家庭计划 */
#import "FABMySettingViewController.h"
/* 报表 */
#import "FABReportFormViewController.h"

@interface FABMainViewController () <UITabBarControllerDelegate>

@property (nonatomic, weak) FABNavigationController *myNavigationController;

@end

@implementation FABMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
}

- (void)setupLayout{
    
    FABAccountingViewController *accountingViewController = [[FABAccountingViewController alloc] init];
    FABNavigationController *accountingNavigationController = [self.class viewController:accountingViewController
                                                                                  title:NSLocalizedString(@"Account",nil)
                                                                        normalImageName:@"tabbar_item_accounting_normal"
                                                                      selectedImageName:@"tabbar_item_accounting_selected"];
    
    FABMySettingViewController *mysettingViewController = [[FABMySettingViewController alloc] init];
    FABNavigationController *mysettingNavigationController = [self.class viewController:mysettingViewController
                                                                                  title:NSLocalizedString(@"Me",nil)
                                                                        normalImageName:@"tabbar_item_mysetting_normal"
                                                                      selectedImageName:@"tabbar_item_mysetting_selected"];
    
    FABReportFormViewController *reportFormViewController = [[FABReportFormViewController alloc] init];
    FABNavigationController *reportFormNavigationController = [self.class viewController:reportFormViewController
                                                                                  title:NSLocalizedString(@"Report",nil)
                                                                        normalImageName:@"tabbar_item_reportform_normal"
                                                                      selectedImageName:@"tabbar_item_reportform_selected"];
    
    
    self.myTabBarController = [[UITabBarController alloc] init];
    self.myTabBarController.delegate = self;
    self.myTabBarController.viewControllers = @[accountingNavigationController, reportFormNavigationController,mysettingNavigationController];
    [self.view addSubview:self.myTabBarController.view];
    [self addTabBarLine];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x7A7E83)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kMainCommonColor} forState:UIControlStateSelected];
}

-(void)addTabBarLine{
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.myTabBarController.tabBar.bounds), 0.5f)];
    horizontalLine.backgroundColor = kSplitLineColor;
    [self.myTabBarController.tabBar addSubview:horizontalLine];
}


+ (FABNavigationController *)viewController:(UIViewController *)viewController
                                      title:(NSString *)title
                            normalImageName:(NSString *)normalImageName
                          selectedImageName:(NSString *)selectedImageName
{
    FABNavigationController *navigationController = [[FABNavigationController alloc] initWithRootViewController:viewController];
    navigationController.tabBarItem.title = title;
    [navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    navigationController.tabBarItem.image = [[UIImage imageWithContentsOfFileName:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.selectedImage = [[UIImage imageWithContentsOfFileName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
    navigationController.canDragBack = YES;
    return navigationController;
}

@end
