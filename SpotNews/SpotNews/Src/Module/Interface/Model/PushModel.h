//
//  PushModel.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/24.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APS : NSObject
+(instancetype)sharedAPS;
- (id)initWithDict:(NSDictionary *)dict;
@property (nonatomic, strong) NSString *alert;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSString *sound;
@end

@interface PushModel : NSObject
+(instancetype)sharedPushModel;
- (id)initWithDict:(NSDictionary *)dict;
@property (nonatomic, strong) NSDictionary *aps;
@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSString *msgtype;
@property (nonatomic, strong) NSString *pushId;
@property (nonatomic, strong) NSString *taskid;
@property (nonatomic, strong) APS *apsModel;
@end