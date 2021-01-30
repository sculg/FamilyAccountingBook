//
//  KKGestureLineView.m
//  XNOnline
//
//  Created by xia on 15/11/26.
//  Copyright © 2015年 xiaoniu88. All rights reserved.
//

#import "KKGestureLineView.h"
#import "KKGestureLockItemView.h"

@implementation KKGestureLineView

#pragma mark UIView Overrides
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.selectedButtons = [NSMutableArray array];
        self.trackedLocationInContentView = CGPointMake(kTrackedLocationInvalidInContentView, kTrackedLocationInvalidInContentView);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if ([self.selectedButtons count] > 0)
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        UIButton *firstButton = [self.selectedButtons objectAtIndex:0];
        [bezierPath moveToPoint:[self convertPoint:firstButton.center fromView:self.superview]];
        
        for (int i = 1; i < [self.selectedButtons count]; i++)
        {
            UIButton *button = [self.selectedButtons objectAtIndex:i];
            [bezierPath addLineToPoint:[self convertPoint:button.center fromView:self.superview]];
        }
        
        if (self.trackedLocationInContentView.x != kTrackedLocationInvalidInContentView &&
            self.trackedLocationInContentView.y != kTrackedLocationInvalidInContentView)
        {
            [bezierPath addLineToPoint:[self convertPoint:self.trackedLocationInContentView fromView:self.superview]];
        }
        [bezierPath setLineWidth:self.lineWidth];
        [bezierPath setLineJoinStyle:kCGLineJoinRound];
        
        [self.lineColor setStroke];
        if(_isErrorState)
        {
            [KKGesture_Error_Line_Color setStroke];
        }
        
        [bezierPath stroke];
    }
}
@end
