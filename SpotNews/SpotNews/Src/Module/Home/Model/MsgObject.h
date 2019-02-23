//
//  MsgObject.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgAllObject.h"

@interface MsgObject : NSObject
@property (assign, nonatomic) BOOL important;
@property (strong, nonatomic) NSDate *publictime;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *imageurl;
@property (strong, nonatomic) NSString *newstimespan;

@property (strong, nonatomic) NSString *publictimeFormat;//hh:mm:ss

@property (assign, nonatomic) CGSize retSize;
+ (instancetype)messageWithTempClass:(MsgAllObject *)temp;
+ (instancetype)messageWithString:(NSString *)str;
+ (instancetype)messageWithArray:(NSArray *)arr;
@end
