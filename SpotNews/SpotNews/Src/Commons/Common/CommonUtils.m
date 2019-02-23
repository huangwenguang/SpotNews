//
//  CommonUtils.m
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "CommonUtils.h"
#import "NSString+Str.h"
#define kName @"Breaking_News.sqlite"
static NSInteger  IsFanTi=0;//  0 未设置   1简体  2繁体
@implementation CommonUtils
+(float)IOSVersion
{
    static float _iOSVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _iOSVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return _iOSVersion;
}
+(BOOL)isIOS8
{
    if ([CommonUtils IOSVersion]>=8.0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)isIOS7
{
    if ([CommonUtils IOSVersion]>=7.0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(CGRect)resizeViewBoundsforTable:(CGRect)bounds withNavBarHeight:(float)height
{

    if ([CommonUtils isIOS7])
    {
         float h=bounds.size.height-RECTSTATUS_HEIGHT-height;
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,  h);
    }
    else
    {
        return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height-height);
    }
}
+ (id)StringtoArrayOrNSDictionary:(NSString *)strJson {
    if (!strJson || strJson == nil) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData =[strJson dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        return nil;
    }
}


+(BOOL) isEmptyString:(NSString *) string{
    if (string == nil) return YES;
    return [string isEmptyString];
}

+(UIColor *)translateHexStringToColor:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])  cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])   cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rColorValue = [cString substringWithRange:range];
    range.location = 2;
    NSString *gColorValue = [cString substringWithRange:range];
    range.location = 4;
    NSString *bColorValue = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rColorValue] scanHexInt:&r];
    [[NSScanner scannerWithString:gColorValue] scanHexInt:&g];
    [[NSScanner scannerWithString:bColorValue] scanHexInt:&b];
    return [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat) b / 255.0f) alpha:1.0f];
}


+(NSString *)stringFromDateString:(NSString *)str withFormat:(NSString *)format
{
    NSDate *dat=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    NSString  *destDateString = [formatter stringFromDate:dat];
    return destDateString;
    
}
+(NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+(id)conversionDataFormat:(id)JSON
{
    NSData *doubi = JSON;
    NSString *responses =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
    NSString *result=[NSString stringWithString:responses];
    JSON=[CommonUtils StringtoArrayOrNSDictionary:result];
    
    return JSON;
}
+(NSString *)models{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+(BOOL)isBlankString:(NSString *)string {
    if ([string doubleValue] < 0) {
        return YES;
    }
    if ([string doubleValue] == 0) {
        return YES;
    }
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(void)UIAlert:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    
}
+(UIFont*)getFanTiFont:(NSInteger)size{
    switch (IsFanTi) {
        case 0://未设置
            return [UIFont systemFontOfSize:size];
            break;
        case 1:
            return  [UIFont systemFontOfSize:size];
            break;
        case 2:
            return [UIFont fontWithName:FanTiName size:size];
            break;
        default:
            return [UIFont systemFontOfSize:size];
            break;
    }
    return [UIFont systemFontOfSize:size];
}

+(NSInteger)compareTimeData1:(NSDate*)date1  date2:(NSDate*)date2
{
    if (!date1 || !date2) {
        return 0;
    }
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    
    comps1 = [calendar components:unitFlags fromDate:date1];
    NSInteger year1 = [comps1 year];
    NSInteger mon1 = [comps1 month];
    NSInteger day1 = [comps1 day];
    
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    comps2 = [calendar components:unitFlags fromDate:date2];
    NSInteger year2 = [comps2 year];
    NSInteger mon2 = [comps2 month];
    NSInteger day2 = [comps2 day];
    if (year1==year2) {
        if (mon1==mon2) {
            if (day1==day2) {
                return 3;
            }else if(day1>day2){
                return 1;
            }else if(day1<day2){
                return 2;
            }
        }else if(mon1>mon2){
            return 1;
        }else if(mon1<mon2){
            return 2;
        }
    }
    else if(year1>year2){
        return 1;
    }else if(year1<year2){
        return 2;
    }
    
    return 0;
}
+(BOOL)isValidationNull:(NSString *)str
{
    if([str stringByReplacingOccurrencesOfString:@" " withString:@""].length<=0)
    {
        return false;
    }
    return true;
}

+(NSString *)DBpath
{
    
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kName];
}


@end
