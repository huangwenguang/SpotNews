//
//  PushTokenTool.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSSignTool.h"

@interface JSPushTokenTool : NSObject
+(instancetype)sharePushToken;
@property(nonatomic,copy) NSString *oldToken;
#pragma mark 上传 token
- (void)pushToken:(NSString*)deviceToken oldToke:(NSString*) oldToke;
#pragma mark 获取token
-(void)getToken:(NSString *)deviceToken;
@end
