//
//  UIImage_extra.m
//  LqzTest
//
//  Created by Kyle Yang on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImage_extra.h"

@implementation UIImage (extra)
+ (UIImage *)imageScaleNamed:(NSString *)name
{
    UIImage *img = [UIImage imageNamed:name];
    NSArray *arr1 = [name componentsSeparatedByString:@"#"];
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];  
    if (arr1 && [arr1 count]==3) {
        NSString *tmpStr = [arr1 objectAtIndex:1];
        NSArray *arr2 = [tmpStr componentsSeparatedByString:@"_"];
        if ([arr2 count]==4) {
            if (version >= 5.0)  
            {  
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake([[arr2 objectAtIndex:0] doubleValue], [[arr2 objectAtIndex:1] doubleValue], [[arr2 objectAtIndex:2] doubleValue], [[arr2 objectAtIndex:3] doubleValue]);
                img = [img resizableImageWithCapInsets:edgeInsets];
            }else{
                double leftCapWidth = MAX([[arr2 objectAtIndex:1] doubleValue], [[arr2 objectAtIndex:3] doubleValue]);
                double topCapHeight = MAX([[arr2 objectAtIndex:0] doubleValue], [[arr2 objectAtIndex:2] doubleValue]);
                img = [img stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            }
        }
    }
    return img;
}

+ (UIImage *)imageWithContentsOfFileName:(NSString *)name{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

+ (UIImage *)imageScaleNamed:(NSString *)name edgeInsets:(UIEdgeInsets)edgeInsets
{
    UIImage *img = [UIImage imageNamed:name];

//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//
//    if (version >= 5.0)
//    {
//        img = [img resizableImageWithCapInsets:edgeInsets];
//    }
//    else
    {
        double leftCapWidth = MAX(edgeInsets.left, edgeInsets.right);
        double topCapHeight = MAX(edgeInsets.top, edgeInsets.bottom);
        img = [img stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    }
    
    return img;
}

- (UIImage *)imageScaleEdgeInsets:(UIEdgeInsets)edgeInsets
{
    double leftCapWidth = MAX(edgeInsets.left, edgeInsets.right);
    double topCapHeight = MAX(edgeInsets.top, edgeInsets.bottom);
    return [self stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

//1.等比率缩放
- (UIImage *)scaleImageToScale:(float)scaleSize

{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


//2.自定长宽
- (UIImage *)reSizeImageToSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}


//3.处理某个特定View 只要是继承UIView的object 都可以处理
-(UIImage*)captureView:(UIView *)theView
{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//
+(UIImage *)getEllipseImageWithImage:(UIImage *)originImage
{
    //
    CGFloat padding = 0 ; // 圆形图像距离图像的边距
    
    UIColor * epsBackColor = [UIColor clearColor ]; // 图像的背景色
    
    CGSize originsize = originImage.size ;
    
    CGRect originRect = CGRectMake (0,0,originsize.width,originsize.height );
    
    UIGraphicsBeginImageContext(originsize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 目标区域。
    CGRect desRect =  CGRectMake (padding, padding,originsize. width -(padding* 2 ), originsize. height -(padding* 2 ));
    
    // 设置填充背景色。
    CGContextSetFillColorWithColor (ctx, epsBackColor. CGColor );
    
    UIRectFill (originRect); // 真正的填充
    
    // 设置椭圆变形区域。
    CGContextAddEllipseInRect (ctx,desRect);
    
    CGContextClip (ctx); // 截取椭圆区域。
    
    [originImage drawInRect :originRect]; // 将图像画在目标区域。
    
    UIImage * desImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return desImage;
    
}
@end
