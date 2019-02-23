//
//  PushModel.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/24.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "PushModel.h"

@implementation APS
static APS *_aps;



- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharedAPS {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
             _aps = [[APS alloc]init];
        
    });
    return _aps;
}
- (id)initWithDict:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.alert = [dict objectForKey:@"alert"];
        self.badge = [dict objectForKey:@"badge"];
        self.sound=[dict objectForKey:@"sound"];
    }
    return self;
}

@end
@implementation PushModel
static PushModel *_pushModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharedPushModel {
    
    static dispatch_once_t twoToken;
    dispatch_once(&twoToken, ^{
        
        _pushModel = [[PushModel alloc]init];
        
    });
    return _pushModel;
}
- (id)initWithDict:(NSDictionary *)dict
{
    if (self=[super init])
    {
        self.aps = [dict objectForKey:@"aps"];
        self.apsModel=[[APS sharedAPS] initWithDict:self.aps];
        self.command = [dict objectForKey:@"command"];//等于13撤回
        self.msgtype=[dict objectForKey:@"msgtype"];
        self.pushId=[dict objectForKey:@"pushId"];
        self.taskid=[dict objectForKey:@"taskid"];
    }
    return self;
}
@end


