//
//  CommonUtils.h
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "NSDate+Extension.h"
@interface CommonUtils : NSObject<UIAlertViewDelegate>

+(float)IOSVersion;
+(BOOL)isIOS8;
+(BOOL)isIOS7;
+(CGRect)resizeViewBoundsforTable:(CGRect)bounds withNavBarHeight:(float)height;
+ (id)StringtoArrayOrNSDictionary:(NSString *)strJson;
+(BOOL) isEmptyString:(NSString *) string;
//颜色值
+(UIColor *)translateHexStringToColor:(NSString *)hexColor;
+(id)conversionDataFormat:(id)JSON;
+(NSString *)stringFromDateString:(NSString *)str withFormat:(NSString *)format;
+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+(NSString *)models;
//字符串是否为空字符的方法
+(BOOL)isBlankString:(NSString *)string;
//提示
+(void)UIAlert:(NSString *)str;
//设置文字大小
+(UIFont*)getFanTiFont:(NSInteger)size;

//保存数据库路径
+(NSString *)DBpath;
// - 比较时间大小   0表示时间错误    1表示time1>time2     2表示time1<time2  3表示time1=time2
+(NSInteger)compareTimeData1:(NSDate*)date1  date2:(NSDate*)date2;
//是否为空
+(BOOL)isValidationNull:(NSString *)str;
@end
