//
//  NSDate+Extension.m
//  TestDemo
//
//  Created by 郑浦东 on 15/2/17.
//  Copyright (c) 2015年 iQQBot. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (NSString *)formatWithFormatString:(NSString *)formatstr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatstr];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:self];
}
- (NSString *)formatWithDefaultString {
    return [self formatWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)formatWithStringYMD {
    return [self formatWithFormatString:@"yyyy-MM-dd"];
}

- (NSString *)formatWithStringMD {
    return [self formatWithFormatString:@"MM-dd"];
}


+ (instancetype)dateWithString:(NSString *)string andFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}

//输入 :北京时间字符串
+ (instancetype)dateWithCNString:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];//Asia/Shanghai
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *dateFormatted = [[dateFormatter dateFromString:string] dateByAddingTimeInterval:-8*60*60];
    
    return  dateFormatted;
    
//    NSString *str=[dateFormatted formatWithDefaultString];

}


//输入 :世界时间字符串
+ (instancetype)dateWithString:(NSString *)string{
    
    string=[string stringByReplacingOccurrencesOfString:@".000Z" withString:@"+0000"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
  
    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    //输出格式
    NSDate *anyDate = [dateFormatter dateFromString:string];
    
    return anyDate;
    
    
}



+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

@end
