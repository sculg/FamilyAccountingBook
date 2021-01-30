//
//  FABCalendarView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/10/12.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABCalendarView.h"
#import "FABAppUtils.h"

@interface FABCalendarView ()<UIGestureRecognizerDelegate>

@end

@implementation FABCalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
        [self addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        
        [self addSubview:self.calendarView];
        [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
        
        self.backgroundColor = [UIColor colorWithRed:245/255 green:245/255 blue:245/255 alpha:0.1];
        [[FABAppUtils currentVC].view addSubview:self];
    }
    return self;
}


- (void)calendarViewDidChange:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
    if (self.calendarViewBlock) {
        self.calendarViewBlock(self.calendarView.selectedDate);
    }
    if (self.calendarView.selectedDate != nil) {
        [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.5];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.calendarView]) {
        return NO;
    }
    return YES;
}


-(void)removeSelf{
    self.calendarView = nil;
    [self removeFromSuperview];
}

- (DAYCalendarView *)calendarView{
    if (!_calendarView) {
        _calendarView = [[DAYCalendarView alloc] init];
        _calendarView.boldPrimaryComponentText = YES;
        _calendarView.selectedIndicatorColor = kMainCommonColor;
        _calendarView.weekdayHeaderTextColor = kMainCommonOppositionColor;
        _calendarView.weekdayHeaderWeekendTextColor = kMainCommonColor;
    }
    return _calendarView;
}

+ (instancetype)initCalendarViewWithSelectedDate:(NSDate *)curSelectedDate
                                  selectedResult:(FABCalendarViewBlock)selectedResult{
    FABCalendarView *calendarView = [[FABCalendarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (curSelectedDate) {
//        calendarView.calendarView.selectedDate = curSelectedDate;
    }
    calendarView.calendarView.backgroundColor = [UIColor whiteColor];
    if (IS_IPAD){
        [calendarView.calendarView setFrame:CGRectMake(kScreenWidth - 270, 0, 260,280)];
    }else{
        [calendarView.calendarView setFrame:CGRectMake(40, 0, kScreenWidth - 80,280)];
    }
    calendarView.calendarView.layer.masksToBounds = YES;
    calendarView.calendarView.layer.cornerRadius = 10;
    calendarView.calendarViewBlock = selectedResult;
    return calendarView;
}

@end
