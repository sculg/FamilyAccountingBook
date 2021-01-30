//
//  StringHelper.m
//  hyn
//
//  Created by 陈忠 on 14-6-4.
//  Copyright (c) 2014年 huayangnian. All rights reserved.
//

#import "StringHelper.h" 
#import <CoreText/CoreText.h>

@implementation StringHelper

#pragma mark - Private Methods

+ (BOOL)regExpMatchStr:(NSString *)str withPattern:(NSString *)withPattern
{
    NSRange range = [str rangeOfString:withPattern options:NSRegularExpressionSearch];
    return range.location != NSNotFound;
}

#pragma mark - Public Methods

#pragma mark -- CGSize

+ (CGSize)calculateSize:(CGSize)size font:(UIFont *)font  ContentValue:(NSString *)content{
    if ([content isKindOfClass:[NSNull class]] || content == nil || [content length] == 0) {
        return CGSizeZero;
    }
    CGSize expectedLabelSize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        expectedLabelSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

+ (CGSize)calculateSize:(CGSize)size font:(UIFont *)font  ContentValue:(NSString *)content LineSpace:(CGFloat)lineSpace{
    if ([content isKindOfClass:[NSNull class]] || content == nil || [content length] == 0) {
        return CGSizeZero;
    }
    CGSize expectedLabelSize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpace;
        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        expectedLabelSize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    }
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

#pragma mark -- String Empty

//处理空字符串
+(NSString *)stringEmptyValue:(id)value{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
	if ([value isKindOfClass:[NSNull class]] ||value == nil || [value length] == 0) {
		return @"";
    }
	return  value;
}

+(NSString *)stringEmptyValue:(NSString *)value PholderText:(NSString *)text isRight:(BOOL)isright{
    if ([value isKindOfClass:[NSNumber class]]) {
        if (isright) {
            return [NSString stringWithFormat:@"%@%@",value,text];
        }
        else{
            return [NSString stringWithFormat:@"%@%@",text,value];
        }
    }
    if ([value isKindOfClass:[NSNull class]] ||value == nil || [value length] == 0) {
        return text;
    }
    if (isright) {
        return [NSString stringWithFormat:@"%@%@",value,text];
    }
    else{
        return [NSString stringWithFormat:@"%@%@",text,value];
    }
}

//处理空字符串
+(NSString *)stringEmptyCharsetValue:(NSString *)value{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
    if ([value isKindOfClass:[NSNull class]] ||value == nil || [value length] == 0) {
        return @"空";
    }
    return  value;
}

//处理空字符串
+(NSString *)stringEmptyCharsetValue:(NSString *)value PholderText:(NSString *)text{
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
    if ([value isKindOfClass:[NSNull class]] ||value == nil || [value length] == 0) {
        if (text && [text length]) {
            return text;
        }
        return @"空";
    }
    return  value;
}

+(BOOL)isStringEmptyValue:(NSString *)value{
    if ([value isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNull class]] ||value == nil || [value length] == 0) {
        return YES;
    }
    return NO;
}

#pragma mark --  字符串格式化

+ (double)formatterDoubleValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [value doubleValue];//[value doubleValue];
}

+ (CGFloat)formatterValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [value floatValue];
}

+ (CGFloat)formatterMinusValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return -1;
    }
    return [value floatValue];
}

+ (long long)formatterLongValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [value longLongValue];
}

+ (NSInteger)formatterIntValue:(NSString *)value
{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [value integerValue];
}

+ (NSInteger)formatterIntEmptyValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return -1;
    }
    return [value integerValue];
}

+ (BOOL)formatterBooLValue:(NSString *)value{
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return [value boolValue];
}

+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    if ([str length] == 0) {
        return @"";
    }
    //去掉头部和尾部的字符
    NSString *headTemp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *footText = [headTemp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    //去掉中间所有的换行字符
    NSString *temp = [footText stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

#pragma mark -- Date

/**
 *  @brief 将时间戳转换成正常时间
 *
 *  @param timeValue 时间戳字符串(毫秒)
 *
 *  @return 正常时间
 */
+ (NSString *)getTime:(NSString *)timeValue
{
    if (timeValue == nil || [timeValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    long long  count = [timeValue longLongValue];
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(count/1000)]];
}

+ (NSDate *)getDateFormatter:(NSString *)timeValue
{
    if (timeValue == nil || [timeValue isKindOfClass:[NSNull class]]) {
        return [NSDate date];
    }
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:timeValue];
}

//长时间格式化 年月日
+ (NSString *)getTimeLong:(long long)timeValue{
    if (timeValue <= 0) {
        return @"";
    }
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(timeValue/1000)]];
}

+ (NSDate *)getTimeForLong:(NSString *)timeValue
{
    if (timeValue == nil || [timeValue isKindOfClass:[NSNull class]]) {
        return [NSDate date];
    }
    long long  count = [timeValue longLongValue];
    //    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [NSDate dateWithTimeIntervalSince1970:(count/1000)];
}
//返回长整形格式化时间
+ (NSDate *)getTimeForLongDate:(long long)timeValue{
    if(timeValue <= 0) {
        return [NSDate  date];
    }
    return [NSDate dateWithTimeIntervalSince1970:(timeValue/1000)];
}

+ (NSDate *)getTimeDateFormatter:(NSString *)timeDate{
    if ([timeDate isKindOfClass:[NSNull class]] || timeDate == nil) {
        return  nil;
    }
    
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate   *currentDate = [dateFormatter dateFromString:timeDate];
    return currentDate;
}

+ (NSDate *)getTimeDateLongFormatter:(NSString  *)timeValue{
    if (timeValue == nil || [timeValue isKindOfClass:[NSNull class]]) {
        return nil;
    }
    long long  count = [timeValue longLongValue];
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSDate dateWithTimeIntervalSince1970:(count/1000)];
}

/**
 *	格式化日期
 *
 *	@param timeDate  日期: 年月日 时间
 *
 *	@return 年月日
 */
+ (NSString *)getTimeFormatter:(NSString *)timeDate{
    if ([timeDate isKindOfClass:[NSNull class]]) {
        return  nil;
    }
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate   *currentDate = [dateFormatter dateFromString:timeDate];
    return [NSString stringWithFormat:@"%d-%d-%d",(int)currentDate.year,(int)currentDate.month,(int)currentDate.day];
}


/** 格式化日期 "2016-07-19 16:24:04" -> "2016-07-19" */
+ (NSString *)getYYYY_MM_HHTimeStringWithString:(NSString *)timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:timeString];
    if (date) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:date];
    }
    else {
        return @"";
    }
}

/**
 *	格式化日期
 *
 *	@param timeDate  日期: 年月日 时间
 *
 *	@return yyyy年mm月dd日
 */
+ (NSString *)getCNTimeFormatter:(NSString *)timeDate{
    if ([timeDate isKindOfClass:[NSNull class]]) {
        return  nil;
    }
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate   *currentDate = [dateFormatter dateFromString:timeDate];
    return [NSString stringWithFormat:@"%d年%d月%d日",(int)currentDate.year,(int)currentDate.month,(int)currentDate.day];
}
//+ (NSString *)getCNDateTimeFormatter:(NSString *)timeDate {
//    if ([timeDate isKindOfClass:[NSNull class]]) {
//        return  nil;
//    }
//    NSDate *date = [NSDate dateFromString:timeDate TimeFormat:@"yyyy-MM-dd HH:mm"];
//    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//    return [dateFormatter stringFromDate:date];
//;
//}

+ (NSString *)getTimeHousFormatter:(NSString *)timeDate{
    if ([timeDate isKindOfClass:[NSNull class]]) {
        return  nil;
    }
    NSDateFormatter *   dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate   *currentDate = [dateFormatter dateFromString:timeDate];
    return [NSString stringWithFormat:@"%d-%d-%d %d时",(int)currentDate.year,(int)currentDate.month,(int)currentDate.day,(int)currentDate.hour];
}

+ (NSArray *)compareTimeFromOriginateTime:(NSString *)originateTimeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSDate *originateDate = [dateFormatter dateFromString:originateTimeDate];
    NSTimeInterval originatetime = [originateDate timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowtime = [nowDate timeIntervalSince1970];
    
    NSTimeInterval compare = originatetime - nowtime;
    
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger minute = 0;
    
    if (compare>0) {
        day    = compare/(3600*24);
        hour = (compare-day*24*3600)/3600;
        minute = (compare - day*24*3600 - hour*3600)/60;
    }
    
    [array addObject:[NSString stringWithFormat:@"%ld",(long)day]];
    [array addObject:[NSString stringWithFormat:@"%ld",(long)hour]];
    [array addObject:[NSString stringWithFormat:@"%ld",(long)minute]];
    
    return array;
}

+ (NSArray *)compareTimeFromOriginateTime:(NSString *)originateTimeDate newTime:(NSString *)newTimeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSDate *originateDate = [dateFormatter dateFromString:originateTimeDate];
    NSTimeInterval originatetime = [originateDate timeIntervalSince1970];
    
    NSDate *newDate = [dateFormatter dateFromString:newTimeDate];
    NSTimeInterval newtime = [newDate timeIntervalSince1970];
    
    NSTimeInterval compare = newtime - originatetime;
    
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger minute = 0;
    
    if (compare>0) {
        day    = compare/(3600*24);
        hour = (compare-day*24*3600)/3600;
        minute = (compare - day*24*3600 - hour*3600)/60;
    }
    
    [array addObject:[NSString stringWithFormat:@"%ld",(long)day]];
    [array addObject:[NSString stringWithFormat:@"%ld",(long)hour]];
    [array addObject:[NSString stringWithFormat:@"%ld",(long)minute]];
    
    return array;
}

+ (NSString *)dateFormatToday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *nowDate = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:nowDate];
    
    return dateString;
}

#pragma mark -- 处理小数位

+ (NSString *)priceFormatterValue:(double)priceValue{
    NSNumberFormatter  *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter  setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:priceValue]];
}

+ (NSString *)priceRMBFormatterValue:(double)priceValue{
    return [NSString stringWithFormat:@"¥%@",[self priceFormatterValue:priceValue]];
}

+ (NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO  raiseOnOverflow:NO  raiseOnUnderflow:NO  raiseOnDivideByZero:NO ];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return  [NSString stringWithFormat: @"%@" ,roundedOunces];
}

+ (NSString *)numberDoubleFormatterValue:(double)priceValue{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:priceValue]];
    return formattedNumberString;
}

+ (NSString *)numberDoubleNotRoundingFormatterValue:(double)priceValue
{
    return [self numberDoubleFormatterValue:[[self notRounding:priceValue afterPoint:2] doubleValue]];
}

+ (NSString *)numberIntFormatterValue:(double)priceValue{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:floor(priceValue)]];
    return formattedNumberString;
}


+ (NSString *)numberDoubleRMBFormatterValue:(double)priceValue{
    return [NSString stringWithFormat:@"%@元",[self numberDoubleFormatterValue:priceValue]];
}

//计算金额 小数点
+ (NSDecimalNumber *)decimalSub:(NSString *)subStr OuncesDecimal:(NSString *)str{
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:subStr];
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:str];
    
    NSDecimalNumber *total = [n2 decimalNumberBySubtracting:n1];
    return  total;
}


+ (NSString *)amtStrFrom:(NSNumber *)inputNumber roundMode:(NSRoundingMode)roundingMode decimalPlaces:(short)numberOfDecimalPlaces commaSeparator:(BOOL)isNeedCommaSeparator {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:numberOfDecimalPlaces raiseOnExactness:NO  raiseOnOverflow:NO  raiseOnUnderflow:NO  raiseOnDivideByZero:NO];
    NSString *stringValue = [NSString stringWithFormat:@"%f", inputNumber.doubleValue];
    NSDecimalNumber *inputDecimalNumber = [[NSDecimalNumber alloc] initWithString:stringValue];
    NSDecimalNumber *outputDecimalNumber = [inputDecimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *formatPrefix = @"";
    if(isNeedCommaSeparator){
        formatPrefix = @"###,";
    }
    NSString *pointLeftFormat = [NSString stringWithFormat:@"%@##0",formatPrefix];
    NSMutableString *format = [NSMutableString stringWithString:pointLeftFormat];
    
    if(numberOfDecimalPlaces > 0){
        [format appendString:@"."];
        for (short i = 0; i < numberOfDecimalPlaces; i++) {
            [format appendString:@"0"];
        }
    }
    [numberFormatter setPositiveFormat:format];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:outputDecimalNumber.doubleValue]];
    return formattedNumberString ?: @"";
}

#pragma mark -- 正则表达式

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)checkURLString:(NSString  *)codeURLValue{
    BOOL isValidURL = NO;
    if (codeURLValue && [codeURLValue length] > 0) {
        NSString *urlRegEx = @"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?";
        //        @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
        NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
        isValidURL = [urlPredic evaluateWithObject:codeURLValue];
    }
    return isValidURL;
}

//正则表达式判断
+ (BOOL)getRegexPredicateWithContent:(NSString *)content Predicate:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:content];
    return isMatch;
}

+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    return isEomji;
}

+ (NSInteger)orderShowStatus:(NSString *)status{
    if ([status isEqualToString:@"WeiFaHuo"]) {
        //未发货
        return 1;
    }
    else if ([status isEqualToString:@"YiFaHuo"]) {
        //已发货
        return 3;
    }
    else if ([status isEqualToString:@"DaiFuKuan"]) {
        //待付款
        return 4;
    }
    else if ([status isEqualToString:@"YiQuXiao"]) {
        //已取消
        return 99;
    }
    else if ([status isEqualToString:@"YiFuKuan"]) {
        //已付款
        return 6;
    }
    return 0;
}

//+ (NSString *)getHintMsgWithPassword:(NSString *)password
//{
//    NSString * hintMsg_f = @"";
//    if([password length] < 8 || [password length] > 20){
//        hintMsg_f = kPasswordVerifySize8LimitTips;
//    }
//    else if ([StringHelper getRegexPredicateWithContent:password Predicate:PasswordPredicate1]) {
//        hintMsg_f = @"密码不能为纯数字";
//    }
//    else if ([StringHelper getRegexPredicateWithContent:password Predicate:PasswordPredicate2]) {
//        hintMsg_f = @"密码不能为纯小写字母";
//    }
//    else if ([StringHelper getRegexPredicateWithContent:password Predicate:PasswordPredicate3]) {
//        hintMsg_f = @"密码不能为纯大写字母";
//    }
//    else if ([StringHelper getRegexPredicateWithContent:password Predicate:PasswordPredicate4]) {
//        hintMsg_f = @"密码不能为纯符号";
//    }
//    //    else if([StringHelper  getRegexPredicateWithContent:password Predicate:PasswordPredicate8])
//    //    {
//    //        hintMsg_f = @"密码不能为纯字母";
//    //    }
//    else if ([password rangeOfString:@" "].length>0) {
//        hintMsg_f = @"密码不能包含空格";
//    }
//    else if ([self regExpMatchStr:password withPattern:PasswordPredicate6]) {
//        hintMsg_f = @"密码不能包含中文";
//    }
//    return hintMsg_f;
//}

+ (NSString *)extractNumberFromString:(NSString *)sourceString {
    
    NSMutableString *numberString = [NSMutableString stringWithString:@""];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:sourceString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while (![scanner isAtEnd]) {
        // Throw away characters before the first number.
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        
        // Collect numbers.
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        if (tempStr.length > 0) {
            [numberString appendString:tempStr];
        }
        tempStr = @"";
    }
    
    return numberString;
}

+ (BOOL)isNumCharacter:(NSString *)string {
    if (string.length != 1) {
        return NO;
    }
    unichar curChar = [string characterAtIndex:0];
    if (curChar >= '0' && curChar <= '9') {
        return YES;
    }
    return NO;
}

#pragma mark -- String Encoding

+ (NSString  *)stringByReplacingPercentEscapesUsingEncoding:(NSString *)stringValue  StringEncoding:(NSStringEncoding)encoding{
    return  [stringValue stringByReplacingPercentEscapesUsingEncoding:encoding];
}

+ (NSString *)stringJsonFormatterArray:(NSArray *)arrayValue
{
    NSString *jsonStr = nil;
    if (arrayValue.count > 0) {
        NSError *parseError = nil;
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:arrayValue options:NSJSONWritingPrettyPrinted error:&parseError];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonStr;
}

#pragma mark -- NSMutableAttributedString


+ (NSMutableAttributedString *)stringFormatterColorValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color{
    NSString  *formatterValue = content;//@"10元话费=99999";
    NSMutableAttributedString *attributeValue  = nil;
    if (randString && [randString length] > 0) {
        NSRange  locationRange = [formatterValue rangeOfString:randString];
        
        if (locationRange.location != NSNotFound) {
            NSInteger  valueLength = [formatterValue length] - locationRange.location - 1;
            if (valueLength < 0) {
                valueLength = 0;
            }
            attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
            [attributeValue addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(locationRange.location+1,valueLength)];
        }
    }
    else{
        attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
        [attributeValue addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,[formatterValue length])];
    }
    return attributeValue;
}

+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor{
    return [self stringFormatterColorHighValue:content RangeOfString:randString ContentColor:color DefaultColor:defaultColor HighFont:nil];
}

+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor  HighFont:(UIFont *)font{
    return [self stringFormatterColorHighValue:content RangeOfString:randString ContentColor:color DefaultColor:defaultColor HighFont:font Length:0];
}

+ (NSMutableAttributedString *)stringFormatterColorHighValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color DefaultColor:(UIColor *)defaultColor  HighFont:(UIFont *)font  Length:(NSInteger)locationValue{
    NSString  *formatterValue = content;//@" 今天抽奖 2次 ,明天继续
    NSMutableAttributedString *attributeValue  = nil;
    if (randString && [randString length] > 0) {
        NSRange  locationRange = [formatterValue rangeOfString:randString];
        if (locationRange.location != NSNotFound) {
            NSInteger  valueLength = [formatterValue length] - locationRange.location - 1;
            if (valueLength < 0) {
                valueLength = 0;
            }
            attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
            [attributeValue addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0,[formatterValue length])];
            [attributeValue addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(locationRange.location,randString.length + locationValue)];
            
            if (font) {
                [attributeValue addAttribute:(NSString *)kCTFontAttributeName value:font range:NSMakeRange(locationRange.location,randString.length + locationValue)];
            }
        }
    }
    else{
        attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
        [attributeValue addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0,[formatterValue length])];
    }
    return attributeValue;
}

+ (NSMutableAttributedString *)stringFormatterColorHighWithFontValue:(NSString *)content  RangeOfString:(NSString *)randString  ContentColor:(UIColor *)color FontValue:(UIFont *)font{
    NSString  *formatterValue = content;//@"10元话费=99999";
    
    NSMutableAttributedString *attributeValue  = nil;
    if (randString && [randString length] > 0) {
        NSRange  locationRange = [formatterValue rangeOfString:randString];
        
        if (locationRange.location != NSNotFound) {
            NSInteger  valueLength = [formatterValue length] - locationRange.location - 1;
            if (valueLength < 0) {
                valueLength = 0;
            }
            attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
            if (font) {
                [attributeValue addAttribute:(NSString *)kCTFontAttributeName value:font range:NSMakeRange(locationRange.location+1,valueLength)];
            }
            [attributeValue addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(locationRange.location+1,valueLength)];
        }
    }
    else{
        attributeValue = [[NSMutableAttributedString alloc] initWithString:formatterValue];
        if (font) {
            [attributeValue addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,[formatterValue length])];
        }
        [attributeValue addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,[formatterValue length])];
    }
    return attributeValue;
}




+ (NSMutableAttributedString *)stringPriceValue:(CGFloat)value NormalFont:(UIFont *)normalfont  BoldFont:(UIFont *)boldfont isUnit:(BOOL)isunit{
    NSString  *priceValue = [NSString stringWithFormat:@"%.2f",value];
    if (isunit) {
        priceValue = [NSString stringWithFormat:@"%.2f",value];
    }
    CTFontRef ctNormalFont = CTFontCreateWithName((__bridge CFStringRef)normalfont.fontName, normalfont.pointSize, NULL);
    CTFontRef ctBoldFont = CTFontCreateWithName((__bridge CFStringRef)boldfont.fontName, boldfont.pointSize, NULL);
    
    //价格区域
    NSRange  range = [priceValue rangeOfString:@"."];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:priceValue];
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)ctNormalFont range:NSMakeRange(range.location+1, 2)];
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)ctBoldFont range:NSMakeRange(0, range.location)];
    CFRelease(ctNormalFont);
    CFRelease(ctBoldFont);
    return attributedString;
}

+ (NSAttributedString *)text:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    if ([text isKindOfClass:[NSString class]]) {
        NSDictionary *dict = @{NSForegroundColorAttributeName: color, NSFontAttributeName: font};
        return [[NSAttributedString alloc] initWithString:text attributes:dict];
    }
    else {
        return nil;
    }
}

+ (NSAttributedString *)aheadString:(NSString *)aheadString appendString:(NSString *)appendString prefixColor:(UIColor *)prefixColor prefixFont:(UIFont *)prefixFont subColor:(UIColor *)subColor subFont:(UIFont *)subFont
{
    NSMutableAttributedString *mAttri = [[NSMutableAttributedString alloc] init];
    NSAttributedString *preAttri = [StringHelper text:aheadString color:prefixColor font:prefixFont];
    NSAttributedString *subAttri = [StringHelper text:appendString color:subColor font:subFont];
    if (preAttri) {
        [mAttri appendAttributedString:preAttri];
    }
    if (subAttri) {
        [mAttri appendAttributedString:subAttri];
    }
    return mAttri;
}

+(NSMutableAttributedString *)getAnnualRateAttributedStringWithString:(NSString *)annualRateText largeFont:(UIFont *)largeFont smalFont:(UIFont *)smallFont textColor:(UIColor *)textColor{
    
    if(!annualRateText){
        return nil;
    }
    
    NSMutableAttributedString *annualRateAttributedText = [[NSMutableAttributedString alloc] initWithString:annualRateText];
    [annualRateAttributedText addAttributes:@{ NSForegroundColorAttributeName: textColor, NSFontAttributeName: largeFont } range:NSMakeRange(0, annualRateText.length)];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(%)" options:kNilOptions error:nil];
    
    [regex enumerateMatchesInString:annualRateAttributedText.string options:kNilOptions range:NSMakeRange(0, annualRateAttributedText.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange subStringRange = [result rangeAtIndex:0];
        if(subStringRange.location != NSNotFound){
            [annualRateAttributedText addAttributes:@{NSFontAttributeName:smallFont} range:subStringRange];
        }
    }];
    
    NSRange range = [annualRateAttributedText.string rangeOfString:@"+" options:NSBackwardsSearch];
    if(range.location == NSNotFound){
        return annualRateAttributedText;
    }
    range.length = annualRateAttributedText.length-range.location;
    [annualRateAttributedText addAttributes:@{ NSFontAttributeName: smallFont,NSBaselineOffsetAttributeName:@(largeFont.capHeight-smallFont.capHeight)} range:range];
    
    
    
    return annualRateAttributedText;
    
}


+ (NSMutableAttributedString *)handleRate:(NSString *)rate
                                largeFont:(UIFont *)largeFont
                                 smalFont:(UIFont *)smallFont
                                textColor:(UIColor *)textColor
{
    //字号和颜色
    NSDictionary *attributes = @{NSForegroundColorAttributeName: textColor, NSFontAttributeName: largeFont };
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:rate attributes:attributes];
    
    //%号字体
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(%)" options:kNilOptions error:nil];
    [regex enumerateMatchesInString:attriString.string options:kNilOptions range:NSMakeRange(0, attriString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL *stop) {
        NSRange subStringRange = [result rangeAtIndex:0];
        if(subStringRange.location != NSNotFound){
            [attriString addAttributes:@{NSFontAttributeName:smallFont} range:subStringRange];
        }
    }];
    
    //+号后面字体处理
    NSRange range = [attriString.string rangeOfString:@"+" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        range.length = attriString.length - range.location;
        [attriString addAttributes:@{NSFontAttributeName: smallFont} range:range];
        return attriString;
    }
    else {
        return attriString;
    }
}

+ (NSMutableAttributedString *)contentLineBreakWithColor:(NSString *)contentValue FontValue:(UIFont *)fontValue LineSpcing:(CGFloat)lineSpacing TextColor:(UIColor *)textColor{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentValue];
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName:textColor,
                                      NSFontAttributeName:fontValue
                                      }
                              range:NSMakeRange(0, [contentValue length])];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentValue length])];
    return attributedString;
}

+ (NSMutableAttributedString *)getStatisticsAttributedStringWithString:(NSString *)statisticsText largeFont:(UIFont *)largeFont smalFont:(UIFont *)smallFont textColor:(UIColor *)textColor {
    
    if(!statisticsText){
        return nil;
    }
    
    NSMutableAttributedString *statisticsAttributedText = [[NSMutableAttributedString alloc] initWithString:statisticsText];
    [statisticsAttributedText addAttributes:@{ NSForegroundColorAttributeName: textColor, NSFontAttributeName: largeFont } range:NSMakeRange(0, statisticsText.length)];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\u4e00-\u9fa5]" options:kNilOptions error:nil];
    
    [regex enumerateMatchesInString:statisticsAttributedText.string options:kNilOptions range:NSMakeRange(0, statisticsAttributedText.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSRange subStringRange = [result rangeAtIndex:0];
        if(subStringRange.location != NSNotFound){
            [statisticsAttributedText addAttributes:@{NSFontAttributeName:smallFont} range:subStringRange];
        }
    }];
    
    return statisticsAttributedText;
    
}

#pragma mark -- Other

//获取版本号
+ (NSString*)appVersion
{
    CFStringRef versStr = (CFStringRef)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey);
    NSString *version = [NSString stringWithUTF8String:CFStringGetCStringPtr(versStr,kCFStringEncodingMacRoman)];
    return version;
}

@end
