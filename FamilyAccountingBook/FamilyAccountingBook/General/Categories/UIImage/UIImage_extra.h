//
//  UIImage_extra.h
//  LqzTest
//
//  Created by Kyle Yang on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface UIImage (extra)

+ (UIImage *)imageScaleNamed:(NSString *)name;

+ (UIImage *)imageWithContentsOfFileName:(NSString *)name;

+ (UIImage *)imageScaleNamed:(NSString *)name edgeInsets:(UIEdgeInsets)edgeInsets;
- (UIImage *)imageScaleEdgeInsets:(UIEdgeInsets)edgeInsets;

//1.等比率缩放
- (UIImage *)scaleImageToScale:(float)scaleSize;


//2.自定长宽
- (UIImage *)reSizeImageToSize:(CGSize)reSize;


//3.处理某个特定View 只要是继承UIView的object 都可以处理
-(UIImage*)captureView:(UIView *)theView;

//
+(UIImage *)getEllipseImageWithImage:(UIImage *)originImage;
@end
