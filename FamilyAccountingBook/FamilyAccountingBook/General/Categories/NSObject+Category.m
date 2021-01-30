//
//  NSObject+Category.m
//  PARockPay
//
//  Created by Chen Jacky on 12-12-3.
//  Copyright (c) 2012年 xyh. All rights reserved.
//
#import "regex.h"//正则表达式
#import "NSObject+Category.h"

@implementation NSObject (Category)

- (UIView *)newView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)newViewWithBackgroundColor:(UIColor *)backgroundColor {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    if (backgroundColor) {
        view.backgroundColor = backgroundColor;
    } else {
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}

- (UIView *)newViewWithFrame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//生成uilable对象
- (UILabel *)newLabelWithText:(NSString*)text
						frame:(CGRect)frame
						 font:(UIFont *)font
					textColor:(UIColor *)textColor
{
	
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = [UIColor clearColor];
	if (text != nil) {
		label.text = text;
	}
	
	if (font != nil) {
		label.font = font;
	}
	
	if (textColor != nil) {
		label.textColor = textColor;
	}
	
	return label;
}

- (UILabel *)newLabelWithText:(NSString*)text
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                textAlignment:(NSTextAlignment)textAlignment {
    
    return [self newLabelWithText:text
                        textColor:textColor
                         textFont:textFont
                    textAlignment:textAlignment
                    numberOfLines:1];
}

- (UILabel *)newLabelWithTextColor:(UIColor *)textColor
                          textFont:(UIFont *)textFont
                     textAlignment:(NSTextAlignment)textAlignment {
 
    return [self newLabelWithText:nil
                        textColor:textColor
                         textFont:textFont
                    textAlignment:textAlignment
                    numberOfLines:1];
}


- (UILabel *)newLabelWithText:(NSString*)text
                    textColor:(UIColor *)textColor
                     textFont:(UIFont *)textFont
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFont;
    label.numberOfLines = numberOfLines;

    return label;
}

- (UIButton *)newButtonWithBackgroundImage:(UIImage *)backgroundImage
                highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
                                     title:(NSString *)title
                                titleColor:(UIColor *)titleColor
                     highlightedTitleColor:(UIColor *)highlightedTitleColor
                                    target:(id)target
                                    action:(SEL)action {
    
    return [self newButtonWithBackgroundImage:backgroundImage
                   highlightedBackgroundImage:highlightedBackgroundImage
                                        image:nil
                             highlightedImage:nil
                                        title:title
                                   titleColor:titleColor
                        highlightedTitleColor:highlightedTitleColor
                                       target:target action:action];
}

- (UIButton *)newButtonWithBackgroundImage:(UIImage *)backgroundImage
                highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
                                     image:(UIImage *)image
                          highlightedImage:(UIImage *)highlightedImage
                                     title:(NSString *)title
                                titleColor:(UIColor *)titleColor
                     highlightedTitleColor:(UIColor *)highlightedTitleColor
                                    target:(id)target
                                    action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.backgroundColor = [UIColor clearColor];
    if (backgroundImage) {
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (highlightedBackgroundImage) {
        [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (highlightedTitleColor) {
        [button setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    [button setTitle:title forState:UIControlStateNormal];

    return button;
}

//生成uibutton对象
- (UIButton *)newButtonWithImage:(UIImage *)image
                highlightedImage:(UIImage *)highlightedImage
						   frame:(CGRect)frame
						   title:(NSString *)title
					  titleColor:(UIColor *)titleColor
				titleShadowColor:(UIColor *)titleShadowColor
							font:(UIFont *)font
						  target:(id)target
                          action:(SEL)action
{
    return [self newButtonWithImage:image
                   highlightedImage:highlightedImage
                              frame:frame
                              title:title
                         titleColor:titleColor
                   titleShadowColor:titleShadowColor
                               font:font
                             target:target
                             action:action
                       shodowOffset:CGSizeMake(0, 0)];
}

- (UIButton *)newButtonWithImage:(UIImage *)image
				highlightedImage:(UIImage *)highlightedImage
						   frame:(CGRect)frame
						   title:(NSString *)title
					  titleColor:(UIColor *)titleColor
				titleShadowColor:(UIColor *)titleShadowColor
							font:(UIFont *)font
						  target:(id)target
                          action:(SEL)action
                    shodowOffset:(CGSize)size
{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	
	if (image != nil) {
		[button setBackgroundImage:image forState:UIControlStateNormal];
	}
	
	if (highlightedImage != nil) {
		[button	setBackgroundImage:highlightedImage  forState:UIControlStateHighlighted];
	}
	button.frame = frame;
	
	if (title != nil) {
		[button setTitle:title forState:UIControlStateNormal];
	}
	
	if (titleColor != nil) {
		[button setTitleColor:titleColor forState:UIControlStateNormal];
	}
	
	if (titleShadowColor != nil) {
		[button setTitleShadowColor:titleShadowColor forState:UIControlStateNormal];
        [button.titleLabel setShadowColor:titleShadowColor];
	}
	
	if (font != nil) {
		button.titleLabel.font = font;
	}
    [button.titleLabel setShadowOffset:size];
    
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

- (UIImageView *)newImageView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    return imageView;
}

- (UIImageView *)newImageViewWithImage:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    return imageView;
}

- (UIImageView *)newImageViewWithImage:(UIImage *)image frame:(CGRect)frame {
	
	UIImageView *imageView =[[UIImageView alloc] initWithImage:image];
	imageView.frame = frame;
	
	return imageView;
}

- (UITextField *)newTextFieldWithTextColor:(UIColor *)textColor
                                  textFont:(UIFont *)textFont
                                  delegate:(id<UITextFieldDelegate>)delegate
                               placeholder:(NSString *)placeholder {

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder = placeholder;
    textField.font = textFont;
    textField.textColor = textColor;
    
    return textField;
}

- (UITextField *)newTextFieldWithTextColor:(UIColor *)textColor
                                  textFont:(UIFont *)textFont
                                  delegate:(id<UITextFieldDelegate>)delegate
                     attributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor clearColor];
    textField.attributedPlaceholder = attributedPlaceholder;
    textField.font = textFont;
    textField.textColor = textColor;
    
    return textField;
}

- (UITextView *)newTextViewWithTextColor:(UIColor *)textColor
                                textFont:(UIFont *)textFont
                                delegate:(id<UITextViewDelegate>)delegate {

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = textFont;
    textView.textColor = textColor;
    textView.delegate = delegate;
    
    return textView;
}

- (UITableView *)newTableViewWithFrame:(CGRect)frame
								 style:(UITableViewStyle)style
					   backgroundColor:(UIColor *)backgroundColor
							  delegate:(id)delegate
							dataSource:(id)dataSource
						separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
	
	UITableView *tableView = [[UITableView alloc]
                              initWithFrame:frame
                              style:style];
	
	if (backgroundColor != nil) {
		[tableView setBackgroundColor:backgroundColor];
	}
	
	[tableView setDelegate:delegate];
	[tableView setDataSource:dataSource];
	[tableView setSeparatorStyle:separatorStyle];
    
	return tableView;
	
}

- (UITableView *)newTableViewDelegate:(id)delegate
                           dataSource:(id)dataSource
                       separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                       separatorColor:(UIColor *)separatorColor {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = separatorStyle;
    tableView.separatorColor = separatorColor;
    tableView.separatorInset = UIEdgeInsetsZero;
    
    return tableView;
}

- (UIScrollView *)newScrollViewWithFrame:(CGRect)frame
							 contentSize:(CGSize)contentSize
						 backgroundColor:(UIColor *)backgroundColor
								delegate:(id)delegate
						   pagingEnabled:(BOOL)pagingEnabled {
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
	if (backgroundColor != nil) {
		[scrollView  setBackgroundColor:backgroundColor];
	}
	[scrollView  setDelegate:delegate];
    scrollView.contentSize = contentSize;
	scrollView.pagingEnabled = pagingEnabled;
	
	return scrollView;
}

#pragma mark -
//正则表达式，比较函数
-(BOOL)regExpMatch:(NSString *)string
	   withPattern:(NSString*)pattern
{
    regex_t reg;
    regmatch_t sub[10];
    int status=regcomp(&reg, [pattern UTF8String], REG_EXTENDED);
    if(status)return NO;
    status=regexec(&reg, [string UTF8String], 10, sub, 0);
    regfree(&reg);
    if(status==REG_NOMATCH)return NO;
    else if(status)return NO;
    return YES;
}

//验证email格式地址
-(BOOL)isValidEmail:(NSString *)email
{
	if (!email) {
		return NO;
	}
	else {
		NSString *pattern = @"^[a-z0-9A-Z._%-]+@[a-z0-9A-Z._%-]+\\.[a-zA-Z]{2,4}$";
		if ([self regExpMatch:email withPattern:pattern]) {
			return YES;
		}
	}
	return NO;
}

-(BOOL)isValidAddressBookPhone:(NSString *)phoneNumber
{
    if (!phoneNumber || phoneNumber.length == 0)
    {
        return NO;
    }
    else
    {
        NSString *pattern = @"^[1|+86 1|+86 1|+861]+([3|4|5|7|8][0-9])+([0-9]{8}|(-[0-9]{4}-[0-9]{4}))$";
        if ([self regExpMatch:phoneNumber withPattern:pattern]) {
            return YES;
        }
    }
    return NO;
}

//手机号码验证，现在只检查是数字
//根据具体业务需求来修改
-(BOOL)isValidMobileNumber:(NSString *)number
{
	if (!number || number.length == 0 || number.length!=11)
    {
		return NO;
	}
	else
    {
        NSString *pattern = @"^[1]+(([3|5][0-9])|([4][0-9])|([8][0-9])|([7][0-9]))+[0-9]{8}$";//(7)|
        if ([self regExpMatch:number withPattern:pattern]) {
			return YES;
		}
	}
    return NO;
}

// 检查输入数据是否为金额要求数据　要求带2位小数
-(bool)doCheckInputAmount:(UITextField *)textField Range:(NSRange)range replacementString:(NSString *)string
{
    NSString* textFieldtext = textField.text;
    NSInteger length_f = [textFieldtext length];
    
    // 屏蔽拷贝黏贴
    if([string length]>1)
        return FALSE;
    
    if ([textFieldtext length]>=16 && ![string isEqualToString:@""] )
    {
        return FALSE;
    }
    
    // 删除
    if( [string isEqualToString:@""] )
    {
       if(range.location<length_f-1 && length_f>=2)      // 光标在中间的删除
       {
           // 先去掉删除的字符
           NSMutableString* show_f = [[NSMutableString alloc] initWithCapacity:3];
           [show_f appendString:[textFieldtext substringToIndex:range.location]];
           [show_f appendString:[textFieldtext substringFromIndex:range.location+1]];
           if([show_f characterAtIndex:0]=='.')
           {
               [show_f insertString:@"0" atIndex:0];
               textField.text = show_f;
               //
               NSRange selectRange_f = NSMakeRange([show_f length],0);
               UITextPosition* beginning = textField.beginningOfDocument;
               UITextPosition* startPosition = [textField positionFromPosition:beginning offset:selectRange_f.location];
               UITextPosition* endPosition = [textField positionFromPosition:beginning offset:selectRange_f.location + selectRange_f.length];
               UITextRange* selectionRange = [textField textRangeFromPosition:startPosition toPosition:endPosition];
               [textField setSelectedTextRange:selectionRange];
               return FALSE;
           }
           else if([show_f characterAtIndex:0]=='0')
           {
               // 去掉前面所有的0
               NSMutableString* delete_f = [[NSMutableString alloc] initWithCapacity:3];
               int startIndex_f = 0;
               for(int i=0;i<[show_f length];i++)
               {
                   if([show_f characterAtIndex:i]!='0')
                   {
                       break;
                   }
                   startIndex_f ++;
               }
               [delete_f appendString:[show_f substringFromIndex:startIndex_f]];
               if(delete_f && [delete_f length] > 0 && [delete_f characterAtIndex:0]=='.')
               {
                   [delete_f insertString:@"0" atIndex:0];
               }
               [textField setText:delete_f];
               return FALSE;
           }
           
       }
       return TRUE;
    }
    
    unichar curChar_f = '&';
    if([string length]>0)
    {
        curChar_f = [string characterAtIndex:0];
    }
    
    // 判断输入字符[是否合格]
    if( (curChar_f>='0'&&curChar_f<='9') || (curChar_f=='.') )
    {
        // NSLog(@"Rang:%ld,%ld",range.location,range.length);
        if(length_f>0 && range.location<length_f-1)
        {
            // 光标在最前面
            if(range.location==0)
            {
                // .的前面只可以添加0
                if(curChar_f=='0'&&[textFieldtext characterAtIndex:range.location]!='.')
                {
                    return FALSE;
                }
                else if( curChar_f=='.')        // 最前面不能输入点
                {
                    // .不能重复
                    return FALSE;
                }
            }
            else            // 光标在中间
            {
                // 判断点的位置
                NSRange domRang_f = [textFieldtext rangeOfString:@"."];
                // NSLog(@"DomRang:%ld,%ld",domRang_f.location,domRang_f.length);
                if(curChar_f=='.')      // 当前输入的是.
                {
                    if(domRang_f.length>0 && range.location>domRang_f.location )  // 有小数点&光标在小数点后
                    {
                        return FALSE;
                    }
                    else            // 可以去掉小数点，并在中间插入.
                    {
                        NSString* text_f = [textFieldtext stringByReplacingOccurrencesOfString:@"."
                                                                                    withString:@""];
                        NSMutableString* show_f = [[NSMutableString alloc] initWithCapacity:3];
                        [show_f appendString:[text_f substringToIndex:range.location]];
                        [show_f appendString:@"."];
                        if(text_f.length-range.location>2)
                        {
                            [show_f appendString:[text_f substringWithRange:NSMakeRange(range.location,2)]];
                        }
                        else
                        {
                            [show_f appendString:[text_f substringFromIndex:range.location]];
                        }
                        [textField setText:show_f];
                        return FALSE;
                    }
                }
                
                //
                if(domRang_f.length>0)  // 有小数点
                {
                    if(range.location>domRang_f.location && length_f-domRang_f.location>=3)
                    {
                        // 光标在小数点后
                        return FALSE;
                    }
                    else if(range.location<=domRang_f.location) // 光标在小数点前面
                    {
                        //
                        unichar firstChar_f = [textFieldtext characterAtIndex:0];
                        if(firstChar_f=='0'&&range.location==1)
                        {
                            if(curChar_f=='0')      // 0后面不能在输入0
                            {
                                return FALSE;
                            }
                            else
                            {
                                // 需要把前面的0去掉
                                NSString* show_f = [NSString stringWithFormat:@"%d%@",curChar_f-'0',[textFieldtext substringFromIndex:1]];
                                [textField setText:show_f];
                                return FALSE;
                            }
                        }
                    }
                }
            }
            return TRUE;
        }

        // 光标在最后
        if( curChar_f=='.' )
        {
            if(length_f==0)			//	首字节不能为.
                return FALSE;
            if( [textFieldtext rangeOfString:@"."].length>0 )	// .不能重复
                return FALSE;
        }
        if(length_f>0)
        {
            if( [textFieldtext characterAtIndex:0]=='0' )		// 如果首输入为0，第二必须为.
            {
                if( curChar_f!='.' && length_f==1 )
                {
                    // 需要把前面的0去掉
                    NSString* show_f = [NSString stringWithFormat:@"%d",curChar_f-'0'];
                    [textField setText:show_f];
                    return FALSE;
                }
            }
        }
        
        if( length_f>=3 )
        {
            // 小数点后2位不能在输入
            if( [textFieldtext characterAtIndex:length_f-3]=='.' )
                return FALSE;
        }
        return TRUE;
    }
    
    return FALSE;
}

/* 获取app document path */
+(NSString*)getSortDcumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(NSString*)getFormatDateString:(NSString*)dateString
{
    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    if([array count]==3)
    {
        NSString *secondString = array[2];
        NSArray *timeArray = [secondString componentsSeparatedByString:@":"];
        if([timeArray count]==3)
        {
            return [NSString stringWithFormat:@"%@-%@:%@",array[1],timeArray[0],timeArray[1]];
        }
    }
    return dateString?:@"";
}

/**
 * 功能：姓名处理 ，姓名部分信息需要屏蔽，具体规则如下：
 姓名（三个字的姓名中间的用*号隐去，二个字的姓名显示*客户名字，三个字以上的姓名显示前后两个字，手机号特殊处理
*/
-(NSString *)editWithName:(NSString *)name
{
	if ([name length] == 0 || [name length] == 1) {
		return name;
	}
	
    //
    NSString *nameR = @"";
    BOOL isPhone_f = [self isValidMobileNumber:name];
    if(isPhone_f)           // 手机号取前3后4位
    {
        nameR = [NSString stringWithFormat:@"%@****%@",[name substringToIndex:3],
                               [name substringFromIndex:name.length-4]];
    }
    else
    {
        if ([name length] == 2)
        {
            nameR = [NSString stringWithFormat:@"%@****",[name substringToIndex:1]];
        }
        else if ([name length] == 3)
        {
            nameR = [name stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }
        else if([name length] >3)
        {
            nameR = [NSString stringWithFormat:@"%@****%@",[name substringToIndex:1],
                     [name substringFromIndex:name.length-2]];
        }
    }
	return nameR;
}

// 通过身份证最后一位校验码，判断是否正确有效。只对18位身份证号码校验。
- (BOOL)isValidIDNumber:(NSString *)_idNum
{
	
	if ([_idNum length] != 15 && [_idNum length] != 18) {
		return NO;
	}
	
	//验证身份证号码出身月日
	NSString *m = @"";
	NSString *d = @"";
	
	if ([_idNum length] == 15) {
		m = [_idNum substringWithRange:NSMakeRange(8, 2)];
		d = [_idNum substringWithRange:NSMakeRange(10, 2)];
	}else {
		m = [_idNum substringWithRange:NSMakeRange(10, 2)];
		d = [_idNum substringWithRange:NSMakeRange(12, 2)];
	}
	
	if ([m intValue]>12||[d intValue]>31) {
		return NO;
	}
	
	//如果是15位身份证号码，不进行下面算法的验证
	if ([_idNum length] == 15) {
		return YES;
	}
	
	//加权因子 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
	int w[17] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
	int sum = 0;
	for (int i = 0; i < 17; i++) {
		int a =  [_idNum characterAtIndex:i] - '0';
		sum += a * w[i];
	}
	int mod = sum % 11;
	
	BOOL isValid = NO;
	unichar lastC = [_idNum characterAtIndex:17];
	//mod: 0 1 2 3 4 5 6 7 8 9 10
	//校验码: 1 0 X 9 8 7 6 5 4 3 2
	switch (mod) {
		case 0:
			isValid = (lastC == '1');
			break;
		case 1:
			isValid = (lastC == '0');
			break;
		case 2:
			isValid = (lastC == 'X');
			if (!isValid) {
				isValid = (lastC == 'x');
			}
			break;
		case 3:
			isValid = (lastC == '9');
			break;
		case 4:
			isValid = (lastC == '8');
			break;
		case 5:
			isValid = (lastC == '7');
			break;
		case 6:
			isValid = (lastC == '6');
			break;
		case 7:
			isValid = (lastC == '5');
			break;
		case 8:
			isValid = (lastC == '4');
			break;
		case 9:
			isValid = (lastC == '3');
			break;
		case 10:
			isValid = (lastC == '2');
			break;
		default:
			break;
	}
	return isValid;
}

/**
 *功能:根据秒数获取显示字符
 */
+ (NSString *)getHintTime:(NSTimeInterval)seconds
{
    if( seconds<0.0 )
    {
        return @"";
    }
    
    //
    NSMutableString* result_f = [[NSMutableString alloc] initWithCapacity:5];
    if( seconds>86400 )                     // 天
    {
        int day_f = seconds/86400;
        [result_f appendFormat:@"%d天",day_f];
        seconds = seconds-day_f*86400;
    }
    
    if( seconds>3600 )                 // 小时
    {
        int hour_f = seconds/3600;
        if(hour_f<=9 && [result_f rangeOfString:@"天"].length>0)
        {
            [result_f appendFormat:@"0%d时",hour_f];//小时
        }
        else
        {
            [result_f appendFormat:@"%d时",hour_f];
        }
        seconds = seconds-hour_f*3600;
    }
    else if([result_f rangeOfString:@"天"].length>0)
    {
        [result_f appendString:@"00时"];
    }
    
    if( seconds>60 )                   // 分钟
    {
        int minute_f = seconds/60;
        if(minute_f<=9 && [result_f rangeOfString:@"时"].length>0)
        {
            [result_f appendFormat:@"0%d分",minute_f];
        }
        else
        {
            [result_f appendFormat:@"%d分",minute_f];
        }
        seconds = seconds-minute_f*60;
    }
    else if([result_f rangeOfString:@"时"].length>0)
    {
        [result_f appendString:@"00分"];
    }
    
    if(seconds>=0)
    {
        NSInteger secondsTime = seconds;
        if(secondsTime<=9.0 && [result_f rangeOfString:@"分"].length>0)
        {
            [result_f appendFormat:@"0%d秒",secondsTime];
        }
        else
        {
            [result_f appendFormat:@"%d秒",secondsTime];
        }
    }
    
    return result_f;
}

+(NSString*)handleAmountString:(double)amount
{
    //
    NSString* show_f = [NSString stringWithFormat:@"%.2f",amount];
    if([show_f rangeOfString:@","].length>0)
        return show_f;
    
    //
    NSMutableString* str_f = [[NSMutableString alloc] initWithCapacity:5];
    NSArray* splitArray_f = [show_f componentsSeparatedByString:@"."];
    if([splitArray_f count]==2)
    {
        NSString* befStr_f = [splitArray_f objectAtIndex:0];
        NSString* aftStr_f = [splitArray_f objectAtIndex:1];
        [str_f appendFormat:@".%@",aftStr_f];
        NSInteger length_f = [befStr_f length];
        for(NSInteger i=length_f-1;i>=0;)
        {
            if(i-3>0)
            {
                NSString* temp_f = [NSString stringWithFormat:@",%@",[befStr_f substringWithRange:NSMakeRange(i-3,3)]];
                [str_f insertString:temp_f atIndex:0];
                i=i-3;
            }
            else
            {
                NSString* temp_f = [NSString stringWithFormat:@"%@",[befStr_f substringWithRange:NSMakeRange(0,i)]];
                [str_f insertString:temp_f atIndex:0];
                i=-1;
            }
        }
    }
    return str_f;
}

//根据key值得到字符串，如为空则返回@“”
- (id)getStringByKey:(NSString*)key
{
    return @"";
}

//-(CGSize)sizeWithAttributes:(NSDictionary*)attrs
//{
//    CGSize strSize_f = CGSizeMake(0,0);
//    if([self isKindOfClass:[NSString class]])
//    {
//        UIFont* font = [attrs objectForKey:NSFontAttributeName];
//        if(font)
//        {
//            strSize_f = [(NSString*)self sizeWithFont:font];
//        }
//        else
//        {
//            strSize_f = [(NSString*)self sizeWithFont:[UIFont systemFontOfSize:16.0]];
//        }
//    }
//    return strSize_f;
//}

+(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(CGSize)getStringSizeByFont:(UIFont*)font String:(NSString*)text
{
    CGSize strSize_f = CGSizeMake(0,0);
    
    if( [text length]==0 )
        return strSize_f;
    
//    if([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)
//    {
        strSize_f = [text sizeWithAttributes:@{NSFontAttributeName:font}];
//    }
//    else
//    {
//        strSize_f = [text sizeWithFont:font];
//    }
    return strSize_f;
}

+(void)clearAllCookies
{
    NSArray* cookies_f = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for(NSHTTPCookie *cookie in cookies_f)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

+(void)deleteCookieWithName:(NSString *)name
{
    NSArray* cookies_f = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for(NSHTTPCookie *cookie in cookies_f)
    {
        if( [cookie.name isEqualToString:name] )
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

/*
 *  摇动
 */
-(void)shakeWithView:(UIView *)view
{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    kfa.values = @[@(-4),@(-10),@(-s),@(0),@(4),@(10),@(s),@(0)];
    
    //时长
    kfa.duration = .2f;
    
    //重复
    kfa.repeatCount = 3;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [view.layer addAnimation:kfa forKey:@"shake"];
}

@end

#pragma ===============================
@implementation NSNull (NullCast)

-(float)floatValue
{
    return 0.0;
}

-(int)intValue
{
    return 0;
}

-(NSInteger)integerValue
{
    return 0;
}

-(BOOL)boolValue
{
    return FALSE;
}

-(double)doubleValue
{
    return 0.0;
}
@end
