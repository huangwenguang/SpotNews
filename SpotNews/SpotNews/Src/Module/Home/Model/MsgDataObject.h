//
//  MsgDataObject.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgAllObject.h"

@interface MsgDataObject : NSObject
/** 数据 ID */
@property (assign, nonatomic) int ID;


@property (assign, nonatomic) int msgId;

/** 理论公布时间 09:00 */
@property (strong, nonatomic) NSString *datatime;
/** 名称 */
@property (strong, nonatomic) NSString *name;
/** 前值 */
@property (strong, nonatomic) NSString *prev;
/** 预期值 */
@property (strong, nonatomic) NSString *cons;
/** 公布值 */
@property (strong, nonatomic) NSString *actual;
/** 星级 */
@property (assign, nonatomic) NSInteger star;
/** 实际公布时间 */
@property (strong, nonatomic) NSDate *publictime;
/** 国家 只去前两个字 */
@property (strong, nonatomic) NSString *country;
/** 影响 利多或利空 */
@property (strong, nonatomic) NSString *yingxiang;
/** 时间戳*新 */
@property (strong, nonatomic) NSString *newstimespan;
+ (instancetype)dataWithTempClass:(MsgAllObject*)temp;
+ (instancetype)dataWithString:(NSString *)str;
+ (instancetype)dataWithArray:(NSArray *)arr;
@end
