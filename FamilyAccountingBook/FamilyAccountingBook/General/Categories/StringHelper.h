//
//  StringHelper.h
//  hyn
//
//  Created by 陈忠 on 14-6-4.
//  Copyright (c) 2014年 huayangnian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringHelper : NSObject

#pragma mark -- CGSize

/**
 *  计算文字大小的兼容IOS6和7的代码
 *
 *  @param size    文字限制
 *  @param font      字体大小
 *  @param content 文本内容
 *
 *  @return
 */
+ (CGSize)calculateSize:(CGSize)size font:(UIFont *)font  ContentValue:(NSString *)content;

/**
 *  计算文字大小的兼容IOS6和7的代码
 *
 *  @param size    文字限制
 *  @param font      字体大小
 *  @param content 文本内容
 *  @param lineSpace 间距
 *  @return
 */
+ (CGSize)calculateSize:(CGSize)size font:(UIFont *)font  ContentValue:(NSString *)content LineSpace:(CGFloat)lineSpace;

#pragma mark -- String Empty

/**
 *  处理空字符串
 *
 *  @param value 参数
 *
 *  @return 处理字符结果
 */
+(NSString *)stringEmptyValue:(id)value;

/**
 *	处理带有默认字符加对应参数的字符串
 *
 *	@param value   参数值
 *	@param text   带有默认字符串  比如 test: 222   默认字符串+参数值
 * @param isright  YES: 默认字符串在右边   NO：默认字符串在左边
 *	@return
 */
+(NSString *)stringEmptyValue:(NSString *)value PholderText:(NSString *)text isRight:(BOOL)isright;

/**
 *  返回空的字符结果
 *
 *  @param value
 */
+(NSString *)stringEmptyCharsetValue:(NSString *)value;

/**
 *	 返回空字符串加默认字符
 *	@return
 */
+(NSString *)stringEmptyCharsetValue:(NSString *)value PholderText:(NSString *)text;

/**
 *	字符串是否为空Null
 *
 *	@param value
 *
 */
+(BOOL)isStringEmptyValue:(NSString *)value;

#pragma mark --  字符串格式化

/**
 *  返回浮点型
 *
 *  @param value 浮点值
 *
 *  @return  
 */
+ (CGFloat)formatterValue:(NSString *)value;

/**
 *	浮点型 空值返回 -1
 *
 *	@param value   参数
 *
 *	@return
 */
+ (CGFloat)formatterMinusValue:(NSString *)value;

/**
 *  返回双浮点类型
 *
 *  @param value  浮点字符串
 *
 *  @return
 */
+ (double)formatterDoubleValue:(NSString *)value;
/**
 *  返回整型
 *
 *  @param value 整型值
 *
 *  @return
 */
+ (NSInteger)formatterIntValue:(NSString *)value;

//空字符返回 -1
+ (NSInteger)formatterIntEmptyValue:(NSString *)value;

/**
 *	长整形
 *
 *	@param value
 *
 *	@return
 */
+ (long long)formatterLongValue:(NSString *)value;
/**
 *  返回布尔类型
 *
 *  @param value
 *
 *  @return
 */
+ (BOOL)formatterBooLValue:(NSString *)value;

/**
 *	去掉换行和空格符
 *
 *	@param str  描述字符
 *
 *	@return  格式化后的字符
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

#pragma mark -- Date

/**
 *  @brief 将时间戳转换成正常时间
 *
 *  @param timeValue 时间戳字符串(毫秒)
 *
 *  @return 正常时间
 */
+ (NSString *)getTime:(NSString *)timeValue;

/**
 *	 将时间转换成 格式化时间
 *
 *	@param timeValue 时间毫秒
 *
 *	@return  年月日时间
 */
+ (NSString *)getTimeLong:(long long)timeValue;

/**
 *  @brief 将时间戳转换成正常时间
 *
 *  @param timeValue 时间戳字符串(毫秒)
 *
 *  @return 正常时间 NSDate
 */
+ (NSDate *)getTimeForLong:(NSString *)timeValue;

/**
 *	长整形 返回 日期
 *
 *	@param timeValue   时间 长整形
 *
 *	@return
 */
+ (NSDate *)getTimeForLongDate:(long long)timeValue;

/**
 *  日期类型
 *
 *  @param timeValue 年-月-日
 *
 *  @return 日期类型
 */
+ (NSDate *)getDateFormatter:(NSString *)timeValue;

/**
 *	格式化日期
 *
 *	@param timeDate  日期: 年月日 时间
 *
 *	@return 年月日
 */
+ (NSString *)getTimeFormatter:(NSString *)timeDate;

/** 格式化日期 "2016-07-19 16:24:04" -> "2016-07-19" */
+ (NSString *)getYYYY_MM_HHTimeStringWithString:(NSString *)timeString;

/**
 *	格式化日期
 *
 *	@param timeDate  日期: 年月日 时间
 *
 *	@return yyyy年mm月dd日
 */
+ (NSString *)getCNTimeFormatter:(NSString *)timeDate;

/**
 * 格式化日期
 *
 *	@param timeDate  时期: 年月日 时间
 *
 *	@return  年月日  多少时  比如 2014-12-3  10时
 */
+ (NSString *)getTimeHousFormatter:(NSString *)timeDate;

///**
// * 格式化日期 时间不变
// *
// *	@param timeDate  2014-12-3 10:12
// *
// *	@return  年月日  时分  比如 2014年12月3日  10:12
// */
//+ (NSString *)getCNDateTimeFormatter:(NSString *)timeDate;

/**
 *	 格式化字符串
 *
 *	@param timeValue  日期长整形
 *
 *	@return  时间长类型 返回一个日期
 */
+ (NSDate *)getTimeDateLongFormatter:(NSString  *)timeValue;

/**
 *	 格式化日期 时间字符串
 *
 *	@param timeDate  日期字符串
 *
 *	@return  日期
 */
+ (NSDate *)getTimeDateFormatter:(NSString *)timeDate;

/**
 *  计算两个时间的相差
 *	@param originateDate 服务器时间
 *  @return 相差值的天、分、秒数
 **/
+ (NSArray *)compareTimeFromOriginateTime:(NSString *)originateTimeDate;

/**
 *  计算两个时间的相差
 *	@param originateDate 原始时间
 *  @param newTimeDate   新时间
 *  @return 相差值的天、分、秒数
 **/
+ (NSArray *)compareTimeFromOriginateTime:(NSString *)originateTimeDate newTime:(NSString *)newTimeDate;

/**
 * 转化时间
 **/
+ (NSString *)dateFormatToday;

#pragma mark -- 处理小数位

/**
 格式化价格，去掉0的小数点。
 1234.5678 -> 1,234.568
 1234.50 -> 1,234.5
 
 @param priceValue
 @return
 */
+ (NSString *)priceFormatterValue:(double)priceValue;

/**
 *	带有人民币的符号的格式化价格
 *  1234.5678 -> ¥1,234.568
 *  1234.50 -> ¥1,234.5
 *  
 *
 *
 *	@param priceValue
 *
 *	@return
 */
+ (NSString *)priceRMBFormatterValue:(double)priceValue;

/**
 *  格式化 四舍不入 
 *  1234.56 2 -> 1234.55 注意这里有bug
    1234.5678 2 -> 1234.56
    1234.50 2 -> 1234.5
    1234.00 2 -> 1234
 *
 *  @param price    价格
 *  @param position 小数点后面保留几位
 *  @return
 */
+ (NSString *)notRounding:(double)price afterPoint:(int)position;

/**
 *  格式化数字格式 位数以逗号隔开比如
 *  1234.5678 -> 1,234.57元
    1234.50 -> 1,234.50元
 *
 *  @param priceValue 格式化数字
 *
 *  @return  带有人民币
 */
+ (NSString *)numberDoubleRMBFormatterValue:(double)priceValue;

/**
 1234.5678 -> 1,234.57
 1234.50 -> 1,234.50
 
 @param priceValue
 @return
 */
+ (NSString *)numberDoubleFormatterValue:(double)priceValue;

/**
 1234.5678 -> 1,234.56
 1234.50 -> 1,234.50

 @param priceValue priceValue
 @return
 */
+ (NSString *)numberDoubleNotRoundingFormatterValue:(double)priceValue;

/**
 1234.5678 -> 1,234
 1234.50 -> 1,234
 
 @param priceValue
 @return
 */
+ (NSString *)numberIntFormatterValue:(double)priceValue;

/**
 *  浮点计算小数点
 *  减法
 *  @return
 */
+ (NSDecimalNumber *)decimalSub:(NSString *)subStr OuncesDecimal:(NSString *)str;



/**
 数字格式化
 @param inputNumber 输入的number
 @param rundingMode 进位规则
 // 输入数字          1.2  1.21  1.25  1.35  1.27
 // NSRoundPlain    1.2  1.2   1.3   1.4   1.3    // 四舍五入
 // NSRoundDown     1.2  1.2   1.2   1.3   1.2    // 不入
 // NSRoundUp       1.2  1.3   1.3   1.4   1.3    // 始终进位
 // NSRoundBankers  1.2  1.2   1.2   1.4   1.3    // 四舍六入五取偶
 @param numberOfDecimalPlaces 保留小数点后几位
 @param isNeedCommaSeparator 是否需要逗号分隔符 1111.11 -> 1,111.11
 @return 格式化好的string
 */
+ (NSString *)amtStrFrom:(NSNumber *)inputNumber roundMode:(NSRoundingMode)rundingMode decimalPlaces:(short)numberOfDecimalPlaces commaSeparator:(BOOL)isNeedCommaSeparator;

#pragma mark -- 正则表达式

/**
 *	验证文本框输入的字符为  0-9中间数字
 *
 *	@param number 字符串
 *
 *	@return
 */
+ (BOOL)validateNumber:(NSString*)number;

/**
 *	验证字符串是否为URL
 *
 *	@param codeURLValue  字符串
 *
 *	@return  YES：为URL  NO: 不是URL
 */
+ (BOOL)checkURLString:(NSString  *)codeURLValue;

/**
 *  自定义正则表达式
 *
 *  @param content 内容
 *  @param regex   正则表达式
 *
 *  @return YES:符合正则要求 NO: 不符合要求
 */
+ (BOOL)getRegexPredicateWithContent:(NSString *)content Predicate:(NSString *)regex;

/**
 *  判断字符串里有没有emoji表情
 *
 *  @param string 字符串
 *
 *  @return 如果有emoji返回YES
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  订单状态信息
 *
 *  @param status
 "WeiFaHuo":"未发货",
 "YiFaHuo":"已发货",
 "DaiFuKuan":"待付款",
 "YiQuXiao":"已取消",
 "YiFuKuan":"已付款",
 *
 *  @return 返回状态订单
 */
+ (NSInteger)orderShowStatus:(NSString *)status;

///**
// *  密码设置规则 [6~20个字符，至少包含数字、字母、符号中的2种]
// *
// *  @param password 密码
// *
// *  @return 不符合要求字符串提示 符合条件返回@“”
// */
//+ (NSString *)getHintMsgWithPassword:(NSString *)password;

/**
 *  @brief 从字符串中提取出数字
 *
 *  @param sourceString 待处理的字符串
 *
 *  @return 返回提取出来的数字，如果没有则返回空字符串@""
 */
+ (NSString *)extractNumberFromString:(NSString *)sourceString;

/** 判断string是否在'0'-'9'之间 */
+ (BOOL)isNumCharacter:(NSString *)string;

#pragma mark -- String Encoding

/**
 *
 * 编码字符串为指定类型
 *	@param stringValue   原始字符串
 *	@param encoding      编码格式
 *
 *	@return  自定义编码格式返回
 */
+ (NSString  *)stringByReplacingPercentEscapesUsingEncoding:(NSString *)stringValue  StringEncoding:(NSStringEncoding)encoding;

/*
 * 数组转化成json
 **/
+ (NSString *)stringJsonFormatterArray:(NSArray *)arrayValue;

#pragma mark -- NSMutableAttributedString

/**
 *  格式化价格，小数点前大数字，小数点后小数
 *
 *  @param value  2.43
 *
 *  @return $2.43
 */
+ (NSMutableAttributedString *)stringPriceValue:(CGFloat)value NormalFont:(UIFont *)normalfont  BoldFont:(UIFont *)boldfont isUnit:(BOOL)isunit;

/**
 *	格式化字符  查找高亮的字符所在位置 自定义颜色
 *
 *	@param content      文本内容  比如: "10块充值话费=999"
 *	@param randString   查找字符   比如 "="
 *	@param color      高亮颜色
 *
 *	@return  10块充值话费=   999高亮
 *  这个方法设置高亮有bug，请用后面的方法。
 */
+ (NSMutableAttributedString *)stringFormatterColorValue:(NSString *)content RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color;

/**
 *  格式化字符  查找高亮的字符所在位置 自定义颜色
 *
 *  @param content      文本内容  比如: "10块充值话费=999"
 *  @param randString   查找字符   比如 "="
 *  @param color        高亮颜色
 *  @param defaultColor 其他默认字体颜色
 *
 *  @return 10块充值话费=   999高亮
 */
+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor;

//扩展定位高亮字体加粗或者加大字号等
+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor  HighFont:(UIFont *)font;

/**
 *  自定义字体大小 比如 11.40%  11是大字体 .40为小字体
 *
 *  @param content      字符串
 *  @param randString   高亮点
 *  @param color        高亮颜色
 *  @param defaultColor 默认颜色
 *  @param font         高亮后的字体颜色
 *  @param location     高亮点位置长度
 *
 *  @return 返回11大字体 .40小字号
 */
+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor  HighFont:(UIFont *)font  Length:(NSInteger)location;

/**
 *	格式化文字颜色和加粗
 *
 *	@param content      文本内容   比如: "10块充值话费=999"
 *	@param randString   查找字符   比如 "="
 *	@param color      高亮颜色
 *	@param font        字体大小
 *	@return  10块充值话费=   999高亮

 *
 *	@return  10块充值话费=   999高亮 加粗
 */
+ (NSMutableAttributedString *)stringFormatterColorHighWithFontValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color FontValue:(UIFont *)font;

/**
 *  字符串换行高度间隔和文本颜色
 *
 *  @param contentValue 字符串
 *  @param lineSpacing 行间距
 *  @param textColor   文本颜色
 *
 *  @return 如果有emoji返回YES
 */
+ (NSMutableAttributedString *)contentLineBreakWithColor:(NSString *)contentValue FontValue:(UIFont *)fontValue LineSpcing:(CGFloat)lineSpacing TextColor:(UIColor *)textColor;

+(NSMutableAttributedString *)getAnnualRateAttributedStringWithString:(NSString *)annualRateText largeFont:(UIFont *)largeFont smalFont:(UIFont *)smallFont textColor:(UIColor *)textColor;


/**
 处理利率显示 10.00%-12.00% +3.00% （+号前面字体变大、后面字体变小，所有%字体变小）

 @param rate 处理后的利率字符串(不为空)
 @param largeFont 大号字体(不为空)
 @param smallFont 小号字体(不为空)
 @param textColor 字体颜色(不为空)
 @return 返回富文本
 */
+ (NSMutableAttributedString *)handleRate:(NSString *)rate
                                largeFont:(UIFont *)largeFont
                                 smalFont:(UIFont *)smallFont
                                textColor:(UIColor *)textColor;

+ (NSMutableAttributedString *)getStatisticsAttributedStringWithString:(NSString *)statisticsText largeFont:(UIFont *)largeFont smalFont:(UIFont *)smallFont textColor:(UIColor *)textColor;

/**
 定制字体颜色
 
 @param color 字体颜色
 @param font  字体大小
 
 @return NSAttributedString
 */
+ (NSAttributedString *)text:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

/**
 附加字体颜色
 
 @param aheadString  前段字符串
 @param appendString 后段字符串
 @param prefixColor  前段字体颜色
 @param prefixFont   前段字体大小
 @param subColor     后段字体颜色
 @param subFont      后段字体大小
 
 @return 对应定制字体
 */
+ (NSAttributedString *)aheadString:(NSString *)aheadString appendString:(NSString *)appendString prefixColor:(UIColor *)prefixColor prefixFont:(UIFont *)prefixFont subColor:(UIColor *)subColor subFont:(UIFont *)subFont;




#pragma mark -- Other

/**
 *	当前版本号
 *
 *	@return 版本号编号
 */
+ (NSString*)appVersion;



@end
