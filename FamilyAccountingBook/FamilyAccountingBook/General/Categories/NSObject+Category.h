//
//  NSObject+Category.h
//  PARockPay
//
//  Created by Chen Jacky on 12-12-3.
//  Copyright (c) 2012年 xyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

/**
 *  @brief 创建UIView对象, 背景色默认为透明, frame为CGRectZero
 *
 *  @return UIView对象
 */
- (UIView *)newView;

/**
 *  @brief 根据传人的背景色创建UIView对象,传nil则使用透明背景色
 *
 *  @param backgroundColor 背景色
 *
 *  @return UIView对象
 */
- (UIView *)newViewWithBackgroundColor:(UIColor *)backgroundColor;

/**
 *  @brief 根据传人的Frame创建UIView对象, 背景色默认为透明
 *
 *  @param frame 视图的Frame
 *
 *  @return UIView对象
 */
- (UIView *)newViewWithFrame:(CGRect)frame;

- (UILabel *)newLabelWithText:(NSString*)text
                        frame:(CGRect)frame
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor;

/**
 *  @brief 根据传人的参数创建UILabel对象, 背景色默认为透明
 *
 *  @param text          文本
 *  @param textColor     文本颜色
 *  @param textFont      文本字体大小
 *  @param textAlignment 文本的对齐方式
 *
 *  @return UILabel对象
 */
- (UILabel *)newLabelWithText:(NSString*)text
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                textAlignment:(NSTextAlignment)textAlignment;

/**
 *  @brief 根据传人的参数创建UILabel对象, 背景色默认为透明
 *
 *  @param textColor     文本颜色
 *  @param textFont      文本字体大小
 *  @param textAlignment 文本的对齐方式
 *
 *  @return UILabel对象
 */
- (UILabel *)newLabelWithTextColor:(UIColor *)textColor
                          textFont:(UIFont *)textFont
                     textAlignment:(NSTextAlignment)textAlignment;

/**
 *  @brief 根据传人的参数创建UILabel对象, 背景色默认为透明
 *
 *  @param text          文本
 *  @param textColor     文本颜色
 *  @param textFont      文本字体大小
 *  @param textAlignment 文本的对齐方式
 *  @param numberOfLines 文本的行数，传0代表不限行数
 *
 *  @return UILabel对象
 */
- (UILabel *)newLabelWithText:(NSString*)text
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines;

/**
 *  @brief 根据传人的参数创建UIButton对象, 背景色默认为透明
 *
 *  @param backgroundImage            背景图片
 *  @param highlightedBackgroundImage 高亮时的背景图片
 *  @param title                      标题
 *  @param titleColor                 标题颜色
 *  @param highlightedTitleColor      高亮
 *  @param target                     响应事件处理的目标对象
 *  @param action                     事件处理的方法
 *
 *  @return UIButton对象
 */
- (UIButton *)newButtonWithBackgroundImage:(UIImage *)backgroundImage
                highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
                                     title:(NSString *)title
                                titleColor:(UIColor *)titleColor
                     highlightedTitleColor:(UIColor *)highlightedTitleColor
                                    target:(id)target
                                    action:(SEL)action;

/**
 *  @brief 根据传人的参数创建UIButton对象, 背景色默认为透明
 *
 *  @param backgroundImage            背景图片
 *  @param highlightedBackgroundImage 高亮时的背景图片
 *  @param image                      图片
 *  @param highlightedImage           高亮时的图片
 *  @param title                      标题
 *  @param titleColor                 标题颜色
 *  @param highlightedTitleColor      高亮
 *  @param target                     响应事件处理的目标对象
 *  @param action                     事件处理的方法
 *
 *  @return UIButton对象
 */
- (UIButton *)newButtonWithBackgroundImage:(UIImage *)backgroundImage
                highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
                                     image:(UIImage *)image
                          highlightedImage:(UIImage *)highlightedImage
                                     title:(NSString *)title
                                titleColor:(UIColor *)titleColor
                     highlightedTitleColor:(UIColor *)highlightedTitleColor
                                    target:(id)target
                                    action:(SEL)action;

- (UIButton *)newButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
						   frame:(CGRect)frame
						   title:(NSString *)title
					  titleColor:(UIColor *)titleColor
				titleShadowColor:(UIColor *)titleShadowColor
							font:(UIFont *)font
						  target:(id)target
                          action:(SEL)action;

- (UIButton *)newButtonWithImage:(UIImage *)image
				highlightedImage:(UIImage *)highlightedImage
						   frame:(CGRect)frame
						   title:(NSString *)title
					  titleColor:(UIColor *)titleColor
				titleShadowColor:(UIColor *)titleShadowColor
							font:(UIFont *)font
						  target:(id)target
                          action:(SEL)action
                    shodowOffset:(CGSize)size;

- (UIImageView *)newImageViewWithImage:(UIImage *)image frame:(CGRect)frame;

/**
 *  @brief 创建UIImageView对象, 背景色默认为透明
 *
 *  @return UIImageView对象
 */
- (UIImageView *)newImageView;

/**
 *  @brief 根据传人的参数创建UIImageView对象, 背景色默认为透明
 *
 *  @param image 图片
 *
 *  @return UIImageView对象
 */
- (UIImageView *)newImageViewWithImage:(UIImage *)image;

/**
 *  @brief 根据传人的参数创建UITextField对象, 背景色默认为透明
 *
 *  @param textColor   文字颜色
 *  @param textFont    文字字体大小
 *  @param delegate    委托对象
 *  @param placeholder 占位字符串
 *
 *  @return UITextField对象
 */
- (UITextField *)newTextFieldWithTextColor:(UIColor *)textColor
                                  textFont:(UIFont *)textFont
                                  delegate:(id<UITextFieldDelegate>)delegate
                               placeholder:(NSString *)placeholder;
/**
 *  @brief 根据传人的参数创建UITextField对象, 背景色默认为透明
 *
 *  @param textColor   文字颜色
 *  @param textFont    文字字体大小
 *  @param delegate    委托对象
 *  @param attributedPlaceholder 带属性的占位字符串
 *
 *  @return UITextField对象
 */
- (UITextField *)newTextFieldWithTextColor:(UIColor *)textColor
                                  textFont:(UIFont *)textFont
                                  delegate:(id<UITextFieldDelegate>)delegate
                     attributedPlaceholder:(NSAttributedString *)attributedPlaceholder;

/**
 *  @brief 根据传人的参数创建UITextView对象, 背景色默认为透明
 *
 *  @param textColor   文字颜色
 *  @param textFont    文字字体大小
 *  @param delegate    委托对象
 *
 *  @return UITextView对象
 */
- (UITextView *)newTextViewWithTextColor:(UIColor *)textColor
                                textFont:(UIFont *)textFont
                                delegate:(id<UITextViewDelegate>)delegate;


- (UITableView *)newTableViewWithFrame:(CGRect)frame
                                 style:(UITableViewStyle)style
                       backgroundColor:(UIColor *)backgroundColor
                              delegate:(id)delegate
                            dataSource:(id)dataSource
                        separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

/**
 *  @brief 根据传人的参数创建UITableView对象, 背景色默认为透明
 *
 *  @param delegate       委托对象
 *  @param dataSource     数据源对象
 *  @param separatorStyle 分割线样式
 *  @param separatorColor 分割线颜色
 *
 *  @return UITableView对象
 */
- (UITableView *)newTableViewDelegate:(id)delegate
                           dataSource:(id)dataSource
                       separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                       separatorColor:(UIColor *)separatorColor;

- (UIScrollView *)newScrollViewWithFrame:(CGRect)frame
							 contentSize:(CGSize)contentSize
						 backgroundColor:(UIColor *)backgroundColor
								delegate:(id)delegate
						   pagingEnabled:(BOOL)pagingEnabled;

#pragma mark -

//验证email格式地址
-(BOOL)regExpMatch:(NSString *)string
	   withPattern:(NSString*)pattern;

-(BOOL)isValidEmail:(NSString *)email;

//手机号码验证,现在只是验证11位的手机号码（不包含86）
//根据具体业务需求来修改
//如： 13****,158***,159*** 正确; 12***,157*** 错误.
-(BOOL)isValidMobileNumber:(NSString *)number;
-(BOOL)isValidAddressBookPhone:(NSString *)phoneNumber;

/*
 检查输入数据是否为金额要求数据　要求带2位小数
*/
-(bool)doCheckInputAmount:(UITextField *)textField Range:(NSRange)range replacementString:(NSString *)string;

/* 获取app document path */
+(NSString*)getSortDcumentPath;
+(NSString*)getFormatDateString:(NSString*)dateString;
/**
 * 功能：姓名处理 ，姓名部分信息需要屏蔽，具体规则如下：
*/
- (NSString *)editWithName:(NSString *)name;
// 通过身份证最后一位校验码，判断是否正确有效。只对18位身份证号码校验。
- (BOOL)isValidIDNumber:(NSString *)_idNum;

//根据key值得到字符串，如为空则返回@“”
+(UIImage *)createImageWithColor:(UIColor *)color;
-(id)getStringByKey:(NSString*)key;
//-(CGSize)sizeWithAttributes:(NSDictionary*)attrs;
+(CGSize)getStringSizeByFont:(UIFont*)font String:(NSString*)text;
+(NSString*)getHintTime:(NSTimeInterval)seconds;
+(NSString*)handleAmountString:(double)amount;
//清除本地所以cookie
+(void)clearAllCookies;
+(void)deleteCookieWithName:(NSString *)name;
-(void)shakeWithView:(UIView *)view;
@end

#pragma=====================================
@interface NSNull(NullCast)
-(float)floatValue;
-(int)intValue;
-(NSInteger)integerValue;
-(BOOL)boolValue;
-(double)doubleValue;
@end
