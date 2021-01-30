//
//  FABSecurityViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/6.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABSecurityViewController.h"
#import "FABTitleValueTableViewCell.h"
#import "FABTableViewSectionView.h"
#import "FABTextFieldTableViewCell.h"
#import "FABAccountingButtonCell.h"
#import "FABSecurityEntity.h"
#import "FABAppDelegate.h"
#import "FABGestureEntity.h"

static NSString *SecuritySectionViewID = @"SecuritySectionViewID";

@interface FABSecurityViewController ()

@property (nonatomic, strong) FABSecurityEntity *myEntity;

@property (nonatomic, strong) FABSecurityEntity *myAuthEntity;

@property (nonatomic, strong) NSArray *questionArray1;
@property (nonatomic, strong) NSArray *questionArray2;
@property (nonatomic, strong) NSArray *questionArray3;

@property (nonatomic, assign) BOOL isSecurityQuestionExist;

@property (nonatomic, strong) FABGestureEntity *gestureEntity;

@end

@implementation FABSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
//    self.title = self.isSecurityQuestionExist ? @"密保已设置":@"密保设置";
    [self setUpCutomView];
    if (!_isSecurityQuestionExist) {
        [self showAlertView];
    }
}

-(void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil) message:NSLocalizedString(@"Please keep in mind the secret answer!",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Got it",nil)style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    if(self.isToAuth){
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    }
    [self.tableView registerClass:[FABTableViewSectionView class] forHeaderFooterViewReuseIdentifier:SecuritySectionViewID];
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];
    
}

- (void)setData{
    self.isSecurityQuestionExist = NO;
    NSData * myData = [[NSUserDefaults standardUserDefaults] objectForKey:@"securityQuestion"];
    if(myData){
        self.isSecurityQuestionExist = YES;
        self.myEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
    self.questionArray1 = @[NSLocalizedString(@"Your first boss's name",nil),NSLocalizedString(@"The name of your high school class teacher",nil),NSLocalizedString(@"The name of your best friend",nil)];
    self.questionArray2 = @[NSLocalizedString(@"Where did you go for the first time by plane",nil),NSLocalizedString(@"Where did you go by train for the first time",nil),NSLocalizedString(@"Where did you go by ship for the first time",nil)];
    self.questionArray3 = @[NSLocalizedString(@"What is your ideal job",nil),NSLocalizedString(@"What is your first nickname",nil),NSLocalizedString(@"Who is your favorite singer",nil)];
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isSecurityQuestionExist && _isToAuth == NO) {
        return 3;
    }
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 3) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 && indexPath.row == 0) {
        return 60;
    }else{
        return 40;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    FABTextFieldTableViewCell *cell1 = [FABTextFieldTableViewCell cellForTableView:tableView];
    cell1.accessoryType = UITableViewCellAccessoryNone;
    FABAccountingButtonCell *cell2 = [FABAccountingButtonCell cellForTableView:tableView];
    cell2.accessoryType = UITableViewCellAccessoryNone;
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    [tableView addLineforPlainCell:cell1 forRowAtIndexPath:indexPath withLeftSpace:10];
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle  = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle  = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell configCellWithTitle:_questionArray1[self.myEntity.NumberOneId] titleLeftOffset:10];
        return cell;
    }else if (indexPath.section == 0 && indexPath.row == 1 ){
        if (_isSecurityQuestionExist && self.isToAuth == NO) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell configCellWithTitle:@"****" titleLeftOffset:10];
            return cell;
        }else if(self.isToAuth){
            cell1.textField.text = self.myAuthEntity.NumberOneAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myAuthEntity.NumberOneAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }else{
            cell1.textField.text = self.myEntity.NumberOneAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myEntity.NumberOneAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }

    }else if (indexPath.section == 1 && indexPath.row == 0 ){
        [cell configCellWithTitle:_questionArray2[self.myEntity.NumberTwoId] titleLeftOffset:10];
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 1 ){
        
        
        if (_isSecurityQuestionExist && self.isToAuth == NO) {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell configCellWithTitle:@"****" titleLeftOffset:10];
            return cell;
            
        }else if(self.isToAuth){
            cell1.textField.text = self.myAuthEntity.NumberTwoAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myAuthEntity.NumberTwoAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }else{
            cell1.textField.text = self.myEntity.NumberTwoAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myEntity.NumberTwoAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }
    }else if (indexPath.section == 2 && indexPath.row == 0 ){
        [cell configCellWithTitle:_questionArray3[self.myEntity.NumberThreeId] titleLeftOffset:10];
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 1 ){
        if (_isSecurityQuestionExist && self.isToAuth == NO) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell configCellWithTitle:@"****" titleLeftOffset:10];
            return cell;
        }else if(self.isToAuth){
            cell1.textField.text = self.myAuthEntity.NumberThreeAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myAuthEntity.NumberThreeAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }else{
            cell1.textField.text = self.myEntity.NumberThreeAnswer;
            cell1.editingBlock = ^(NSString *value){
                self.myEntity.NumberThreeAnswer = value;
                [self.tableView reloadData];
            };
            return cell1;
        }
    }else{
        if (!_isToAuth) {
            [cell2 configButtonWithTitle:NSLocalizedString(@"Save",nil)];
            cell2.btnPressedBlock = ^(){
                [self saveEntity];
            };
        }else{
            [cell2 configButtonWithTitle:NSLocalizedString(@"Verify security question",nil)];
            cell2.btnPressedBlock = ^(){
                [self toAuth];
            };
        }
        
        return cell2;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SecuritySectionViewID];
    switch (section) {
        case 0:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Question 1",nil)];
            break;
        case 1:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Question 2",nil)];
            break;
        case 2:
            [sectionView configHeadViewWithTitle:NSLocalizedString(@"Question 2",nil)];
            break;
        default:
            [sectionView configHeadViewWithTitle:@""];
            break;
    }
    
    return sectionView;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 25 ;
    
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isToAuth != YES) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            NSNumber *num = [NSNumber numberWithInteger:self.myEntity.NumberOneId];
            [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_questionArray1] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                
                NSInteger index = [[selectedIndex firstObject] integerValue];
                self.myEntity.NumberOneId = index;
                [self.tableView reloadData];
                
            } cancelBlock:nil origin:self.view];
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            NSNumber *num = [NSNumber numberWithInteger:self.myEntity.NumberTwoId];
            [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_questionArray2] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                
                NSInteger index = [[selectedIndex firstObject] integerValue];
                self.myEntity.NumberTwoId = index;
                [self.tableView reloadData];
                
            } cancelBlock:nil origin:self.view];
        }else if (indexPath.section == 2 && indexPath.row == 0){
            NSNumber *num = [NSNumber numberWithInteger:self.myEntity.NumberThreeId];
            [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_questionArray3] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                
                NSInteger index = [[selectedIndex firstObject] integerValue];
                self.myEntity.NumberThreeId = index;
                [self.tableView reloadData];
                
            } cancelBlock:nil origin:self.view];
        }
    }
}

-(FABSecurityEntity *)myEntity{
    if (!_myEntity) {
        _myEntity = [[FABSecurityEntity alloc] init];
    }
    return _myEntity;
}

-(FABSecurityEntity *)myAuthEntity{
    if (!_myAuthEntity) {
        _myAuthEntity = [[FABSecurityEntity alloc] init];
    }
    return _myAuthEntity;
}

-(void)toAuth{
    if ([self.myAuthEntity.NumberOneAnswer isEqualToString:self.myEntity.NumberOneAnswer] && [self.myAuthEntity.NumberTwoAnswer isEqualToString:self.myEntity.NumberTwoAnswer] && [self.myAuthEntity.NumberThreeAnswer isEqualToString:self.myEntity.NumberThreeAnswer]) {
//        [ProgressHUD showSuccess:@"验证成功"];
        [self getGestureEntity];
        self.gestureEntity.errorCount = 5;
        self.gestureEntity.enableGesture = NO;
        [self upDateGestureEntity];
        [self toTabBar];
    }else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sorry",nil) message:NSLocalizedString(@"Verification failed",nil) preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Exit immediately",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
            exit(0);
        }]];
        [self presentViewController:alert animated:YES completion:nil];

//         [ProgressHUD showError:@"验证失败！"];
    }
}

- (void)toTabBar
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Congratulations",nil) message:NSLocalizedString(@"Verification is successful, the gesture password has been cleared!",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Got it",nil)style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self dismissViewControllerAnimated:NO completion:^{
            ;
        }];

    }]];
    [self presentViewController:alert animated:YES completion:nil];

    
    
//    
//    FABNavigationController* controller_f = (FABNavigationController *)self;
//
//    [controller_f popToRootViewControllerAnimated:NO];
//    [FABAppDelegate gotoMainViewController];
//    FABAppDelegate *appDelegate = (FABAppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate skipToTabBar];
    
}


-(void)saveEntity{
    
    if (_myEntity.NumberOneAnswer.length == 0 || _myEntity.NumberTwoAnswer.length == 0 ||_myEntity.NumberThreeAnswer.length == 0) {
        [ProgressHUD showError:NSLocalizedString(@"The answer can not be empty",nil)];
    }else{
    //NSUserDefaults 答案
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    //不能直接存取NSObject，需要先归档转成NSData
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:_myEntity];
    [myDefault setObject:data forKey:@"securityQuestion"];
    [myDefault synchronize];
    [ProgressHUD showSuccess:NSLocalizedString(@"Saved successfully",nil)];
    [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)upDateGestureEntity{
    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:self.gestureEntity];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:data forKey:@"gestureEntity"];
    [myDefault synchronize];
}

-(void)getGestureEntity{
    NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"gestureEntity"];
    //在这里解档
    if(myData){
        self.gestureEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
}


@end
