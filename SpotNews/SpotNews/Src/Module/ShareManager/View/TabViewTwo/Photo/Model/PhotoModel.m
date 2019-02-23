//
//  PhotoModel.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.photoID = dict[@"photoID"];
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];

    }
    return self;
}

+ (instancetype)interfaceWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
