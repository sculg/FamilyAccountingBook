//
//  FABGestureView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureView.h"
#import "GesturePasswordConstants.h"

@interface FABGestureView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) KKGestureLockView *gestureView;
@end


@implementation FABGestureView
- (instancetype)initWithFrame:(CGRect)frame GestureDelegate:(id<KKGestureLockViewDelegate>)touchDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        
        self.gestureView.delegate = touchDelegate;
    }
    return self;
}

- (void)commonInit
{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    CGFloat offset = 0;
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    
    //标题
    CGRect titleLabelFrame = CGRectMake(0, offset, viewWidth, (20.0f));
    self.titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel ss_setText:nil
                           Font:kFontSize(18)
                      TextColor:kGestureTitleTextColor
                BackgroundColor:[UIColor clearColor]];
    
    [self addSubview:self.titleLabel];
    
    
    //状态
    offset += CGRectGetHeight(titleLabelFrame) + (10.0f);
    CGRect stateLabelFrame = CGRectMake(0, offset, viewWidth, (20.0f));
    
    self.stateLabel = [[UILabel alloc] initWithFrame:stateLabelFrame];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [self.stateLabel ss_setText:nil
                           Font:kFontSize(16)
                      TextColor:kGestureTitleTextColor
                BackgroundColor:[UIColor clearColor]];
    
    
    [self addSubview:self.stateLabel];
    
    
    offset += CGRectGetHeight(stateLabelFrame) + (10.0f);
    float padding = (30.0f);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    if (IS_IPAD) {
        CGRect gestureViewFrame = CGRectMake(kScreenWidth * 0.2, offset + kScreenWidth * 0.2, kScreenWidth * 0.6, kScreenWidth * 0.6);
        self.gestureView = [[KKGestureLockView alloc] initWithFrame:gestureViewFrame];
    }else{
    CGRect gestureViewFrame = CGRectMake(0, offset, kScreenWidth, kScreenWidth);
        self.gestureView = [[KKGestureLockView alloc] initWithFrame:gestureViewFrame];
    }
    
    
    if (IS_IPAD) {
    self.gestureView.buttonSize = CGSizeMake((kScreenWidth * 0.6-4*padding)/3, (kScreenWidth * 0.6-4*padding)/3);
    }else{
        self.gestureView.buttonSize = CGSizeMake((kScreenWidth-4*padding)/3, (kScreenWidth-4*padding)/3);
    }
    [self addSubview:self.gestureView];
    
    self.gestureView.contentInsets = contentInsets;

    self.gestureView.backgroundColor = [UIColor clearColor];
}


- (void)setStateWithText:(NSString *)stateText Color:(UIColor *)color
{
    self.stateLabel.text = stateText;
    self.stateLabel.textColor = color;
}



@end
