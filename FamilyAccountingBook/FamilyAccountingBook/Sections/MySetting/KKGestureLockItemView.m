//
//  KKGestureLockItemView.m
//  XNOnline
//
//  Created by xia on 15/5/14.
//  Copyright (c) 2015年 xiaoniu88. All rights reserved.
//

#import "KKGestureLockItemView.h"


@interface KKGestureLockItemView()
@property(nonatomic,assign)KKGestureLockItemType drawType;
@end

@implementation KKGestureLockItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        _drawType = KKGestureLockItemTypeNormal;
    }
    return self;
}

-(KKGestureLockItemType)getDrawType
{
    return _drawType;
}

-(void)setItemViewType:(KKGestureLockItemType)type
{
    _drawType = type;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    
    //
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,self.bounds);
    CGContextSaveGState(context);
    //抗锯齿
    CGContextSetAllowsAntialiasing(context,TRUE);
    CGContextSetShouldAntialias(context,YES);
    CGContextSetShouldSmoothFonts(context,TRUE);
    
    //
    CGFloat width_f = CGRectGetWidth(self.bounds);
    CGFloat height_f = CGRectGetHeight(self.bounds);
    
    NSInteger radius = width_f>height_f?height_f:width_f;
    radius = radius/2 * 2;
    CGPoint centerP = CGPointMake(width_f/2,height_f/2);
    
#warning 这里要修改
//    NSInteger innerRadius = radius - 16 * autoSizeScaleY();
    NSInteger innerRadius = radius ;
    //
    CGFloat lineWidth = 1.0f;
    CGRect bounds = CGRectMake(centerP.x-radius/2+lineWidth,centerP.y-radius/2+lineWidth,radius-2*lineWidth,radius-2*lineWidth);
    
    //
    CGFloat innerLineWidth = 0.5f;
    CGRect innerBounds = CGRectMake(centerP.x-innerRadius/2+innerLineWidth,centerP.y-innerRadius/2+innerLineWidth,innerRadius-2*innerLineWidth,innerRadius-2*innerLineWidth);
    switch (_drawType)
    {
        case KKGestureLockItemTypeNormal:
        {
            CGContextSetStrokeColorWithColor(context,KKGesture_NormalColor.CGColor);
            CGContextSetLineWidth(context,lineWidth);
            CGContextAddEllipseInRect(context,bounds);
            CGContextStrokePath(context);
        }
            break;
        case KKGestureLockItemTypeSelect:
        {
            CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
            CGContextSetLineWidth(context,lineWidth);
            CGContextAddEllipseInRect(context,bounds);
            CGContextStrokePath(context);
            
            if(_isShowInner)
            {
                CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
                CGContextSetLineWidth(context,innerLineWidth);
                CGContextAddEllipseInRect(context,innerBounds);
                CGContextStrokePath(context);
            }
            
            CGContextSetStrokeColorWithColor(context,KKGesture_SelectColor.CGColor);
            CGContextSetFillColorWithColor(context,KKGesture_SelectColor.CGColor);
            CGContextAddEllipseInRect(context,CGRectMake(centerP.x-_nodeWith/2,centerP.y-_nodeWith/2,_nodeWith,_nodeWith));
            CGContextFillPath(context);
        }
            break;
        case KKGestureLockItemTypeError:
        {
            CGContextSetStrokeColorWithColor(context,KKGesture_ErrorColor.CGColor);
            CGContextSetLineWidth(context,lineWidth);
            CGContextAddEllipseInRect(context,bounds);
            CGContextStrokePath(context);
            
            if(_isShowInner)
            {
                CGContextSetStrokeColorWithColor(context,KKGesture_ErrorColor.CGColor);
                CGContextSetLineWidth(context,innerLineWidth);
                CGContextAddEllipseInRect(context,innerBounds);
                CGContextStrokePath(context);
            }
            
            CGContextSetStrokeColorWithColor(context,KKGesture_ErrorColor.CGColor);
            CGContextSetFillColorWithColor(context,KKGesture_ErrorColor.CGColor);
            CGContextAddEllipseInRect(context,CGRectMake(centerP.x-_nodeWith/2,centerP.y-_nodeWith/2,_nodeWith,_nodeWith));
            CGContextFillPath(context);
        }
            break;
        default:
            break;
    }
    
    CGContextRestoreGState(context);
}

@end
