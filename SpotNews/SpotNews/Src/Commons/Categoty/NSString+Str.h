//
//  NSString+SY.h
//  SanYouDemo
//
//  Created by hwg on 15/9/22.
//  Copyright (c) 2015年 sanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (Str)
- (BOOL) isEmptyString;
- (NSString *) trim;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (NSString *)md5;
@end
