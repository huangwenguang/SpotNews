//
//  MsgAllObject.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "MsgAllObject.h"

@implementation MsgAllObject
- (void)setTimestr:(NSString *)timestr{
    self.newstime = [NSDate dateWithString:timestr];
}

@end
