//
//  NSDate+Extension.h
//  TestDemo
//
//  Created by 郑浦东 on 15/2/17.
//  Copyright (c) 2015年 iQQBot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
- (NSString *)formatWithFormatString:(NSString *)formatstr;
+ (instancetype) dateWithString:(NSString *)string andFormat:(NSString *)format;
+ (instancetype)dateWithString:(NSString *)string;
- (NSString *)formatWithDefaultString;
- (NSString *)formatWithStringYMD;
- (NSString *)formatWithStringMD;
+ (instancetype)dateWithCNString:(NSString *)string;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
@end
