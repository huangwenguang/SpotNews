//
//  MsgDataObject.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "MsgDataObject.h"
#import "NSDate+Extension.h"
@implementation MsgDataObject
+ (instancetype)dataWithTempClass:(MsgAllObject *)temp {
    return [self dataWithString:temp.content];
}

+ (instancetype)dataWithString:(NSString *)str {
    NSArray *arr = [str componentsSeparatedByString:@"#"];
    return [self dataWithArray:arr];
}

+ (instancetype)dataWithArray:(NSArray *)arr {
    
    MsgDataObject *data = [[self alloc] init];
    data.name = arr[2];
    data.prev = arr[3];
    data.cons = arr[4];
    data.actual = arr[5];
    data.star = ((NSString *)arr[6]).intValue;
    data.yingxiang = arr[7];
    data.country = arr[9];
    data.publictime = [NSDate dateWithCNString:arr[8]];
    data.ID = ((NSString *)arr[11]).intValue;
    if (arr.count > 12) {
        data.newstimespan = arr[12];
    }
    return data;
    
}
-(void)setID:(int)ID
{

    self.msgId=ID;
}

@end
