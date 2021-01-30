//
//  FABListViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/3.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import "FABListViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface FABListViewController () <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat topOffset;

@end

@implementation FABListViewController
#pragma mark - Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44.0f;
    self.tableView.backgroundColor = kDefaultBackgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if (iPhoneX) {
            //适配tableviewiphoneX底部
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomSafeHeight, 0);
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, kBottomSafeHeight, 0);
        }
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    [self autoDrawCellLineWithCell:cell indexPath:indexPath leftOffset:0.0f];
}

- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath leftOffset:(CGFloat)leftOffset
{
    [self autoDrawCellLineWithCell:cell indexPath:indexPath leftOffset:leftOffset rowHeight:self.tableView.rowHeight];
}

- (void)autoDrawCellLineWithCell:(FABBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath leftOffset:(CGFloat)leftOffset rowHeight:(CGFloat)rowHeight
{
//    cell.tableViewCellFrameHeight = rowHeight;
//    
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    
//    NSInteger rowCount = [self.tableView numberOfRowsInSection:section];
//    if (rowCount == 1) {
//        [cell setTableViewLineMode:TableViewCellLineModeTopBetweenBottom];
//    } else {
//        if (row == 0) {
//            [cell setTableViewLineMode:TableViewCellLineModeTopMiddle];
//            cell.tableViewCellLineFrameX = leftOffset;
//        }
//        else if (row == rowCount - 1) {
//            [cell setTableViewLineMode:TableViewCellLineModeBottom];
//        }
//        else {
//            [cell setTableViewLineMode:TableViewCellLineModeMiddle];
//            cell.tableViewCellLineFrameX = leftOffset;
//        }
//    }
}


- (void)updateTableViewLayout
{
    @weakify(self)
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(self.topOffset, 0.0f, 0.0f, 0.0f));
    }];
    
    [self.tableView setNeedsUpdateConstraints];
    [self.tableView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self)
        
        [self.tableView layoutIfNeeded];
    }];
}

#pragma mark - UITableView DataSource
/**
 *  必须实现，如果子类没有实现这个方法，调用[self.tableView.dataSource numberOfSectionsInTableView:self.tableView]会crach
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark -- Lazy Properties
- (NSMutableArray *)entities
{
    if (!_entities) {
        _entities = [NSMutableArray array];
    }
    return _entities;
}

#pragma mark - Handle Keyboard Notification
- (void)setResizeWhenKeyboardPresented:(BOOL)observesKeyboard
{
    if (observesKeyboard != _resizeWhenKeyboardPresented) {
        _resizeWhenKeyboardPresented = observesKeyboard;
        if (_resizeWhenKeyboardPresented) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
        else{
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
    }
}

- (void)handleKeyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(window.frame, keyboardEndRect);
    
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, bottomInset, 0.0f);
    
    NSIndexPath *indexPathOfOwnerCell = nil;
    
    NSLog(@"%@ %@", NSStringFromClass(self.class), @([self.tableView.dataSource numberOfSectionsInTableView:self.tableView]));
    for (NSInteger section = 0; section < [self.tableView.dataSource numberOfSectionsInTableView:self.tableView]; section++) {
        NSInteger numberOfCells = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:section];
        for (NSInteger counter = 0; counter < numberOfCells; counter++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:counter inSection:section];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)view;
                    if ([textField isKindOfClass:[UITextField class]] == NO)
                    {
                        continue;
                    }
                    if ([textField isFirstResponder])
                    {
                        indexPathOfOwnerCell = indexPath;
                        break;
                    }
                }
            }
        }
    }
    
    [UIView commitAnimations];
    
    if (indexPathOfOwnerCell != nil)
    {
        [self.tableView scrollToRowAtIndexPath:indexPathOfOwnerCell atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.tableView.contentInset, UIEdgeInsetsZero)){
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject = [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    [UIView beginAnimations:@"changeTableViewContentInset" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    [UIView commitAnimations];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
}


@end


NS_ASSUME_NONNULL_END
