//
//  FABAccountingExpenditureViewController.m
//  FinancialHousekeeper
//
//  Created by lg on 2017/6/6.
//  Copyright © 2017年 financialhousekeeper. All rights reserved.
//

#import "FABAccountingExpenditureViewController.h"

#import "FABTitleValueTableViewCell.h"
#import "FABTitleTextFieldTableViewCell.h"
#import "FABAccountingButtonCell.h"

#import "FABAccountingRecentRecordEntity.h"
#import "FABAccountingSummaryEntity.h"
#import "JANALYTICSService.h"
#import "XNOKeyboardExtensionView.h"

#define kSuccessMessage    !self.isToChangeData ? NSLocalizedString(@"Saved successfully",nil) : NSLocalizedString(@"Successfully modified",nil)
#define kErrorMessage      !self.isToChangeData ? NSLocalizedString(@"Save failed",nil) : NSLocalizedString(@"Modify failed",nil)


@interface FABAccountingExpenditureViewController ()<UITableViewDataSource, UITableViewDelegate,FABTableViewCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) NSString *payTypeStr;
@property (nonatomic, strong) NSString *ependitureTypeStr;
@property (nonatomic, strong) NSString *objectTypeStr;

@property (nonatomic, strong) NSArray *payTypeArray;
@property (nonatomic, strong) NSArray *ependitureTypeArray;
@property (nonatomic, strong) NSArray *objectTypeArray;
// 修改数据时原始金额
@property (nonatomic, assign) double recordMoney;

// 修改数据时原始月份
@property (nonatomic, copy) NSString *originMonthId;

@property (nonatomic, assign) BOOL isBound;

@end

@implementation FABAccountingExpenditureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = kWhiteColor;
    
    [self setData];
    [self setUpCutomView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.tableView.backgroundColor = kTCellLineTopOrBottomColor;
}

-(void)setData{
    
    _isBound = NO;
    
    if (!_isToChangeData) {
        //首先NSUserDefaults中查找有无模板，如有模板，直接模板中取
        NSData * myData = [[NSUserDefaults standardUserDefaults]objectForKey:@"ependitureTemplate"];
        //在这里解档
        if(myData){
            self.myEntity = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
        }else{
            //JSON文件的路径
            NSString *path = [[NSBundle mainBundle] pathForResource:@"ependitureTemplate" ofType:@"json"];
            //加载JSON文件
            NSData *data = [NSData dataWithContentsOfFile:path];
            //将JSON数据转为NSArray或NSDictionary
            if (data) {
                NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                self.myEntity = [FABAccountingRecentRecordEntity parserEntityWithDictionary:dictArray[0]];
            }
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
        self.myEntity.recordTime = nowtimeStr;
        //以当前时间戳秒数作为recordId
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *dateStr=[formatter stringFromDate:[NSDate date]];
        self.myEntity.recordId = dateStr;
    }
    _recordMoney = [self.myEntity.recordMoney doubleValue];
    _originMonthId = self.myEntity.monthId;
    
    
    self.myEntity.incomeClassificationType = 100;
    self.payTypeArray = @[NSLocalizedString(@"Cash Pay",nil),NSLocalizedString(@"Union Pay",nil),NSLocalizedString(@"Wechat Pay",nil),NSLocalizedString(@"Ali Pay",nil)];
    self.ependitureTypeArray =self.expenditureTitleItems;
    self.objectTypeArray =@[NSLocalizedString(@"Family",nil),NSLocalizedString(@"Me",nil),NSLocalizedString(@"Spouse",nil),NSLocalizedString(@"Parents",nil),NSLocalizedString(@"Children",nil),NSLocalizedString(@"Other people",nil)];
}


-(NSInteger)ependitureClassification:(NSString *)str{
    if ([str isEqualToString:NSLocalizedString(@"Clothes",nil)
]) {
        return 0;
    }else if ([str isEqualToString:NSLocalizedString(@"Foods",nil)]) {
        return 1;
    }else if ([str isEqualToString:NSLocalizedString(@"Rent",nil)]) {
        return 2;
    }else if ([str isEqualToString:NSLocalizedString(@"Traffic",nil)]) {
        return 3;
    }else if ([str isEqualToString:NSLocalizedString(@"Entertainment",nil)]) {
        return 4;
    }else if ([str isEqualToString:NSLocalizedString(@"Other expenses",nil)]) {
        return 5;
    }else if ([str isEqualToString:NSLocalizedString(@"Medical Care",nil)]) {
        return 6;
    }else if ([str isEqualToString:NSLocalizedString(@"Necessary",nil)]) {
        return 7;
    }else if ([str isEqualToString:NSLocalizedString(@"Cosmetology",nil)]) {
        return 8;
    }else if ([str isEqualToString:NSLocalizedString(@"Social",nil)]) {
        return 9;
    }else if ([str isEqualToString:NSLocalizedString(@"Education",nil)]) {
        return 10;
    }else if ([str isEqualToString:NSLocalizedString(@"Cash gift",nil)]) {
        return 11;
    }else{
        return 12;
    }
}



#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isToChangeData) {
        return 9;
    }else{
        return 8;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 7) {
        return 90;
    }else if (indexPath.row == 8){
        return 60;
    }else{
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
        NSString *buttonTitle ;
//        if (_isToSetTemplate) {
//            buttonTitle = @"保存模板";
//        }else if (_isToChangeData){
//            buttonTitle = NSLocalizedString(@"Save",nil)
//;
//        }else{
            buttonTitle = NSLocalizedString(@"Save",nil);
//        }
        [cell configButtonWithTitle:buttonTitle topOffset:40];
        
        if (!_isBound) {
            RAC(cell.button, enabled) = [RACSignal combineLatest:@[RACObserve(self, myEntity.recordProduct),
                                                                   RACObserve(self, myEntity.recordMoney),
                                                                   RACObserve(self, myEntity.recordTime),
                                                                   RACObserve(self, myEntity.recordAddress)]
                                                          reduce:^id(NSString *recordProduct,
                                                                     NSNumber *recordMoney,
                                                                     NSString *recordTime,
                                                                     NSString *recordAddress){
                                                              
                                                              BOOL enabled = (recordProduct.length > 0 && [recordMoney doubleValue] > 0 && recordAddress.length > 0);
                                                              
                                                              return @(enabled);
                                                              
                                                          }];
            _isBound = YES;
        }
        
        cell.btnPressedBlock = ^(){
            if (_myEntity.recordProduct.length == 0 || _myEntity.recordAddress.length == 0) {
                [ProgressHUD showError:@"记录信息不完整，保存失败！"];
            }else{
                if (_isToSetTemplate) {
                    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
                    //不能直接存取NSObject，需要先归档转成NSData
                    NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:_myEntity];
                    [myDefault setObject:data forKey:@"ependitureTemplate"];
                    [myDefault synchronize];
                    [ProgressHUD showSuccess:NSLocalizedString(@"Saved successfully",nil)];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self saveData];
                }
            }
        };
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 8) {
        FABAccountingButtonCell *cell = [FABAccountingButtonCell cellForTableView:tableView];
        [cell configButtonWithTitle:NSLocalizedString(@"Delete",nil)
                         titleColor:kMainCommonColor
                            bgColor:kWhiteColor
                          topOffset:10];
        cell.btnPressedBlock = ^(){
            [self deleteData];
        };
        
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:20];
        
        
        FABTitleTextFieldTableViewCell *textFieldCell = [FABTitleTextFieldTableViewCell cellForTableView:tableView];
        textFieldCell.selectionStyle  = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 0) {
            [textFieldCell configCellWithTitle:NSLocalizedString(@"Money",nil) textFieldValue:self.myEntity.recordMoneyDesc];
            
            textFieldCell.textValueChangedBlock = ^(NSString *value){
                
                weakSelf.myEntity.recordMoney = @([value doubleValue]);

            };
            
            textFieldCell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            textFieldCell.valueTextField.delegate = self;
            textFieldCell.valueTextField.inputAccessoryView = [XNOKeyboardExtensionView createView];

            return textFieldCell;
        }else if (indexPath.row == 1){
            
            [cell configCellWithTitle:NSLocalizedString(@"Payment Method",nil) detail:self.myEntity.payTypeDesc];
            return cell;
        }else if (indexPath.row == 2){
            
            [textFieldCell configCellWithTitle:NSLocalizedString(@"Expenditure Detail",nil) textFieldValue:self.myEntity.recordProduct];
            textFieldCell.textValueChangedBlock = ^(NSString *value){
                weakSelf.myEntity.recordProduct = value;
            };
            textFieldCell.valueTextField.keyboardType = UIKeyboardTypeDefault;
            return textFieldCell;
            
        }else if (indexPath.row == 3){
            
            [textFieldCell configCellWithTitle:NSLocalizedString(@"Recorded Address",nil)
 textFieldValue:self.myEntity.recordAddress];

            textFieldCell.textValueChangedBlock = ^(NSString *value){
                weakSelf.myEntity.recordAddress = value;
                NSLog(@"此时的值是：%@",self.myEntity.recordAddress);
            };
            textFieldCell.valueTextField.keyboardType = UIKeyboardTypeDefault;
            return textFieldCell;
        }else if(indexPath.row == 4){
            
            [cell configCellWithTitle:NSLocalizedString(@"Expenditure Date",nil)
 detail:self.myEntity.recordTime];
            self.myEntity.monthId = [self.myEntity.recordTime substringWithRange:NSMakeRange(0,7)];
            
            return cell;
        }else if(indexPath.row == 5){
            
            [cell configCellWithTitle:NSLocalizedString(@"Expenditure Target",nil)
 detail:self.myEntity.expenditureObjectTypeeDesc];
            return cell;
        }else{
            
            [cell configCellWithTitle:NSLocalizedString(@"Payment Type",nil) detail:self.myEntity.ependitureClassificationTypeDesc];
            return cell;
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 屏蔽黏贴
    if (string.length > 1) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length >= 12) {
        return NO;
    }
    else {
        return [self doCheckInputAmount:textField Range:range replacementString:string];
    }
}



#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;

    if (indexPath.row == 1) {
        NSNumber *num = [NSNumber numberWithInteger:(NSUInteger)self.myEntity.payType];
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_payTypeArray] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            NSInteger index = [[selectedIndex firstObject] integerValue];
            weakSelf.myEntity.payType = [weakSelf.myEntity accountingPayTypeFromIndex:index];
            [weakSelf.tableView reloadData];
            
        } cancelBlock:nil origin:self.view];
    }else if (indexPath.row == 4) {
        if(_isToSetTemplate){
            [self showAlertView];
        }else{
            NSDate *curDate = [NSDate dateFromString:self.myEntity.recordTime withFormat:@"yyyy-MM-dd"];
            if (!curDate) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd"];
                NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
                curDate = [NSDate dateFromString:nowtimeStr withFormat:@"yyyy-MM-dd"];
            }
            @weakify(self);
            ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {
                @strongify(self);
                NSString *shooseDate = [selectedDate string_yyyy_MM_dd];
                self.myEntity.recordTime = shooseDate;
                [self.tableView reloadData];
                
            } cancelBlock:^(ActionSheetDatePicker *picker) {
            } origin:self.view];
            picker.minimumDate = [[NSDate date] offsetYear:-120];
            picker.maximumDate = [NSDate date];
            [picker showActionSheetPicker];
            
        }
        
    }else if (indexPath.row == 5) {
        NSNumber *num = [NSNumber numberWithInteger:(NSUInteger)self.myEntity.expenditureObjectType];
        @weakify(self);
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_objectTypeArray] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            @strongify(self);

            NSInteger index = [[selectedIndex firstObject] integerValue];
            self.myEntity.expenditureObjectType = [self.myEntity expenditureObjectTypeFromIndex:index];
            [self.tableView reloadData];
            
        } cancelBlock:nil origin:self.view];
    }else if (indexPath.row == 6) {
        
        NSString *ependitureStr = self.myEntity.ependitureClassificationTypeDesc;
        BOOL isExist = [_ependitureTypeArray containsObject:ependitureStr];
        NSInteger index;
        if (isExist) {
            index = [_ependitureTypeArray indexOfObject:ependitureStr];
        }else{
            index = 0;
        }
        NSNumber *num = [NSNumber numberWithInteger:index];
        [ActionSheetStringPicker showPickerWithTitle:nil rows:@[_ependitureTypeArray] initialSelection:@[num] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
            
            NSString *selectedStr = [selectedValue firstObject];
            weakSelf.myEntity.ependitureClassificationType = [weakSelf.myEntity expenditureClassificationTypeFromIndex:[weakSelf ependitureClassification:selectedStr]];
            [weakSelf.tableView reloadData];
            
        } cancelBlock:nil origin:self.view];
    }
}


/*  保存记录  */
-(void)saveData{
    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    FABAccountingSummaryEntity *myMonthEntity = [[FABAccountingSummaryEntity alloc] init];
    
    [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
    [self dataStatistics];
    //修改记录
    if (_isToChangeData) {
        [self UMClickWithID:@"update_ExpendRecord"];

        //如果修改前后的月份相同
        if (_originMonthId == self.myEntity.monthId) {
            LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
            NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
            myMonthEntity = monthArray[0];
            double NewExpenditure = [myMonthEntity.expenditure doubleValue] + [self.myEntity.recordMoney doubleValue] - _recordMoney;
            double NewCashSurplus = [myMonthEntity.cashSurplus doubleValue] - ([self.myEntity.recordMoney doubleValue] - _recordMoney);
            double NewBudgetBalance = [myMonthEntity.budgetBalance doubleValue] - ([self.myEntity.recordMoney doubleValue] - _recordMoney);
            myMonthEntity.expenditure = @(NewExpenditure);
            myMonthEntity.cashSurplus = @(NewCashSurplus);
            myMonthEntity.budgetBalance = @(NewBudgetBalance);
            [monthHelper updateToDB:myMonthEntity where:@{@"accountingId":self.myEntity.monthId}];
        }else{
            //修改前后的月份不同
            LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
            NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
            //先判断修改后月份记录是否存在,若不存在，添加一条月记录
            if ([monthArray count] == 0) {
                [self createMonthRecordWith:self.myEntity.monthId];
                monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
            }
            //拿到需要更新的月记录
            myMonthEntity = monthArray[0];
            double NewExpenditure = [myMonthEntity.expenditure doubleValue] + [self.myEntity.recordMoney doubleValue];
            double NewCashSurplus = [myMonthEntity.cashSurplus doubleValue] - [self.myEntity.recordMoney doubleValue];
            double NewBudgetBalance = [myMonthEntity.budgetBalance doubleValue] - [self.myEntity.recordMoney doubleValue];
            myMonthEntity.expenditure = @(NewExpenditure);
            myMonthEntity.cashSurplus = @(NewCashSurplus);
            myMonthEntity.budgetBalance = @(NewBudgetBalance);
            //将本条记录导致的月数据变化，更新到刚才创建的月记录
            [monthHelper updateToDB:myMonthEntity where:@{@"accountingId":self.myEntity.monthId}];
            
            
            //处理原记录
            FABAccountingSummaryEntity *myMonthEntity1 = [[FABAccountingSummaryEntity alloc] init];
            NSArray *monthArray1 = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":_originMonthId} orderBy:@"accountingId desc" offset:0 count:1000];
            myMonthEntity1 = monthArray1[0];
            
            double NewExpenditure1 = [myMonthEntity1.expenditure doubleValue] - _recordMoney;
            double NewCashSurplus1 = [myMonthEntity1.cashSurplus doubleValue] + _recordMoney;
            double NewBudgetBalance1 = [myMonthEntity1.budgetBalance doubleValue] + _recordMoney;
            
            myMonthEntity1.expenditure = @(NewExpenditure1);
            myMonthEntity1.cashSurplus = @(NewCashSurplus1);
            myMonthEntity1.budgetBalance = @(NewBudgetBalance1);
            
            if (NewExpenditure1 ==0 && NewCashSurplus1 == 0 && ![myMonthEntity1.accountingId isEqualToString:[NSDate monthId]]) {
                [monthHelper deleteToDB:myMonthEntity1];
            }else{
                [monthHelper updateToDB:myMonthEntity1 where:@{@"accountingId":_originMonthId}];
            }
        }
        
        [globalHelper updateToDB:self.myEntity  where:@{@"recordId":self.myEntity.recordId} callback: ^(BOOL result){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [ProgressHUD showSuccess:kSuccessMessage];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ProgressHUD showError:kErrorMessage];
                }});
        }];
    }else{
        [self UMClickWithID:@"Add_ExpendRecord"];

        //保存记录
        LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
        
        NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
        if ([monthArray count] == 0) {
            [self createMonthRecordWith:self.myEntity.monthId];
            monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
        }
        myMonthEntity = monthArray[0];
        
        double NewExpenditure = [myMonthEntity.expenditure doubleValue] + [self.myEntity.recordMoney doubleValue];
        double NewCashSurplus = [myMonthEntity.cashSurplus doubleValue] - [self.myEntity.recordMoney doubleValue];
        double NewBudgetBalance = [myMonthEntity.budgetBalance doubleValue] - [self.myEntity.recordMoney doubleValue];
        
        myMonthEntity.expenditure = @(NewExpenditure);
        myMonthEntity.cashSurplus = @(NewCashSurplus);
        myMonthEntity.budgetBalance = @(NewBudgetBalance);
        
        
        [monthHelper updateToDB:myMonthEntity where:@{@"accountingId":self.myEntity.monthId}];
        
        [globalHelper insertToDB:self.myEntity callback: ^(BOOL result){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [ProgressHUD showSuccess:kSuccessMessage];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ProgressHUD showError:kErrorMessage];
                }});
        }];
    }
}

/*  删除记录  */
-(void)deleteData{
    [self UMClickWithID:@"delete_ExpendRecord"];
    
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    [ProgressHUD show:NSLocalizedString(@"Please wait",nil)];
    
    LKDBHelper* monthHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    FABAccountingSummaryEntity *myMonthEntity = [[FABAccountingSummaryEntity alloc] init];
    
    NSArray *monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
    if ([monthArray count] == 0) {
        [self createMonthRecordWith:self.myEntity.monthId];
        monthArray = [monthHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":self.myEntity.monthId} orderBy:@"accountingId desc" offset:0 count:1000];
    }
    myMonthEntity = monthArray[0];
    
    double NewExpenditure = [myMonthEntity.expenditure doubleValue] - _recordMoney;
    double NewCashSurplus = [myMonthEntity.cashSurplus doubleValue] + _recordMoney;
    double NewBudgetBalance = [myMonthEntity.budgetBalance doubleValue] + _recordMoney;
    
    myMonthEntity.expenditure = @(NewExpenditure);
    myMonthEntity.cashSurplus = @(NewCashSurplus);
    myMonthEntity.budgetBalance = @(NewBudgetBalance);
    
    if (NewExpenditure ==0 && NewCashSurplus == 0 && ![myMonthEntity.accountingId isEqualToString:[NSDate monthId]]) {
        [monthHelper deleteToDB:myMonthEntity];
    }else{
        [monthHelper updateToDB:myMonthEntity where:@{@"accountingId":self.myEntity.monthId}];
    }
    [globalHelper deleteToDB:self.myEntity callback: ^(BOOL result){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) {
                [ProgressHUD showSuccess:NSLocalizedString(@"Deleted successfully",nil)];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ProgressHUD showError:NSLocalizedString(@"Delete failed",nil)];
            }});
    }];
}

- (void)dataStatistics{
    JANALYTICSPurchaseEvent * event = [[JANALYTICSPurchaseEvent alloc] init];
    event.success = YES;
    event.price = [self.myEntity.recordMoney floatValue];
    event.goodsName = self.myEntity.recordProduct;
    event.goodsType = self.myEntity.recordAddress;
    event.quantity = 1;
    event.goodsID = @"支出";
    event.currency = JANALYTICSCurrencyCNY;
    event.extra = @{@"时间":self.myEntity.recordId};
    [JANALYTICSService eventRecord:event];
}

-(void)UMClickWithID:(NSString *)eventId{
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [self.myEntity.recordMoney stringValue], @"金额",
                          self.myEntity.payTypeDesc,@"支付方式" ,
                          self.myEntity.recordProduct,@"具体商品" ,
                          self.myEntity.recordAddress, @"地址",
                          self.myEntity.expenditureObjectTypeeDesc, @"支出对象",
                          self.myEntity.recordTime,@"支出时间",
                          self.myEntity.ependitureClassificationTypeDesc,@"支出类型",
                          nil];
    [MobClick event:eventId attributes:dict];
}


-(void)createMonthRecordWith:(NSString *)monthId{
    
    LKDBHelper* summaryEntityHelper = [FABAccountingSummaryEntity getUsingLKDBHelper];
    FABAccountingSummaryEntity *myEntity = [[FABAccountingSummaryEntity alloc] init];
    NSArray *monthArray = [summaryEntityHelper search:[FABAccountingSummaryEntity class] where:@{@"accountingId":monthId} orderBy:@"accountingId desc" offset:0 count:1000];
    if (monthArray.count == 0) {
        myEntity.accountingId = monthId;
        myEntity.incomeBudget = @(20000.0);
        myEntity.income = @(0.0);
        myEntity.expenditure = @(0.0);
        myEntity.expenditureBudget = @(4300.0);
        myEntity.budgetBalance = @([myEntity.expenditureBudget doubleValue]- [myEntity.expenditure doubleValue]);
        myEntity.cashSurplus = @(0.0);
        
        [myEntity saveToDB];
    }
}

-(FABAccountingRecentRecordEntity *)myEntity{
    if (!_myEntity) {
        _myEntity = [[FABAccountingRecentRecordEntity alloc] init];
    }
    return _myEntity;
}

-(void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Kindly Reminder",nil) message:NSLocalizedString(@"No set",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Got it",nil)style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//收入数据标题数组
-(NSArray *)expenditureTitleItems{
    NSArray *mySelectedAdditionalArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"expenditureClassificationSelected"];
    NSMutableArray *myArray = [@[NSLocalizedString(@"Clothes",nil)
,NSLocalizedString(@"Foods",nil),NSLocalizedString(@"Rent",nil),NSLocalizedString(@"Traffic",nil),NSLocalizedString(@"Entertainment",nil),NSLocalizedString(@"Other expenses",nil)] mutableCopy];
    for (int i = 0; i < [mySelectedAdditionalArr count]; i++) {
        NSString *itemStr = mySelectedAdditionalArr[i];
        [myArray insertObject:itemStr atIndex:[myArray count] - 1];
    }
    return myArray;
}
@end
