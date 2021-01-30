//
//  FABTableSelectView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/1.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABTableSelectView.h"
#import "FABTitleValueTableViewCell.h"
#import "FABNavigationController.h"
#import "FABAppDelegate.h"
#import "FABAppUtils.h"

#define kSelectTableViewRowNum [tableViewItems count] < 5 ? [tableViewItems count] : 5;
static const CGFloat kSelectTableViewWidth = 88.0f;

@interface FABTableSelectView()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *tableViewItems;
@property (nonatomic, strong) NSString *selectedItem;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FABTableSelectView
#pragma mark - init Method

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelfView)];
        [self addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = kWhiteColor;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
         [[self getCurrentTopViewController].view addSubview:self];
    }
    return self;
}

#pragma mark - class Method

+ (instancetype)initTableSelectViewWithItems:(NSArray *)tableViewItems
                             curSelectedItem:(NSString *)curSelectedItem
                              selectedResult:(FABTableSelectViewBlock)selectedResult{
    
    NSInteger rowNum = kSelectTableViewRowNum;
    CGFloat topOffset = kScreenHeight * 0.5 - 30 * rowNum * 0.5;
    CGFloat leftOffset = kScreenWidth * 0.5 - kSelectTableViewWidth * 0.5;
    
    return [self initTableSelectViewWithTopOffset:topOffset
                                 leftOffset:leftOffset
                             tableSelectViewItems:tableViewItems
                            curSelectedItem:curSelectedItem
                             selectedResult:selectedResult];
    
}

+ (instancetype)initTableSelectViewWithTopOffset:(CGFloat)topOffset
                            tableSelectViewItems:(NSArray *)tableViewItems
                                 curSelectedItem:(NSString *)curSelectedItem
                                  selectedResult:(FABTableSelectViewBlock)selectedResult{
    
    CGFloat leftOffset = kScreenWidth * 0.5 - kSelectTableViewWidth * 0.5;
    
    return [self initTableSelectViewWithTopOffset:topOffset
                                 leftOffset:leftOffset
                             tableSelectViewItems:tableViewItems
                            curSelectedItem:curSelectedItem
                             selectedResult:selectedResult];
}

+ (instancetype)initTableSelectViewWithTopOffset:(CGFloat)topOffset
                                      leftOffset:(CGFloat)leftOffset
                            tableSelectViewItems:(NSArray *)tableViewItems
                                 curSelectedItem:(NSString *)curSelectedItem
                                  selectedResult:(FABTableSelectViewBlock)selectedResult{
    
    NSInteger rowNum = kSelectTableViewRowNum;
    FABTableSelectView *selectTableView = [[FABTableSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    selectTableView.backgroundColor = [UIColor colorWithRed:245/255 green:245/255 blue:245/255 alpha:0.1];
    [selectTableView.tableView setFrame:CGRectMake(leftOffset, topOffset, kSelectTableViewWidth, 36 * rowNum)];
    selectTableView.tableView.layer.masksToBounds = YES;
    selectTableView.tableView.layer.cornerRadius = 3;
    
    selectTableView.tableViewItems = tableViewItems;
    selectTableView.selectedItem = curSelectedItem;
    selectTableView.tableSelectedViewBlock = selectedResult;
    
    return selectTableView;
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FABTitleValueTableViewCell *tempCell = [FABTitleValueTableViewCell cellForTableView:tableView];
//    [tableView addLineforPlainCell:tempCell forRowAtIndexPath:indexPath withLeftSpace:0];
    [self configureCell:tempCell forRowAtIndexPath:indexPath];
    
    return tempCell;
}

- (void)configureCell:(FABTitleValueTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cur = self.tableViewItems[indexPath.row];
    
    if ([self.tableViewItems count] > 1) {
        if ([self.selectedItem isEqualToString: cur]) {
            //选中
            [cell configCellWithTitle:self.tableViewItems[indexPath.row] titleLeftOffset:6 bgColor:kMainCommonOppositionColor];
        } else {
            //未选中
            [cell configCellWithTitle:self.tableViewItems[indexPath.row] titleLeftOffset:6 bgColor:kWhiteColor];
        }
    }else{
        [cell configCellWithTitle:self.tableViewItems[indexPath.row] titleLeftOffset:6 bgColor:kWhiteColor];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *itemValue = self.tableViewItems[indexPath.row];
    self.selectedItem = itemValue;
    if (self.tableSelectedViewBlock) {
        self.tableSelectedViewBlock(itemValue);
    }
   [self removeFromSuperview];
}

#pragma mark - private method

- (void)removeSelfView{
    if (self.tableSelectedViewBlock) {
        self.tableSelectedViewBlock(@"0");
    }
    [self removeFromSuperview];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}

#pragma mark - 获取当前视图控制器


- (UIViewController *)getCurrentTopViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}


-(void)hideView{
    [self removeFromSuperview];
}
@end
