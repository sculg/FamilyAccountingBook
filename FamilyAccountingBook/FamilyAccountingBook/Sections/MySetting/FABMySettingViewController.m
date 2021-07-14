//
//  FABMySettingViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/22.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABMySettingViewController.h"
#import "FABTitleValueTableViewCell.h"
#import "FABWebViewController.h"
#import "FABCommonSettingViewController.h"
#import "FABRecordManageViewController.h"
#import "FABAllTreasureViewController.h"
#import "FABPassWordViewController.h"
#import <StoreKit/StoreKit.h>
#import "FABAccountingRecentRecordEntity.h"
#import "FABRouter.h"

static NSString *MySettingViewID = @"MySettingView";

@interface FABMySettingViewController ()<SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger rateCount;

@end

@implementation FABMySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Me",nil);
    [self setUpCutomView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [JANALYTICSService startLogPageView:@"我的设置"];
    [MobClick beginLogPageView:@"我的设置"];

    [self setData];
    [self.tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"我的设置"];
    [MobClick endLogPageView:@"我的设置"];

}

- (void)setUpCutomView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [[UITableViewHeaderFooterView appearance] setTintColor:kTCellLineTopOrBottomColor];

}

- (void)setData{
    self.imageArr = @[@"mysetting_item_cash.png",@"mysetting_item_safe.png",@"mysetting_item_data.png",@"mysetting_item_clean.png",@"mysetting_item_help.png",@"mysetting_item_about.png",@"mysetting_item_score.png",@"mysetting_item_share.png"];
    self.titleArr = @[NSLocalizedString(@"Total Wealth",nil),NSLocalizedString(@"Security Settings",nil),NSLocalizedString(@"Data Management",nil),NSLocalizedString(@"General Settings",nil),NSLocalizedString(@"Help Center",nil),NSLocalizedString(@"About Us",nil),NSLocalizedString(@"Rate Me",nil),NSLocalizedString(@"Share",nil)];
    LKDBHelper* globalHelper = [FABAccountingRecentRecordEntity getUsingLKDBHelper];
    NSArray *myRecordArray = [globalHelper search:[FABAccountingRecentRecordEntity class] where:nil orderBy:@"recordTime desc" offset:0 count:10000];
    self.rateCount = [myRecordArray count];
    
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *rate = [myDefault objectForKey:@"rate number"];
    [myDefault synchronize];
    if (self.rateCount == 600 || self.rateCount == 20 || self.rateCount == 50 || self.rateCount == 100 || self.rateCount == 200 || self.rateCount == 400) {
        if ([rate intValue] <= 0) {
            [self showAlertView];
        }
    }else{
        [myDefault setObject:@(0) forKey:@"rate number"];
    }
}


#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FABTitleValueTableViewCell *cell = [FABTitleValueTableViewCell cellForTableView:tableView];
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:16];
   
    if (indexPath.section == 0) {
        [cell configCellWithTitle:_titleArr[indexPath.row] image:_imageArr[indexPath.row]];
    }else if (indexPath.section == 1){
        [cell configCellWithTitle:_titleArr[indexPath.row + 1] image:_imageArr[indexPath.row + 1]];
    }else{
        [cell configCellWithTitle:_titleArr[indexPath.row + 5] image:_imageArr[indexPath.row + 5]];
    }
    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FABTableViewSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MySettingViewID];
    return sectionView;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self toAllTreasure];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self toPassWord];
                    break;
                case 1:
                    [self toRecordManage];
                    break;
                case 2:
                    [self toCommonSetting];
                    break;
                case 3:
                    [self toHelp];
                    break;
                default:
                    break;
            }
             break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self toAboutUs];
                    break;
                case 1:
                    [self toScore];
                    break;
                case 2:
                    [self toShare];
                    break;
                default:
                    break;
            }
             break;
        default:
            break;
    }
}

- (void)toHelp
{
    NSString *htmlStr = @"";
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([currentLanguage isEqualToString:@"zh-Hans-CN"]||[currentLanguage isEqualToString:@"zh-Hans"]){
        htmlStr = @"fab_help";
    }else if([currentLanguage isEqualToString:@"zh-Hant-CN"]||[currentLanguage isEqualToString:@"zh-Hant"]){
        htmlStr = @"fab_help_hant";
    }else{
        htmlStr = @"fab_help_en";
    }
    
    FABWebViewController *webViewController = [[FABWebViewController alloc] init];
    webViewController.htmlStr = htmlStr;
    webViewController.title = NSLocalizedString(@"Help Center",nil);
    [self pushNormalViewController:webViewController];
    
}

- (void)toAboutUs
{
    NSString *htmlStr = @"";
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if([currentLanguage isEqualToString:@"zh-Hans-CN"]||[currentLanguage isEqualToString:@"zh-Hans"]){
        htmlStr = @"fab_aboutus";
    }else if([currentLanguage isEqualToString:@"zh-Hant-CN"]||[currentLanguage isEqualToString:@"zh-Hant"]){
        htmlStr = @"fab_aboutus_hant";
    }else{
        htmlStr = @"fab_aboutus_en";
    }
    
    
    FABWebViewController *webViewController = [[FABWebViewController alloc] init];
    webViewController.htmlStr = htmlStr;
    webViewController.title = NSLocalizedString(@"About Us",nil);
    [self pushNormalViewController:webViewController];
    
}

//
//- (void)toAllTreasure
//{
//    FABAllTreasureViewController *allTreasure = [[FABAllTreasureViewController alloc] init];
//    [self pushNormalViewController:allTreasure];
//}


- (void)toAllTreasure {
    NSDictionary *params = @{@"navigation":self.navigationController};
    [FABRouter openURL:@"FAB://Setting/AllTreasureVC" withUserInfo:params completion:nil];
}


- (void)toCommonSetting
{
    FABCommonSettingViewController *commonSetting = [[FABCommonSettingViewController alloc] init];
    [self pushNormalViewController:commonSetting];
}


- (void)toRecordManage
{
    FABRecordManageViewController *commonSetting = [[FABRecordManageViewController alloc] init];
    [self pushNormalViewController:commonSetting];
}

-(void)toPassWord{
    FABPassWordViewController *passWord = [[FABPassWordViewController alloc] init];
    [self pushNormalViewController:passWord];
}

- (void)openAppWithIdentifier:(NSString *)appId {

    [JANALYTICSService startLogPageView:@"App Store评分"];
    [MobClick beginLogPageView:@"App Store评分"];

    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [JANALYTICSService stopLogPageView:@"App Store评分"];
            [MobClick endLogPageView:@"App Store评分"];
            [self presentViewController:storeProductVC animated:YES completion:^{
                [self.tableView reloadData];
            }];
        }
    }];
    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)storeProductVC {
    [storeProductVC dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}


-(void)toScore{
    [self chooseScore];
    [self openAppWithIdentifier:@"1258034138"];
}
- (void)toShare{
    
    [MobClick event:@"chooseShare"];
    
    JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
    event.eventID = @"chooseShare";
    [JANALYTICSService eventRecord:event];
    
    UIImage *shareImg = [UIImage imageNamed:@"caiguanjia_share.png"];
    NSString *shareTitle = @"记账神器：财管家";
    NSURL *shareURL = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%B4%A2%E7%AE%A1%E5%AE%B6/id1258034138?mt=8"];
    if (shareImg != nil && shareURL != nil) {
        NSArray *activityItems = @[shareImg,shareURL,shareTitle]; // 声明分享样式
        UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        //if iPhone
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentViewController:activeViewController animated:YES completion:^{
                [self.tableView reloadData];
            }];
        }
        //if iPad
        else {
            // Change Rect to position Popover
            UIBarButtonItem *shareBarButtonItem = self.navigationItem.leftBarButtonItem;
            UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activeViewController];
            [popup presentPopoverFromBarButtonItem:shareBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

- (void)chooseScore{
    [MobClick event:@"chooseRate"];

    JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
    event.eventID = @"chooseScore";
    [JANALYTICSService eventRecord:event];
}

- (void)chooseNoScore{
    JANALYTICSCountEvent * event = [[JANALYTICSCountEvent alloc] init];
    event.eventID = @"chooseNotScore";
    [JANALYTICSService eventRecord:event];
}

-(void)showAlertView{
    
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:@(self.rateCount) forKey:@"rate number"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Rate Me",nil) message:NSLocalizedString(@"rate desc",nil) preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Remind me later",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self  chooseNoScore];
        [MobClick event:@"chooseNotRate"];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Set immediately",nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        [self  chooseScore];
        [MobClick event:@"chooseRate"];

    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
