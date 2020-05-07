//
//  BDDTool.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 正则类型
typedef NS_ENUM(NSInteger, TextControlType) {
    TextControlType_none,               ///< 无限制
    TextControlType_number,             ///< 数字
    TextControlType_letter,             ///< 字母（包含大小写）
    TextControlType_letterSmall,        ///< 小写字母
    TextControlType_letterBig,          ///< 大写字母
    TextControlType_number_letterSmall, ///< 数字+小写字母
    TextControlType_number_letterBig,   ///< 数字+大写字母
    TextControlType_number_letter,      ///< 数字+字母
    TextControlType_price,              ///< 价格（小数点后最多输入两位）
};


@interface BDDTool : NSObject

/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 计算字符串size -----------------------

//  根据文字的长度、字体  来计算size,size的宽高已向上取整
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font;
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font maxW:(CGFloat)maxW;
+ (CGSize)sizeOfstring:(NSString *)string font:(UIFont *)font maxW:(CGFloat)maxW maxH:(CGFloat)maxH;
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 时间转换 -----------------------

/// 获取当前时间戳字符串(毫秒）
+ (NSString *)currentTimeStampStr;
/// 时间字符串(yyyy-MM-dd HH:mm) -> 时间戳字符串(毫秒）
+ (NSString *)timeStampFromYYYYMMDDHHMMTimeStr:(NSString *)timeStr;
/// 时间字符串(yyyy-MM-dd HH:mm:ss) -> 时间戳字符串(毫秒）
+ (NSString *)timeStampFromYYYYMMDDHHMMSSTimeStr:(NSString *)timeStr;
/// 时间戳 -> h小时前/m分钟前，超过24小时显示年月日
+ (NSString *)getRecentTimeWithTimeStampStr:(NSString *)timeStampStr;
/// 时间戳 -> h小时前/m分钟前，超过24小时显示月日 ，超过当年显示年月日
+ (NSString *)getRecentTimeMMDDHHWithTimeStampStr:(NSString *)timeStampStr;
/// 时间戳 -> s秒/m分钟/h小时/d天/m月/y年前
+ (NSString *)getRecentSMHDMYTimeWithTimeStampStr:(NSString *)timeStampStr;
/// 时间戳 -> yyyy-MM-dd HH:mm时间字符串
+ (NSString *)getYYYYMMDDHHMMTimeStrWithStampStr:(NSString *)dateStampStr;
/// 时间戳 -> yyyy-MM-dd HH:mm:ss时间字符串
+ (NSString *)getYYYYMMDDHHMMSSTimeStrWithStamp:(NSNumber *)dateStamp;
/// 时间戳 -> 09.12样式
+ (NSString *)getMMDDTimeWithStamp:(NSNumber *)timeStamp;
/// 时间戳 -> 03-12 12:12样式
+ (NSString *)getMMDDHHMMTimeWithStamp:(NSNumber *)timeStamp;
/// 时间戳 -> dateFormat【字符串】样式 (yyyy MM dd HH mm ss)
+ (NSString *)getTimeStrFromTimeStamp:(NSInteger)timeStamp dateFormatter:(NSString *)dateFormat;
/// 时间date -> dateFormat 样式(yyyy-MM-dd HH:mm:ss)
+ (NSString *)getTimeStrFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormat;
/// 年月日时分 -> 年月日时分秒
+ (NSString *)HHMMTimeStrToHHMMSSTimeStr:(NSString *)HHMMTimeStr;
/// 时间戳 -> d天h小时后、h小时m分钟后、m分钟s秒、s秒后
+ (NSString *)getSurplusTimeStringWithTimeStamp:(NSInteger)timeStamp ;
/// 以后的时间(时间戳）与当前时间相差多少秒(如果是以后的时间，返回的时间差为正值；如果是过去的时间返回的时间差为负值）
+ (NSTimeInterval)getIntervalTimeBeforeTimeStamp:(NSInteger)timeStamp;
/// 时间差(s) -> d天h小时后、h小时m分钟后、m分钟s秒、s秒后
+ (NSString *)getSurplusTimeStringWithInterval:(NSTimeInterval)timeInterval;
/// "08-10 晚上08:09:41.0" -> "昨天 上午10:09"或者"2012-08-10 凌晨07:09"
+ (NSString *)changeTheDate:(NSDate *)lastDate;
/// 根据生日（时间戳）获取年龄
+ (NSInteger)getAgeByBirthdayStamp:(NSInteger)birthdayStamp;
/// 根据时间戳（毫秒）获取NSDate
+ (NSDate *)getDateWithTimeStamp:(NSNumber *)timeStamp;

/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 字典<->JSON字符串 -----------------------

/// 字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/// json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/////////////////////////////////////////////////////////////////////////////////
#pragma mark - - --------------- 富文本字符串 -----------------------

/**
 创建带图片的富文本字符串,图片在最左侧(活动列表的标题)
 
 @param string 字符串
 @param imageNames 图片名称数组
 @param bounds 图片bounds
 @param font 字符串字体
 @param fontColor 字符串颜色
 @return 带图片的富文本字符串
 */
+ (NSAttributedString *)titleAttributedStringWithString:(NSString *)string leftImageNames:(NSArray <NSString *> *)imageNames imageBounds:(CGRect)bounds font:(UIFont *)font fontColor:(UIColor *)fontColor;

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
+(NSMutableAttributedString*)textAlignmentJustifyWithString:(NSString*)textStr textFont:(UIFont*)textFont textColor:(UIColor*)textColor lineSpacingStr:(NSString *)lineSpacing;

/** 超文本HTML格式转换为富文本AtrributeString格式 */
+ (NSAttributedString *)attributeStringByHtmlString:(NSString *)htmlString;

/** 富文本字符串size计算 */
+ (CGSize)sizeOfAttributedString:(NSAttributedString*)attributedString width:(CGFloat)width;


/////////////////////////////////////////////////////////////////////////////////
#pragma mark - ---------------- 其他常用工具 -----------------------

/// 将18300001234->183****1234，number要大于等于11位，前面留三位，后面留四位
+ (NSString *)getEncryptedNumberByNumber:(NSString *)number;

/// url格式为：https://api.comapp.fun/userupload/activityimages/37/152679204456620180520125403.jpg828x1104.jpg
+ (CGRect)getBoundsWithImageUrlStr:(NSString *)url;

/** 数量超过10000后显示为1.32万样式 */
+ (NSString *)numForZanAndComment:(NSNumber *)number;

/// 提示打开定位的alert
+ (void)locationAlertController;

/** 获取当前屏幕显示的视图控制器，如果最上层vc是模态弹出的，会获取到presentedVC */
+ (UIViewController *)getCurrentVC;

/** 获取当前屏幕显示的视图控制器，不获取模态弹出的vc */
+ (UIViewController *)getCurrentVCWithoutPresentedVC;

/// 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize;

#define ZXDictionaryOfVariableBindings(...) [Tool _ZXDictionaryOfVariableBindings:@"" # __VA_ARGS__, __VA_ARGS__]
/**
 模仿系统的对象生成字典的宏定义：NSDictionaryOfVariableBindings(...)
 if v1 = @"something"; v2 = nil; v3 = @"something"; v4 = @"";
 ZXDictionaryOfVariableBindings(v1, v2, v3) is equivalent to [NSDictionary dictionaryWithObjectsAndKeys:v1, @"v1", v3, @"v3", nil];
 并且参数的值可为nil,@"", 会自动去除值为nil, @"", @"  "等的对象
 */
+ (NSDictionary *)_ZXDictionaryOfVariableBindings:(NSString *)firstArg, ...;

/// 快速生成model
+ (void)nslogPropertyWithDic:(id)obj;


/// 正则判断
+ (BOOL)judgeRegularWith:(NSString *)contentStr byType:(TextControlType)type;
extern BOOL judgeRegularByStr(NSString *contentStr, NSString *regularStr);

/****************************************************************************/
#pragma mark - ---------------- 判断是否开启通知 -----------------------
/// 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable;

/// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting;


/****************************************************************************/
#pragma mark - ---------------- 获取沙盒路径 -----------------------
/// 根据文件类型获取沙盒缓存路径， fileType:Audio/Videl/File
+ (NSString *)getCachePathWithFileType:(NSString *)fileType;
/// 获取所有缓存大小
//+ (void)getCache:(void(^)(NSUInteger size, NSString *cacheStr))completeBlock;


///// 七牛云视频、tmp缓存
//+ (NSUInteger)getTmp_QNShortVideoCache;
///// 清理所有缓存
//+ (void)clearCache:(void(^)(void))completeBlock;
///// 清理视频、tmp缓存、动态草稿缓存
//+ (void)clearTmp_QNShortVideoCache;
///// 保存动态的草稿
//+ (void)saveNewupdateDraft:(NewUpdateDraftModel *)draftModel complete:(void(^)(BOOL isSucc))complete;
///// 清除动态草稿缓存
//+ (void)clearNewupdateDraftComplete:(void(^)(BOOL isSucc))complete;
//
@end

NS_ASSUME_NONNULL_END
