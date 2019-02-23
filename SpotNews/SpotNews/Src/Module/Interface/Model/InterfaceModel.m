//
//  InterfaceModel.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/29.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "InterfaceModel.h"

@implementation InterfaceModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = dict[@"ID"];
        self.interName = dict[@"interName"];
        
        
    }
    return self;
}

+ (instancetype)interfaceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
