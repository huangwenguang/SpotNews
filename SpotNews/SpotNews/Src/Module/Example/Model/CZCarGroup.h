//
//  CZCarGroup.h
//  A02-汽车品牌
//
//  Created by Apple on 14/12/17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCarGroup : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,strong) NSArray *cars;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carGroupWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)carGroupsList;
@end
