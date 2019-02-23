//
//  PushTokenTool.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSPushTokenTool.h"
static JSPushTokenTool *_pushTokenTool;
@implementation JSPushTokenTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharePushToken {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _pushTokenTool = [[JSPushTokenTool alloc] init];
    });
    return _pushTokenTool;
}
- (id)copyWithZone:(NSZone *)zone
{    return _pushTokenTool;
}

- (void)pushToken:(NSString*)deviceToken oldToke:(NSString*) oldToke
{
    self.oldToken=oldToke;
    NSString *notifySwitch;//通知是否打开
    UIUserNotificationType types=[[UIApplication sharedApplication] currentUserNotificationSettings].types;
    if (types==UIUserNotificationTypeNone) {
        notifySwitch=@"0";
    }else{
        notifySwitch=@"1";
    }
    
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
#if TARGET_IPHONE_SIMULATOR//模拟器
    deviceToken=JSIphonedeviceToken;
    [JSSaveTool setObject:deviceToken forKey:JSDeviceToken];
#endif
    [params setObject:deviceToken forKey:@"deviceToken"];
    [params setObject:device.systemName forKey:@"sysName"];
    [params setObject:device.systemVersion forKey:@"sysVersion"];
    [params setObject:JSCurVersion forKey:@"appVersion"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken]  forKey:@"deviceType"];
    [params setObject:[NSString stringWithFormat:@"%@",self.oldToken] forKey:@"oldToken"];
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_UPDATETOKEN params:params
                               success:^(id responseObj) {
                                   NSLog(@"token值%@",responseObj);
                               } failure:^(id NSDictionary) {
                                   NSLog(@"token值%@",NSDictionary);
   
                                   
                               }];
}
-(void)getToken:(NSString *)deviceToken
{
    NSString *devicetk=[[[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSString  *devToken=[devicetk stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.oldToken =[JSSaveTool objectForKey:JSDeviceToken];
    NSLog(@"获取token-----devToken%@", devToken);
    NSLog(@"oldToken%@", self.oldToken);
    if (![self.oldToken isEqualToString:devToken])
    {
      [JSSaveTool setObject:devToken forKey:JSDeviceToken];
    }else
    {
        self.oldToken=@"";
    }
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
    [self pushToken:devToken oldToke:self.oldToken];
        
    });
    
}

@end
