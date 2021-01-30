//
//  FABGestureAuthView.m
//  FamilyAccountingBook
//
//  Created by lg on 2017/7/7.
//  Copyright © 2017年 com.familyaccountingbook. All rights reserved.
//

#import "FABGestureAuthView.h"
#import "GesturePasswordConstants.h"

//#import "XNLGesturePasswordConstants.h"


@interface FABGestureAuthView()

//top手势密码
@property (nonatomic, strong) KKGestureLockView *topGestureView;

//状态 + 手势密码
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) KKGestureLockView *bodyGestureView;

@end

@implementation FABGestureAuthView
- (instancetype)initWithFrame:(CGRect)frame GestureDelegate:(id<KKGestureLockViewDelegate>)touchDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
        
        self.bodyGestureView.delegate = touchDelegate;
    }
    return self;
}


- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat offset = 0;
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    
    
    //topNode的宽度
    //node之间的间距
//    CGFloat topNodeWidth = scaleX(10.0f);
//    CGFloat topNodeSpace = scaleX(5.0f);
    
    CGFloat topNodeWidth = 10.0;
    CGFloat topNodeSpace = 5.0;
    
    CGFloat topViewSize = 3*topNodeWidth + 2*topNodeSpace;
    CGRect topGestureViewFrame = CGRectMake((viewWidth - topViewSize)/2, offset, topViewSize, topViewSize);
    
    
    self.topGestureView = [[KKGestureLockView alloc] initWithFrame:topGestureViewFrame];
    self.topGestureView.userInteractionEnabled = NO;
    self.topGestureView.contentInsets = UIEdgeInsetsMake(0,0,0,0);
    self.topGestureView.buttonSize = CGSizeMake(topNodeWidth, topNodeWidth);
    self.topGestureView.lineWidth = 2;
    self.topGestureView.isShowInner = NO;
    [self addSubview:self.topGestureView];
    
    
    offset += CGRectGetHeight(topGestureViewFrame) + (10.0f);
    CGRect stateLabelFrame = CGRectMake(0, offset, viewWidth, (20.0f));
    
    self.stateLabel = [[UILabel alloc] initWithFrame:stateLabelFrame];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [self.stateLabel ss_setText:nil
                           Font:kFontSize(16)
                      TextColor:kGestureTitleTextColor
                BackgroundColor:nil];
    
    [self addSubview:self.stateLabel];
    
    
    offset +=  CGRectGetHeight(stateLabelFrame) + (10.0f);
    float padding = (30.0f);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    
//    self.bodyGestureView = [[KKGestureLockView alloc] initWithFrame:CGRectMake(0, offset, kScreenWidth, kScreenWidth)];
    if (IS_IPAD) {
        self.bodyGestureView = [[KKGestureLockView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.2, offset +kScreenWidth * 0.2, kScreenWidth * 0.6, kScreenWidth * 0.6)];
        self.bodyGestureView.buttonSize = CGSizeMake((kScreenWidth * 0.6-4*padding)/3, (kScreenWidth * 0.6-4*padding)/3);
    }else{
        self.bodyGestureView = [[KKGestureLockView alloc] initWithFrame:CGRectMake(0, offset, kScreenWidth, kScreenWidth)];
    self.bodyGestureView.buttonSize    = CGSizeMake((kScreenWidth - 4*padding)/3, (kScreenWidth- 4*padding)/3);
    }
    self.bodyGestureView.contentInsets = contentInsets;

    [self addSubview:self.bodyGestureView];
    
}



- (void)setStateWithText:(NSString *)stateText Color:(UIColor *)color
{
    self.stateLabel.text = stateText;
    self.stateLabel.textColor = color;
}


@end
