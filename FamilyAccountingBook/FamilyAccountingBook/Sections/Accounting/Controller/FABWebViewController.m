//
//  FABWebViewController.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/27.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABWebViewController.h"

@interface FABWebViewController ()

@end

@implementation FABWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:webView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:_htmlStr ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}

- (void)viewDidAppear:(BOOL)animated {
    [JANALYTICSService startLogPageView:@"介绍页"];
    [MobClick beginLogPageView:@"介绍页"];

}

- (void)viewDidDisappear:(BOOL)animated {
    [JANALYTICSService stopLogPageView:@"介绍页"];
    [MobClick endLogPageView:@"介绍页"];

}

@end
