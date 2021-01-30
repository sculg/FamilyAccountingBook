//
//  KKGestureLockView.m
//  KKGestureLockView
//
//  Created by Luke on 8/5/13.
//  Copyright (c) 2013 geeklu. All rights reserved.
//

#import "KKGestureLockView.h"
#import "KKGestureLineView.h"

const static NSUInteger kNumberOfNodes = 9;
const static NSUInteger kNodesPerRow = 3;
const static CGFloat kNodeDefaultWidth = 60;
const static CGFloat kNodeDefaultHeight = 60;
const static CGFloat kLineDefaultWidth = 10;


@interface KKGestureLockView (){
    struct {
        unsigned int didBeginWithPasscode :1;
        unsigned int didEndWithPasscode : 1;
        unsigned int didCanceled : 1;
    } _delegateFlags;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) KKGestureLineView *gestureLineView;

//Implement nodes with buttons
@property (nonatomic, strong) NSArray *views;

@end

@implementation KKGestureLockView

#pragma mark -
#pragma mark Private Methods

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (KKGestureLockItemView *)_buttonContainsThePoint:(CGPoint)point{
    for (KKGestureLockItemView *button in self.views) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

- (void)_lockViewInitialize{
    self.backgroundColor = [UIColor clearColor];
    
    self.lineColor = KKGesture_Select_Line_Color;
    self.lineWidth = kLineDefaultWidth;
    self.isShowInner = YES;
    
    self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, self.contentInsets)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentView];
    
    //
    self.gestureLineView = [[KKGestureLineView alloc] initWithFrame:self.bounds];
    self.gestureLineView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.gestureLineView];
    
    self.buttonSize = CGSizeMake(kNodeDefaultWidth, kNodeDefaultHeight);
    
    self.numberOfGestureNodes = kNumberOfNodes;
    self.gestureNodesPerRow = kNodesPerRow;
}


#pragma mark -
#pragma mark UIView Overrides
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self _lockViewInitialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self _lockViewInitialize];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _gestureLineView.lineColor = _lineColor?_lineColor:KKGesture_Select_Line_Color;
    _gestureLineView.lineWidth = _lineWidth?_lineWidth:kLineDefaultWidth;
    
    self.contentView.frame = self.bounds;// UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    CGFloat horizontalNodeMargin = (self.contentView.bounds.size.width - self.buttonSize.width * self.gestureNodesPerRow-self.contentInsets.left-self.contentInsets.right)/(self.gestureNodesPerRow - 1);
    NSUInteger numberOfRows = ceilf((self.numberOfGestureNodes * 1.0 / self.gestureNodesPerRow));
    CGFloat verticalNodeMargin = (self.contentView.bounds.size.height - self.buttonSize.height *numberOfRows-self.contentInsets.top-self.self.contentInsets.bottom)/(numberOfRows - 1);
    
    NSInteger init_x = self.contentInsets.left;
    NSInteger init_y = self.contentInsets.top;
    
    for (int i = 0; i < self.numberOfGestureNodes ; i++)
    {
        int row = i / self.gestureNodesPerRow;
        int column = i % self.gestureNodesPerRow;
        if(column==0)
        {
            init_x = self.contentInsets.left;
            if(row!=0)
            {
               init_y += floorf(self.buttonSize.height + verticalNodeMargin); 
            }
        }
        KKGestureLockItemView *button = [self.views objectAtIndex:i];
        button.nodeWith = _gestureLineView.lineWidth + 2;
        button.isShowInner = _isShowInner;
        button.frame = CGRectMake(init_x,init_y, self.buttonSize.width, self.buttonSize.height);
        init_x += floorf(self.buttonSize.width + horizontalNodeMargin);
    }
}

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
////    [_gestureLineView setNeedsDisplay];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint locationInContentView = [touch locationInView:self.contentView];
    KKGestureLockItemView *touchedButton = [self _buttonContainsThePoint:locationInContentView];
    if (touchedButton != nil) {
        [touchedButton setItemViewType:KKGestureLockItemTypeSelect];
        [_gestureLineView.selectedButtons addObject:touchedButton];
        _gestureLineView.trackedLocationInContentView = locationInContentView;
        
        if (_delegateFlags.didBeginWithPasscode) {
            [self.delegate gestureLockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%d",(int)touchedButton.tag]];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint locationInContentView = [touch locationInView:self.contentView];
    if (CGRectContainsPoint(self.contentView.bounds, locationInContentView)) {
        KKGestureLockItemView *touchedButton = [self _buttonContainsThePoint:locationInContentView];
        if (touchedButton != nil && [_gestureLineView.selectedButtons indexOfObject:touchedButton]==NSNotFound) {
            [touchedButton setItemViewType:KKGestureLockItemTypeSelect];
            [_gestureLineView.selectedButtons addObject:touchedButton];
            if ([_gestureLineView.selectedButtons count] == 1) {
                //If the touched button is the first button in the selected buttons,
                //It's the beginning of the passcode creation
                if (_delegateFlags.didBeginWithPasscode) {
                    [self.delegate gestureLockView:self didBeginWithPasscode:[NSString stringWithFormat:@"%d",(int)touchedButton.tag]];
                }
            }
        }
        _gestureLineView.trackedLocationInContentView = locationInContentView;
        [_gestureLineView setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{    
    if ([_gestureLineView.selectedButtons count] > 0) {
        if (_delegateFlags.didEndWithPasscode) {
            NSMutableArray *passcodeArray = [NSMutableArray array];
            for (UIButton *button in _gestureLineView.selectedButtons) {
                [passcodeArray addObject:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            
            [self.delegate gestureLockView:self didEndWithPasscode:[passcodeArray componentsJoinedByString:@","]];
        }
    }
    
//    for (UIButton *button in self.selectedButtons) {
//        button.selected = NO;
//    }
//    [_gestureLineView.selectedButtons removeAllObjects];
//    _gestureLineView.trackedLocationInContentView = CGPointMake(kTrackedLocationInvalidInContentView, kTrackedLocationInvalidInContentView);
//    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_gestureLineView.selectedButtons count] > 0) {
        if (_delegateFlags.didCanceled) {
            NSMutableArray *passcodeArray = [NSMutableArray array];
            for (UIButton *button in _gestureLineView.selectedButtons) {
                [passcodeArray addObject:[NSString stringWithFormat:@"%d",(int)button.tag]];
            }
            
            [self.delegate gestureLockView:self didCanceledWithPasscode:[passcodeArray componentsJoinedByString:@","]];
        }
    }
    
    for (KKGestureLockItemView *button in _gestureLineView.selectedButtons)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    [_gestureLineView.selectedButtons removeAllObjects];
    _gestureLineView.trackedLocationInContentView = CGPointMake(kTrackedLocationInvalidInContentView, kTrackedLocationInvalidInContentView);
    [_gestureLineView setNeedsDisplay];
}

#pragma mark -
- (void)setDelegate:(id<KKGestureLockViewDelegate>)delegate{
    _delegate = delegate;
    
    _delegateFlags.didBeginWithPasscode = [delegate respondsToSelector:@selector(gestureLockView:didBeginWithPasscode:)];
    _delegateFlags.didEndWithPasscode = [delegate respondsToSelector:@selector(gestureLockView:didEndWithPasscode:)];
    //_delegateFlags.didCanceled = [delegate respondsToSelector:@selector(gestureLockViewCanceled:)];
}

- (void)setNumberOfGestureNodes:(NSUInteger)numberOfGestureNodes{
    if (_numberOfGestureNodes != numberOfGestureNodes) {
        _numberOfGestureNodes = numberOfGestureNodes;
        
        if (self.views != nil && [self.views count] > 0) {
            for (UIView *button in self.views) {
                [button removeFromSuperview];
            }
        }
        
        NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:numberOfGestureNodes];
        for (NSUInteger i = 0; i < numberOfGestureNodes; i++) {
            KKGestureLockItemView *button = [[KKGestureLockItemView alloc] initWithFrame:CGRectMake(0, 0, self.buttonSize.width, self.buttonSize.height)];
            button.tag = i;
            button.userInteractionEnabled = NO;
            button.backgroundColor = [UIColor clearColor];
            
            [buttonArray addObject:button];
            [self.contentView addSubview:button];
        }
        self.views = [buttonArray copy];
    }
}

-(void)clearPasscode
{
    for (KKGestureLockItemView *button in self.views)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    _gestureLineView.isErrorState = NO;
    [_gestureLineView.selectedButtons removeAllObjects];
    [_gestureLineView setNeedsDisplay];
}

-(void)showErrorState
{
    for (KKGestureLockItemView *button in self.views)
    {
        if([button getDrawType]==KKGestureLockItemTypeSelect)
        {
            [button setItemViewType:KKGestureLockItemTypeError];
        }
    }
     _gestureLineView.isErrorState = YES;
    [_gestureLineView setNeedsDisplay];
}

- (void)setGestureWithPasscode:(NSString *)passcode
{
    for (KKGestureLockItemView *button in self.views)
    {
        [button setItemViewType:KKGestureLockItemTypeNormal];
    }
    
    _gestureLineView.isErrorState = NO;
    [_gestureLineView.selectedButtons removeAllObjects];
    NSArray *passcodeArray = [passcode componentsSeparatedByString:@","];
    for(NSString *tag in passcodeArray)
    {
        NSInteger viewTag = [tag integerValue];
        if(viewTag>=0 && viewTag<[self.views count])
        {
            KKGestureLockItemView *button = self.views[viewTag];
            [button setItemViewType:KKGestureLockItemTypeSelect];
            [_gestureLineView.selectedButtons addObject:button];
        }
    }

    [_gestureLineView setNeedsDisplay];
}
@end
