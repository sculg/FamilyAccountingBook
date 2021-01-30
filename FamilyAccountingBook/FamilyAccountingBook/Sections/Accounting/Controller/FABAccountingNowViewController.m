//
//  FABAccountingNowViewController.m
//  FinancialHousekeeper
//
//  Created by lg on 2017/6/6.
//  Copyright © 2017年 financialhousekeeper. All rights reserved.
//

#import "FABAccountingNowViewController.h"
#import "FABAccountingIncomeViewController.h"
#import "FABAccountingExpenditureViewController.h"
//test
#import "FABNavigationController.h"

@interface FABAccountingNowViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UISegmentedControl *segmentControl;
@property(nonatomic, strong)UIScrollView *bodyScrollView;

@property(nonatomic, strong)FABAccountingIncomeViewController *accountingIncomeVC;
@property(nonatomic, strong)FABAccountingExpenditureViewController *accountingExpenditureVC;

@end

@implementation FABAccountingNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;

    [self setupSubView];
    [self setupEvent];
    ///默认显示我的消息
    self.segmentControl.selectedSegmentIndex = 1;
    [self.bodyScrollView ss_setPageX:1];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"记账页"];
    [MobClick beginLogPageView:@"记账页"];

    ((FABNavigationController *)self.navigationController).horizontalLine.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [JANALYTICSService stopLogPageView:@"记账页"];
    [MobClick endLogPageView:@"记账页"];

    ((FABNavigationController *)self.navigationController).horizontalLine.hidden = NO;
}

#pragma mark - UI


- (void)setupSubView
{
    
    //1 创建segmentControl
    CGFloat topOffset = 1;
    CGFloat segmentHeight = [self segmentHeight];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Income",nil), NSLocalizedString(@"Expenditure",nil)]];
    self.segmentControl.frame = CGRectMake(8, topOffset, kScreenWidth - 2*8, segmentHeight);
    [self.view addSubview:self.segmentControl];
    [self setupSegmentControl];
    
    //2 创建scrollView
    
    CGFloat scrollHeight = kScreenHeight - 64 - segmentHeight - topOffset;
    CGSize contentSize   = CGSizeMake(kScreenWidth * 2, scrollHeight);
    
    self.bodyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, scrollHeight)];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.bodyScrollView.contentSize = contentSize;
    self.bodyScrollView.delegate    = self;
    [self.bodyScrollView ss_defaultConfig];
    [self.view addSubview:self.bodyScrollView];
    
    //3 添加记录列表
    CGRect tableViewFrame = CGRectMake(0, 0, kScreenWidth, scrollHeight);
    
    self.accountingIncomeVC.view.frame = tableViewFrame;
    [self addChildViewController:self.accountingIncomeVC inView:self.bodyScrollView atFrame:tableViewFrame];
    tableViewFrame.origin.x = kScreenWidth;
    self.accountingExpenditureVC.view.frame = tableViewFrame;
    [self addChildViewController:self.accountingExpenditureVC inView:self.bodyScrollView atFrame:tableViewFrame];

    
}

- (void)addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame {
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    
    controller.view.frame = frame;
    [view addSubview:controller.view];
    
    [controller didMoveToParentViewController:self];
}

- (CGFloat)segmentHeight
{
    return 39.0;
}

- (void)setupSegmentControl
{
        // 设置边框圆角
    UIColor *borderColor = kPieYellowColor;
//    [self.segmentControl ss_setCornerRadius:6.0];
//    [self.segmentControl ss_setBorderWidth:2 borderColor:borderColor];
    
    self.segmentControl.tintColor       = borderColor;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    
    NSParagraphStyle *paragraphStyle = [UILabel ss_paragraphStyleWithAlignment:NSTextAlignmentCenter lineSpace:0];
    NSDictionary *normalAttrDic = @{NSFontAttributeName:kFontSize(14),
                                    NSForegroundColorAttributeName:kPieYellowColor,
                                    NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary *normalAttrDic1 = @{NSFontAttributeName:kFontSize(14),
                                    NSForegroundColorAttributeName:kWhiteColor,
                                    NSParagraphStyleAttributeName:paragraphStyle};
    [self.segmentControl setTitleTextAttributes:normalAttrDic forState:UIControlStateNormal];
    [self.segmentControl setTitleTextAttributes:normalAttrDic1 forState:UIControlStateSelected];
    [self.segmentControl setTitleTextAttributes:normalAttrDic forState:UIControlStateHighlighted];
    
}


- (void)setupEvent {
    
    @weakify(self);
    [self.segmentControl bk_addEventHandler:^(id sender) {
        
        @strongify(self);
        
        NSInteger index = self.segmentControl.selectedSegmentIndex;
        [self.bodyScrollView ss_setPageX:index animated:YES];
        
    } forControlEvents:UIControlEventValueChanged];
    
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        
        if (scrollView.isDragging) {
            CGFloat pageWidth = scrollView.frame.size.width;
            NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            
            self.segmentControl.selectedSegmentIndex = page;
        }
    }
}




- (FABAccountingIncomeViewController *)accountingIncomeVC{
    
    if (!_accountingIncomeVC) {

        _accountingIncomeVC = [[FABAccountingIncomeViewController alloc] init];
    }
    return _accountingIncomeVC;
}

- (FABAccountingExpenditureViewController *)accountingExpenditureVC{
    
    if (!_accountingExpenditureVC) {
        
        _accountingExpenditureVC = [[FABAccountingExpenditureViewController alloc] init];
    }
    return _accountingExpenditureVC;
}

@end
