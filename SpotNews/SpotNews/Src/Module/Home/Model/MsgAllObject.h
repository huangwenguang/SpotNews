//
//  MsgAllObject.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Extension.h"

@interface MsgAllObject : NSObject
@property (strong, nonatomic) NSString *content;//内容文本/数据文本字串
@property (strong, nonatomic) NSString *timestr;//
@property (strong, nonatomic) NSDate *newstime;
@property (assign, nonatomic) NSInteger type;//类型 0:文本 1:数据
@property (assign, nonatomic) NSInteger important;//是否重要
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *newstimespan;
@property (strong,nonatomic) NSString *url;
/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;
@end
