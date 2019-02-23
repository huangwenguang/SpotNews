//
//  MsgSectionObject.m
//  JinShi
//
//  Created by GU on 15/5/7.
//  Copyright (c) 2015年 jin10.com. All rights reserved.
//

#import "MsgSectionObject.h"

@implementation MsgSectionObject
-(instancetype)init{
    if (self=[super init]) {
        self.msgObjectList=[NSMutableArray array];
        return self;
    }
    return nil;
}

@end
