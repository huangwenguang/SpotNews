//
//  CZCarGroup.m
//  A02-汽车品牌
//
//  Created by Apple on 14/12/17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZCarGroup.h"

@implementation CZCarGroup

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (instancetype)carGroupWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

+ (NSMutableArray *)carGroupsList
{
    //加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_simple" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in dicArray) {
        CZCarGroup *carGroup = [CZCarGroup carGroupWithDic:dic];
        [tmpArray addObject:carGroup];
    }
    return tmpArray;
}

@end
