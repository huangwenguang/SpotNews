//
//  JSSaveTool.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSSaveTool : NSObject
+ (id)objectForKey:(NSString *)defaultName;

+ (void)setObject:(id)value forKey:(NSString *)defaultName;
//是否第一次访问
+ (void)setBOOL:(BOOL)value forKey:(NSString *)defaultName;
@end
