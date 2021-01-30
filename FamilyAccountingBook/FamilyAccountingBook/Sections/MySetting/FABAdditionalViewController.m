//
//  FABAdditionalViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/24.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABAdditionalViewController.h"
#import "FABTitleValueTableViewCell.h"
#import "FABAccountingButtonCell.h"

static NSString *AdditionalViewSectionViewID = @"AdditionalView";


@interface FABAdditionalViewController ()
@property (nonatomic, strong) NSMutableArray *baseArr;
@property (nonatomic, strong) NSMutableArray *additionalArr;
@property (nonatomic, strong) NSMutableArray *selectedAdditionalArr;
@property (nonatomic, assign) BOOL isBound;
//默认项目数
@property (nonatomic, assign) NSInteger defaultCount;
//默认插入位置
@property (nonatomic, assign) NSInteger insertIndex;

@property (nonatomic, strong) UIAlertAction *myAction;

@end

@implementation FABAdditionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setData];
    [self setUpCutomView];
}




-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"收入支出分类设置"];
    [MobClick beginLogPageView:@"收入支出分类设置"];

    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"收入支出分类设置"];
    [MobClick endLogPageView:@"收入支出分类设置"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    _isBound = NO;
    
    NSArray *myAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:self.additionalArrKey];
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:self.selectedAdditionalArrKey];
    
    _additionalArr = [myAdditionalArr mutableCopy];
    _selectedAdditionalArr = [mySelectedAdditionalArr mutableCopy];
    
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
            self.baseArr = [@[NSLocalizedString(@"Clothes",nil)
,NSLocalizedString(@"Foods",nil),NSLocalizedString(@"Rent",nil),NSLocalizedString(@"Traffic",nil),NSLocalizedString(@"Entertainment",nil),NSLocalizedString(@"Other expenses",nil)] mutableCopy];
            if ([_selectedAdditionalArr count] > 0) {
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, _selectedAdditionalArr.count)];
                [self.baseArr insertObjects:_selectedAdditionalArr atIndexes:set];
            }else{
                self.selectedAdditionalArr = [NSMutableArray array];
                self.additionalArr = [@[NSLocalizedString(@"Medical Care",nil),NSLocalizedString(@"Necessary",nil),NSLocalizedString(@"Cosmetology",nil),NSLocalizedString(@"Social",nil),NSLocalizedString(@"Education",nil),NSLocalizedString(@"Cash gift",nil),NSLocalizedString(@"Donate",nil)] mutableCopy];
            }
            break;
        case FABAdditionalType_IncomeClassification:
            self.baseArr = [@[NSLocalizedString(@"Salary",nil),NSLocalizedString(@"Bonus",nil),NSLocalizedString(@"Financing Income",nil),NSLocalizedString(@"Other income",nil)] mutableCopy];
            if ([_selectedAdditionalArr count] > 0) {
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, _selectedAdditionalArr.count)];
                [self.baseArr insertObjects:_selectedAdditionalArr atIndexes:set];
            }else{
                self.selectedAdditionalArr = [NSMutableArray array];
                self.additionalArr = [@[NSLocalizedString(@"Part-time Income",nil),NSLocalizedString(@"Cash gift",nil),NSLocalizedString(@"Rent",nil),NSLocalizedString(@"Red Packet",nil)] mutableCopy];
            }
            break;
        case FABAdditionalType_ExpenditureObjectType:
            self.baseArr = [@[NSLocalizedString(@"Family",nil),NSLocalizedString(@"Me",nil),NSLocalizedString(@"Spouse",nil),NSLocalizedString(@"Parents",nil),NSLocalizedString(@"Children",nil),NSLocalizedString(@"Other people",nil)] mutableCopy];
            if ([_selectedAdditionalArr count] > 0) {
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, _selectedAdditionalArr.count)];
                [self.baseArr insertObjects:_selectedAdditionalArr atIndexes:set];
            }else{
                self.selectedAdditionalArr = [NSMutableArray array];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.baseArr count];
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 60;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;

        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:20];
        if ([self.baseArr count] > self.defaultCount && indexPath.row > self.insertIndex && indexPath.row < [self.baseArr count] - 1) {
            NSString *myStr = [NSString stringWithFormat:@"%@  (%@)",self.baseArr[indexPath.row],NSLocalizedString(@"Added",nil)];
            [cell configCellWithTitle:myStr titleLeftOffset:10];
        }else{
            [cell configCellWithTitle:self.baseArr[indexPath.row] titleLeftOffset:20];
        }
        return cell;
    }else{
        
        FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;

//        if (!_isBound) {
//            RAC(cell.button, enabled) = [RACSignal combineLatest:@[RACObserve(self, selectedAdditionalArr)]
//                                                          reduce:^id(NSArray *selectedArr){
//                                                              BOOL enabled = [selectedArr count] < 3;
//                                                              return @(enabled);
//                                                          }];
//            _isBound = YES;
//        }
        if (!_isBound) {
            RAC(cell.button, enabled) = [RACSignal combineLatest:@[RACObserve(self, selectedAdditionalArr)]
                                                           reduce:^id(NSArray *selectedArr){
                                                               BOOL enabled = [selectedArr count] < 3;
                                                               return @(enabled);
                                                           }];
            _isBound = YES;
        }
        
        if (indexPath.row == 0) {
            cell.button.enabled = [_selectedAdditionalArr count] <=2;
            [cell configButtonWithTitle:NSLocalizedString(@"Add item",nil) topOffset:6];
            cell.btnPressedBlock = ^(){
                [self toSelectItem];
            };
        }else{
            [cell configButtonWithTitle:NSLocalizedString(@"Save",nil) topOffset:6];
            cell.btnPressedBlock = ^(){
                [self saveAdditionalItem];
            };
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AdditionalViewSectionViewID];
    return sectionView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.baseArr count] > self.defaultCount && indexPath.row > self.insertIndex && indexPath.row < [self.baseArr count] - 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.baseArr count] > self.defaultCount) {
        if (indexPath.row > self.insertIndex && indexPath.row < [self.baseArr count]) {
            
            [self.selectedAdditionalArr removeObjectAtIndex:indexPath.row - self.defaultCount + 1];
            [self.additionalArr insertObject:self.baseArr[indexPath.row]  atIndex:0];
            // 删除模型
            [self.baseArr removeObjectAtIndex:indexPath.row];
            // 刷新
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView reloadData];
        }
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Delete",nil);
}




#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(void)toSelectItem{
    
    if (self.additionalType == FABAdditionalType_ExpenditureObjectType) {
        [self showAlertView];
    }else{
        [self showPickerView];
    }
}

-(void)showAlertView{
    
    __weak typeof(self) weakSelf = self;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入分类名称"message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alert.textFields.firstObject];
    }];
    UIAlertAction *enSureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alert.textFields.firstObject];
        UITextField  *textField = alert.textFields.firstObject;

        [weakSelf.baseArr insertObject:textField.text  atIndex:[_baseArr count] - 1];
        NSInteger index1 = [_selectedAdditionalArr count] > 0 ? [_selectedAdditionalArr count] : 0;
        [weakSelf.selectedAdditionalArr insertObject:textField.text  atIndex:index1];
        [weakSelf.tableView reloadData];
        
    }];
    enSureAction.enabled = NO;
    self.myAction = enSureAction;
    [alert addAction:cancelAction];
    [alert addAction:enSureAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        textField.placeholder = @"最多4个字";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    self.myAction.enabled = textField.text.length >= 1 && textField.text.length <= 4;
}

-(void)showPickerView{
    __weak typeof(self) weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_additionalArr] initialSelection:@[@(0)] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
        NSInteger index = [[selectedIndex firstObject] integerValue];
        [weakSelf.baseArr insertObject:_additionalArr[index]  atIndex:[_baseArr count] - 1];
        NSInteger index1 = [_selectedAdditionalArr count] > 0 ? [_selectedAdditionalArr count] : 0;
        [weakSelf.selectedAdditionalArr insertObject:_additionalArr[index]  atIndex:index1];
        [weakSelf.additionalArr removeObjectAtIndex:index];
        // 删除模型
        [weakSelf.tableView reloadData];
        
    } cancelBlock:nil origin:self.view];
}



-(void)saveAdditionalItem{
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:_additionalArr forKey:self.additionalArrKey];
    [myDefault setObject:_selectedAdditionalArr forKey:self.selectedAdditionalArrKey];
    [myDefault synchronize];
    [ProgressHUD showSuccess:NSLocalizedString(@"Saved successfully",nil)];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)defaultCount{
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
            return 6;
            break;
        case FABAdditionalType_IncomeClassification:
            return 4;
            break;
        case FABAdditionalType_ExpenditureObjectType:
            return 6;
            break;
        default:
            break;
    }
}
-(NSInteger)insertIndex{
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
            return 4;
            break;
        case FABAdditionalType_IncomeClassification:
            return 2;
            break;
        case FABAdditionalType_ExpenditureObjectType:
            return 4;
            break;
        default:
            break;
    }
}

-(NSString *)titleStr{
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
//            return @"支出分类设置";
            return @"";
            break;
        case FABAdditionalType_IncomeClassification:
//            return @"收入分类设置";
            return @"";
            break;
        case FABAdditionalType_ExpenditureObjectType:
            return @"支出对象设置";
            break;
        default:
            break;
    }
}

-(NSString *)additionalArrKey{
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
            return @"expenditureClassification";
            break;
        case FABAdditionalType_IncomeClassification:
            return @"incomeClassification";
            break;
        case FABAdditionalType_ExpenditureObjectType:
            return @"expenditureObject";
            break;
        default:
            break;
    }
}


-(NSString *)selectedAdditionalArrKey{
    switch (self.additionalType) {
        case FABAdditionalType_ExpenditureClassification:
            return @"expenditureClassificationSelected";
            break;
        case FABAdditionalType_IncomeClassification:
            return @"incomeClassificationSelected";
            break;
        case FABAdditionalType_ExpenditureObjectType:
            return @"expenditureObjectSelected";
            break;
        default:
            break;
    }
}
@end
