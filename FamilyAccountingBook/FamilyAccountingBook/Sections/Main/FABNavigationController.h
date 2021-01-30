//
//  FABNavigationController.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/6/2.
//  Copyright © 2017年 FamilyAccountingBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FABNavigationController : UINavigationController

@property (nonatomic, assign) BOOL canDragBack;

@property (nonatomic, strong, readonly) UIView *horizontalLine;


@end
