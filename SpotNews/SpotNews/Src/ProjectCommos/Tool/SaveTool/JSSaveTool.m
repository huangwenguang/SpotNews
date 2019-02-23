//
//  JSSaveTool.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSSaveTool.h"

@implementation JSSaveTool
+ (id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
}
+ (void)setBOOL:(BOOL)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
}
@end
