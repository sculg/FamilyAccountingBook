//
//  FABCalendarView.h
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daysquare.h"

typedef void(^FABCalendarViewBlock)(NSDate *selectDate);

@interface FABCalendarView : UIView

@property(nonatomic, copy) FABCalendarViewBlock calendarViewBlock;

@property (nonatomic, strong) DAYCalendarView *calendarView;

@property (nonatomic, strong) UIView *bgView;

+ (instancetype)initCalendarViewWithSelectedDate:(NSDate *)curSelectedDate
                                  selectedResult:(FABCalendarViewBlock)selectedResult;
@end
