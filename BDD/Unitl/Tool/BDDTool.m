//
//  BDDTool.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDTool.h"
#import "NSDate+Utils.h"
#import <LEEAlert.h>

@implementation BDDTool

////  根据文字的长度、字体  来计算size
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font {
    return [BDDTool sizeOfstring:string font:font maxW:MAXFLOAT];
}
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font maxW:(CGFloat)maxW{
    return [BDDTool sizeOfstring:string font:font maxW:maxW maxH:MAXFLOAT]; //MAXFLOAT表示随便算
}
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH{
    NSDictionary * dic=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height {
    return [BDDTool sizeOfstring:string font:font maxW:CGFLOAT_MAX maxH:height].width;
}

+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    return [BDDTool sizeOfstring:string font:font maxW:width maxH:CGFLOAT_MAX].height;
}

/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 时间转换 -----------------------

/// 获取当前时间戳
+ (NSString *)currentTimeStampStr{
    NSDate* date = [NSDate date];//获取当前时间
    NSTimeInterval time =[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
/// 时间字符串(yyyy-MM-dd HH:mm) -> 时间戳字符串(毫秒）
+ (NSString *)timeStampFromYYYYMMDDHHMMTimeStr:(NSString *)timeStr {
    return [self timeStampStrFromTimeStr:timeStr dateFormatter:@"yyyy-MM-dd HH:mm"];
}
/// 时间字符串(yyyy-MM-dd HH:mm:ss) -> 时间戳字符串(毫秒）
+ (NSString *)timeStampFromYYYYMMDDHHMMSSTimeStr:(NSString *)timeStr {
    return [self timeStampStrFromTimeStr:timeStr dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}
/// 时间字符串（dateFormatter) -> 时间戳字符串
+ (NSString *)timeStampStrFromTimeStr:(NSString *)timeStr dateFormatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    NSTimeInterval time =[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
/// 时间戳 -> h小时前/m分钟前,超过24小时显示年月日
+ (NSString *)getRecentTimeWithTimeStampStr:(NSString *)timeStampStr {
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeStampStr.longLongValue/1000];
    NSString *localTime = [self getTimeStrFromTimeStamp:timeStampStr.longLongValue dateFormatter:@"yyyy-MM-dd"];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:pubDate];
    NSInteger hour = timeInterval/(60*60);
    NSInteger minute = (timeInterval - hour*60*60)/60;
    //    NSInteger second = timeInterval - hour*60*60 - minute*60;
    NSString *displayStr = nil;
    if (hour > 24) {
        displayStr = localTime;
    } else if (hour != 0) {
        displayStr = [NSString stringWithFormat:@"%ld小时前", hour];
    } else if (minute != 0) {
        displayStr = [NSString stringWithFormat:@"%ld分钟前", minute];
    } else {
        displayStr = @"刚刚";
    }
    
    return displayStr;
}

/// 时间戳 -> h小时前/m分钟前,超过24小时显示月日，超过当年显示年月日
+ (NSString *)getRecentTimeMMDDHHWithTimeStampStr:(NSString *)timeStampStr {
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeStampStr.longLongValue/1000];
    NSDateComponents *otherYear = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:pubDate];
    NSDateComponents *toYear = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:[NSDate date]];
    NSString *localTime = nil;
    if([toYear year] == [otherYear year] ) {
        localTime = [self getTimeStrFromTimeStamp:timeStampStr.longLongValue dateFormatter:@"MM-dd"];
    }else{
        localTime = [self getTimeStrFromTimeStamp:timeStampStr.longLongValue dateFormatter:@"yyyy-MM-dd"];
    }
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:pubDate];
    NSInteger hour = timeInterval/(60*60);
    NSInteger minute = (timeInterval - hour*60*60)/60;
    //    NSInteger second = timeInterval - hour*60*60 - minute*60;
    NSString *displayStr = nil;
    if (hour > 24) {
        displayStr = localTime;
    } else if (hour != 0) {
        displayStr = [NSString stringWithFormat:@"%ld小时前", hour];
    } else if (minute != 0) {
        displayStr = [NSString stringWithFormat:@"%ld分钟前", minute];
    } else {
        displayStr = @"刚刚";
    }
    
    return displayStr;
}
/// 时间戳 -> s秒/m分钟/h小时/d天/m月/y年前
+ (NSString *)getRecentSMHDMYTimeWithTimeStampStr:(NSString *)timeStampStr {
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:timeStampStr.longLongValue/1000];
    //    NSString *localTime = [self getYYYYMMDDHHMMTimeStrWithStampStr:timeStampStr];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:pubDate];
    
    NSInteger year = timeInterval/(365 * 24 * 3600);
    NSInteger month = timeInterval/(30 * 24 * 3600);
    NSInteger day = timeInterval/(24 * 3600);
    NSInteger hour = timeInterval/(3600);
    NSInteger minute = timeInterval/60;
    NSInteger second = timeInterval;
    
    NSString *displayStr = nil;
    if (year > 0) {
        displayStr = [NSString stringWithFormat:@"%ld年前", year];
    } else if (month > 0) {
        displayStr = [NSString stringWithFormat:@"%ld月前", month];
    } else if (day > 0) {
        displayStr = [NSString stringWithFormat:@"%ld天前", day];
    } else if (hour > 0) {
        displayStr = [NSString stringWithFormat:@"%ld小时前", hour];
    } else if (minute > 0) {
        displayStr = [NSString stringWithFormat:@"%ld分钟前", minute];
    } else if (second > 0) {
        displayStr = [NSString stringWithFormat:@"%ld秒前", second];
    } else {
        displayStr = @"刚刚";
    }
    
    return displayStr;
}
/// 时间戳 -> yyyy-MM-dd HH:mm时间字符串
+ (NSString *)getYYYYMMDDHHMMTimeStrWithStampStr:(NSString *)dateStampStr {
    return [self getTimeStrFromTimeStamp:dateStampStr.longLongValue dateFormatter:@"yyyy-MM-dd HH:mm"];
}

/// 时间戳 -> yyyy-MM-dd HH:mm:ss时间字符串
+ (NSString *)getYYYYMMDDHHMMSSTimeStrWithStamp:(NSNumber *)dateStamp {
    return [self getTimeStrFromTimeStamp:dateStamp.longLongValue dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

/// 时间戳 -> 09.12样式
+ (NSString *)getMMDDTimeWithStamp:(NSNumber *)timeStamp {
    return [self getTimeStrFromTimeStamp:timeStamp.longLongValue dateFormatter:@"MM.dd"];
    
}
/// 时间戳 -> 03-12 12:12样式
+ (NSString *)getMMDDHHMMTimeWithStamp:(NSNumber *)timeStamp {
    return [self getTimeStrFromTimeStamp:timeStamp.longLongValue dateFormatter:@"MM-dd HH:mm"];
}

/// 时间戳 -> dateFormat 样式(yyyy-MM-dd HH:mm:ss)
+ (NSString *)getTimeStrFromTimeStamp:(NSInteger)timeStamp dateFormatter:(NSString *)dateFormat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    return [self getTimeStrFromDate:date dateFormatter:dateFormat];
}

/// 时间date -> dateFormat 样式(yyyy-MM-dd HH:mm:ss)
+ (NSString *)getTimeStrFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = dateFormat;
    return [dateformatter stringFromDate:date];
}

/// 年月日时分 -> 年月日时分秒
+ (NSString *)HHMMTimeStrToHHMMSSTimeStr:(NSString *)HHMMTimeStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:HHMMTimeStr];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
/// 时间戳 -> d天h小时后、h小时m分钟后、m分钟s秒、s秒后
+ (NSString *)getSurplusTimeStringWithTimeStamp:(NSInteger)timeStamp {
    NSTimeInterval timeInterval = [self getIntervalTimeBeforeTimeStamp:timeStamp];
    return [self getSurplusTimeStringWithInterval:timeInterval];
}
/// 以后的时间(时间戳）与当前时间相差多少秒(如果是以后的时间，返回的时间差为正值；如果是过去的时间返回的时间差为负值）
+ (NSTimeInterval)getIntervalTimeBeforeTimeStamp:(NSInteger)timeStamp {
    return [[NSDate dateWithTimeIntervalSince1970:(timeStamp/1000)] timeIntervalSinceDate:[NSDate date]];
}
/// 时间差(s) -> d天h小时后、h小时m分钟后、m分钟s秒、s秒后
+ (NSString *)getSurplusTimeStringWithInterval:(NSTimeInterval)timeInterval {
    NSInteger day = timeInterval/(24*60*60);
    NSInteger hour = (timeInterval - day*24*60*60)/(60*60);
    NSInteger minute = (timeInterval - day*24*60*60 - hour*60*60)/60;
    NSInteger second = timeInterval - day*24*60*60 - hour*60*60 - minute*60;
    NSString *displayStr = nil;
    if (day != 0) {
        displayStr = [NSString stringWithFormat:@"%ld天%ld小时后", day, hour];
    } else if (hour != 0) {
        displayStr = [NSString stringWithFormat:@"%ld小时%ld分钟后", hour, minute];
    } else if (minute != 0) {
        displayStr = [NSString stringWithFormat:@"%ld分钟%ld秒后", minute, second];
    } else if (second != 0) {
        displayStr = [NSString stringWithFormat:@"%ld秒后", second];
    } else {
        displayStr = @"";
    }
    
    return displayStr;
}
//"08-10 晚上08:09:41.0" ->
//"昨天 上午10:09"或者"2012-08-10 凌晨07:09"
+ (NSString *)changeTheDate:(NSDate *)lastDate {
    //    NSString *subString = [Str substringWithRange:NSMakeRange(0, 19)];
    //    NSDate *lastDate = [NSDate dateFromString:subString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:lastDate];
    //    lastDate = [lastDate dateByAddingTimeInterval:interval];
    
    NSString *dateStr;  //年月日
    //    NSString *period;   //时间段
    //    NSString *hour;     //时
    
    if ([lastDate year]==[[NSDate date] year]) {
        //        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        //        if (days > 2) {
        dateStr = [lastDate stringYearMonthDayCompareToday];
        //        }else{
        //            dateStr = [lastDate stringMonthDay];
        //        }
        
        NSInteger chaDay = [lastDate daysBetweenCurrentDateAndDate];
        if (chaDay == 0) {
            dateStr = @"今天";
        }else if (chaDay == 1){
            dateStr = @"明天";
        }else if (chaDay == -1){
            dateStr = @"昨天";
        } else {
            dateStr = [lastDate stringMonthDay];
        }
    }else{
        dateStr = [lastDate stringYearMonthDay];
    }
    
    
    //    if ([lastDate hour]>=5 && [lastDate hour]<12) {
    //        //        period = @"AM";
    //        period = @"上午";
    //        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    //    }else if ([lastDate hour]>=12 && [lastDate hour]<=18){
    //        //        period = @"PM";
    //        period = @"下午";
    //        int hourTmp = (int)[lastDate hour]-12;
    //        hour = [NSString stringWithFormat:@"%02d",hourTmp == 0 ? 12 : hourTmp];
    //    }else if ([lastDate hour]>18 && [lastDate hour]<=23){
    //        //        period = @"Night";
    //        period = @"晚上";
    //        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    //    } else {
    //        //        period = @"Dawn";
    //        period = @"凌晨";
    //        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    //    }
    //    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
    return [NSString stringWithFormat:@"%@ %02ld:%02d",dateStr,(long)[lastDate hour],(int)[lastDate minute]];
}

/// 根据生日（时间戳）获取年龄
+ (NSInteger)getAgeByBirthdayStamp:(NSInteger)birthdayStamp {
    if (!birthdayStamp) {
        return 0;
    }
    // 生日
    NSString *dateStr = [self getTimeStrFromTimeStamp:birthdayStamp dateFormatter:@"yyyy/MM/dd"];
    NSString *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [dateStr substringWithRange:NSMakeRange(dateStr.length-2, 2)];
    // 现在的时间
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSDateComponents *compomemts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    NSInteger nowYear = compomemts.year;
    NSInteger nowMonth = compomemts.month;
    NSInteger nowDay = compomemts.day;
    // 计算年龄
    NSInteger userAge = nowYear - year.intValue - 1;
    if ((nowMonth > month.intValue) || (nowMonth == month.intValue && nowDay >= day.intValue)) {
        userAge++;
    }
    return userAge;
}

/// 根据时间戳（毫秒）获取NSDate
+ (NSDate *)getDateWithTimeStamp:(NSNumber *)timeStamp {
    NSNumber *num = timeStamp;
    NSTimeInterval seconds = num.doubleValue/1000;
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}


/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 字典<->JSON字符串 -----------------------

/// 字典转json字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"字典转json失败：%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

///json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 富文本字符串 -----------------------

+ (NSAttributedString *)titleAttributedStringWithString:(NSString *)string leftImageNames:(NSArray <NSString *> *)imageNames imageBounds:(CGRect)bounds font:(UIFont *)font fontColor:(UIColor *)fontColor {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;//行间距
    paragraphStyle.alignment = NSTextAlignmentLeft;//文本对齐方式 左右对齐（两边对齐）
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]
                                                initWithString:string attributes:@{
                                                    NSParagraphStyleAttributeName    : paragraphStyle,   //设置段落样式
                                                    //                                                                                   NSUnderlineStyleAttributeName   : [NSNumber numberWithInteger:NSUnderlineStyleNone],//这段话必须要添加，否则UIlabel两边对齐无效 NSUnderlineStyleAttributeName （设置下划线）
                                                    NSForegroundColorAttributeName   : fontColor,
                                                    NSFontAttributeName              : font,
                                                }];
    
    for (int i = 0; i < imageNames.count; i++) {
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        attach.image = [UIImage imageNamed:imageNames[i]];
        attach.bounds = bounds;
        //标签后添加空格
        if (i == 0) {
            [attributedStr insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:0];
        }
        [attributedStr insertAttributedString:imageStr atIndex:0];
    }
    //设置间距
    [attributedStr addAttribute:NSKernAttributeName value:@(0)
                          range:NSMakeRange(0, imageNames.count+1/*由于图片也会占用一个单位长度,所以带上空格数量，需要 +1 */)];
    
    return attributedStr;
}

/**
 *  设置UILable文字两端对齐，并且可以加载HTML数据
 *
 *  @param textStr     网络请求到的字符串
 *  @param textFont    字体大小
 *  @param textColor   字体颜色，如果是html字符串就使用html属性，否则就是用设置颜色
 *  @param lineSpacing 行间距，可为空
 *
 *  @return 两端对齐的带有html颜色属性的富文本字符串
 */
+(NSMutableAttributedString*)textAlignmentJustifyWithString:(NSString*)textStr textFont:(UIFont*)textFont textColor:(UIColor*)textColor lineSpacingStr:(NSString *)lineSpacing
{
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithData:[textStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (lineSpacing) {
        paragraphStyle.lineSpacing = lineSpacing.floatValue;//行间距 概览页标题6
    }
    paragraphStyle.alignment = NSTextAlignmentJustified;//文本对齐方式 左右对齐（两边对齐）
    
    //可变富文本字符串
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:attributedText];
    NSDictionary *attributedDic = @{
        NSParagraphStyleAttributeName   : paragraphStyle,   //设置段落样式
        NSForegroundColorAttributeName  : textColor,        //设置字体颜色
        NSFontAttributeName             : textFont,         //设置字体大小
        NSUnderlineStyleAttributeName   : [NSNumber numberWithInteger:NSUnderlineStyleNone]//这段话必须要添加，否则UIlabel两边对齐无效 NSUnderlineStyleAttributeName （设置下划线）
    };
    [attributedString addAttributes:attributedDic range:NSMakeRange(0, attributedString.length)];
    
    //如果text不含标签对,设置自定义的颜色，否则使用标签对的颜色
    if (textStr.length == attributedText.length) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, attributedString.length)];
    }
    return attributedString;
}

/** 超文本HTML格式转换为富文本AtrributeString格式 */
+ (NSAttributedString *)attributeStringByHtmlString:(NSString *)htmlString {
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *importParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
    };
    NSError *error = nil;
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
    return attributeString;
}

/** 富文本的size */
+ (CGSize)sizeOfAttributedString:(NSAttributedString*)attributedString width:(CGFloat)width {
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}


/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 其他常用工具 -----------------------

+ (NSString *)getEncryptedNumberByNumber:(NSString *)number {
    if (number.length < 11) {
        return number;
    } else {
        NSString *temp = number;
        for (int i = 0; i < temp.length - 7; i++) {
            temp = [temp stringByReplacingCharactersInRange:NSMakeRange(3 + i, 1) withString:@"*"];
        }
        return temp;
    }
}

/// url格式为：https://api.comapp.fun/userupload/activityimages/37/152679204456620180520125403.jpg828x1104.jpg
+ (CGRect)getBoundsWithImageUrlStr:(NSString *)url {
    // 图片类型
    NSString *imageType = [url componentsSeparatedByString:@"."].lastObject;
    NSArray *separatedArray = [url componentsSeparatedByString:[NSString stringWithFormat:@".%@", imageType]];
    if (separatedArray.count > 2) {// 保证格式正确
        NSString *WxH = separatedArray[separatedArray.count - 2];
        NSArray *width_Height = [WxH componentsSeparatedByString:@"x"];
        NSString *width = width_Height[0];
        NSString *height = width_Height[1];
        return CGRectMake(0, 0, width.floatValue, height.floatValue);
    } else {
        return CGRectZero;
    }
}

+ (void)locationAlertController {
    [LEEAlert alert].config.LeeTitle(@"提示")
    .LeeContent(@"无法获取位置，请打开定位获取位置")
    .LeeCancelAction(@"取消", ^{
        
    })
    .LeeAction(@"设置", ^{
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
            
        }
    })
    .LeeShow();
}
/**
 数量超过10000后显示为1.32万样式
 */
+ (NSString *)numForZanAndComment:(NSNumber *)number {
    long long num = number.longLongValue;
    NSString *returnStr = !num ? @"0" : number.stringValue;
    if (num > 9999) {
        returnStr = [NSString stringWithFormat:@"%0.2f万", (CGFloat)num/10000];
    }
    return returnStr;
}

/** 获取当前屏幕显示的视图控制器，如果最上层vc是模态弹出的，会获取到presentedVC */
+(UIViewController*)getCurrentVC {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [BDDTool findBestViewController:viewController isFindPresentedVC:YES];
}
/** 获取当前屏幕显示的视图控制器，不获取模态弹出的vc */
+ (UIViewController *)getCurrentVCWithoutPresentedVC {
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [BDDTool findBestViewController:viewController isFindPresentedVC:NO];
}

+(UIViewController*)findBestViewController:(UIViewController*)vc isFindPresentedVC:(BOOL)isFindPresentedVC {
    if (vc.presentedViewController && isFindPresentedVC) {
        // Return presented view controller
        return [BDDTool findBestViewController:vc.presentedViewController isFindPresentedVC:isFindPresentedVC];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0)
            return [BDDTool findBestViewController:svc.viewControllers.lastObject isFindPresentedVC:isFindPresentedVC];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0)
            return [BDDTool findBestViewController:svc.topViewController isFindPresentedVC:isFindPresentedVC];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*)vc;
        if (svc.viewControllers.count > 0)
            return [BDDTool findBestViewController:svc.selectedViewController isFindPresentedVC:isFindPresentedVC];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

//NS_REQUIRES_NIL_TERMINATION 以nil结束
//NS_FORMAT_FUNCTION(1,2) 可选可变参数 NS_FORMAT_FUNCTION(F,A):参数的第F位是格式化字符串，从A位开始我们开始检查
+ (NSDictionary *)_ZXDictionaryOfVariableBindings:(NSString *)firstArg, ... {
    // 取出第一个参数
    firstArg = [firstArg stringByReplacingOccurrencesOfString:@" " withString:@""];// 去除空格
    NSArray *keys = [firstArg componentsSeparatedByString:@","];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:keys.count];
    // 定义一个指向个数可变的参数列表指针
    va_list list;
    if (firstArg) {
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(list, firstArg);
        // 用于存放取出的参数,C语言的字符指针, 指针根据offset来指向需要的参数,从而读取参数
        id arg;
        for (NSString *key in keys) {
            // 遍历全部参数 va_arg返回可变的参数(va_arg的第二个参数是你要返回的参数的类型)
            arg = va_arg(list, id);
            if (!arg || [arg isKindOfClass:[NSNull class]]) {
                continue;
            }
            if ([arg isKindOfClass:[NSString class]]) {
                if ([[arg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0) {
                    [dic setObject:arg forKey:key];
                }
            } else {
                [dic setObject:arg forKey:key];
            }
        }
        // 清空参数列表，并置参数指针args无效
        va_end(list);
    }
    return dic;
}

/// 快速生成model
+ (void)nslogPropertyWithDic:(id)obj {
    
#if DEBUG
    NSDictionary *dic = [NSDictionary new];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = [(NSDictionary *)obj mutableCopy];
        dic = tempDic;
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *tempArr = [(NSArray *)obj mutableCopy];
        if (tempArr.count > 0) {
            dic = tempArr[0];
        } else {
            NSLog(@"无法解析为model属性，因为数组为空");
            return;
        }
    } else {
        NSLog(@"无法解析为model属性，因为并非数组或字典");
        return;
    }
    
    if (dic.count == 0) {
        NSLog(@"无法解析为model属性，因为该字典为空");
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *className = NSStringFromClass([obj class]) ;
        NSLog(@"className:%@  key:%@", className, key);
        if ([className isEqualToString:@"__NSCFString"] ||
            [className isEqualToString:@"__NSCFConstantString"] ||
            [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFArray"] ||
                 [className isEqualToString:@"__NSArray0"] ||
                 [className isEqualToString:@"__NSArrayI"] ||
                 [className isEqualToString:@"__NSSingleObjectArrayI"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSArray  *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFDictionary"] ||
                 [className isEqualToString:@"__NSDictionaryI"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSDictionary *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFNumber"] ||
                 [className isEqualToString:@"NSDecimalNumber"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }
        else if ([className isEqualToString:@"__NSCFBoolean"]) {
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }
        else if ([className isEqualToString:@"NSNull"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n", key];
        }
        else if ([className isEqualToString:@"__NSArrayM"]) {
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n", key];
        } else {
            [strM appendFormat:@"@property (nonatomic, strong) 未知类   *%@;\n", key];
        }
    }];
    NSLog(@"\n%@\n",strM);
    
#endif
}


/// 正则判断
+ (BOOL)judgeRegularWith:(NSString *)contentStr byType:(TextControlType)type{
    NSString *regularStr = @"";
    switch (type) {
        case TextControlType_none: {
            regularStr = @"";
        }
            break;
        case TextControlType_number: {
            regularStr = @"^[0-9]*$";
            
        }
            break;
        case TextControlType_letter: {
            regularStr = @"^[a-zA-Z]*$";
            
        }
            break;
        case TextControlType_letterSmall: {
            regularStr = @"^[a-z]*$";
            
        }
            break;
        case TextControlType_letterBig: {
            regularStr = @"^[A-Z]*$";
        }
            break;
        case TextControlType_number_letter: {
            regularStr = @"^[0-9a-zA-Z]*$";
        }
            break;
        case TextControlType_number_letterSmall: {
            regularStr = @"^[0-9a-z]*$";
        }
            break;
        case TextControlType_number_letterBig: {
            regularStr = @"^[0-9A-Z]*$";
        }
            break;
        case TextControlType_price: {
            NSString *tempStr = @"";
            regularStr = [NSString stringWithFormat:@"^(([1-9]\\d{0,%@})|0)(\\.\\d{0,2})?$", tempStr];
        }
            break;
            
        default:
            regularStr = @"";
            break;
    }
    return judgeRegularByStr(contentStr, regularStr);
}

inline BOOL judgeRegularByStr(NSString *contentStr, NSString *regularStr) {
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:regularStr options:0 error:&error];
    if (error) {
        return YES;
    }
    NSArray *results = [regex matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)];
    return results.count > 0;
}

// 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize
{
    CGFloat maxWidth = SCREEN_WIDTH - 150;
    CGFloat maxHeight = SCREEN_HEIGHT - 130;
    CGFloat width = singleSize.width;
    CGFloat height = singleSize.height;
    
    CGFloat outWidth = 0;
    CGFloat outHeight = 0;
    if (height / width > 3.0) { // 细长图
        outHeight = maxHeight;
        outWidth = outHeight / 2.0;
    } else  {
        outWidth = maxWidth;
        outHeight = maxWidth * height / width;
        if (outHeight > maxHeight) {
            outHeight = maxHeight;
            outWidth = maxHeight * width / height;
        }
    }
    return CGSizeMake(outWidth, outHeight);
}



/****************************************************************************/
#pragma mark - ---------------- 判断是否开启通知 -----------------------
/// 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable {
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    return (UIUserNotificationTypeNone == setting.types) ? NO : YES;
}

/// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        }
    } else {
        if ([application canOpenURL:url]) {
            [application openURL:url];
        }
    }
}

/****************************************************************************/
#pragma mark - ---------------- 获取沙盒路径 -----------------------
/// 根据文件类型获取沙盒缓存路径
+ (NSString *)getCachePathWithFileType:(NSString *)fileType {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,  NSUserDomainMask,YES);
    NSString *cachesPath =[cachesPaths objectAtIndex:0];
//    NSString *hostCachesPath = [NSString stringWithFormat:@"%@/%@/%@",cachesPath, MyUserID, fileType];
    NSString *hostCachesPath = [NSString stringWithFormat:@"%@/%@",cachesPath, fileType];

    
    if (![fileMgr fileExistsAtPath:hostCachesPath]) {
        NSError *err = nil;
        if (![fileMgr createDirectoryAtPath:hostCachesPath withIntermediateDirectories:YES attributes:nil error:&err]) {
            DLog(@"创建缓存路径失败: %@--type:%@", err, fileType);
            return nil;
        }
    }
    return hostCachesPath;
}

//+ (void)getCache:(void (^)(NSUInteger, NSString *))completeBlock {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        SDImageCache *imageCache = [SDImageCache sharedImageCache];
//        [imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
//            DLog(@"SD:getSize-totalSize:%ld", totalSize);
//            // 加上yy的缓存
//            YYImageCache *yyCache = [YYImageCache sharedCache];
//            /// caches缓存大小
//            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//            // 总缓存大小
//            totalSize = totalSize + yyCache.diskCache.totalCost + cachePath.zx_fileSize + [self getTmp_QNShortVideoCache];
//            
//            NSString *cacheSizeStr = @"0M";
//            if (totalSize >= pow(10, 9)) { // size >= 1GB
//                cacheSizeStr = [NSString stringWithFormat:@"%.2fG", totalSize / pow(10, 9)];
//            } else if (totalSize >= pow(10, 6)) { // 1GB > size >= 1MB
//                cacheSizeStr = [NSString stringWithFormat:@"%.2fM", totalSize / pow(10, 6)];
//            } else { // 1MB > size
//                cacheSizeStr = [NSString stringWithFormat:@"%.2fK", totalSize / pow(10, 3)];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (completeBlock) {
//                    completeBlock(totalSize, cacheSizeStr);
//                }
//            });
//        }];
//    });
//}




@end
