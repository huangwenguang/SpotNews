//
//  TSSocketCallback.h
//  TestDemo
//
//  Created by 郑浦东 on 15/3/18.
//  Copyright (c) 2015年 iQQBot. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SocketCallback;
@protocol SocketCallbackDelegate <NSObject>
@optional
- (void)socketCallbackOnTimeout:(SocketCallback *)callback;
@end

@interface SocketCallback : NSObject
@property (weak, nonatomic) id<SocketCallbackDelegate> delegate;
/** 收到回复包回调函数 */
@property(strong) void (^ackCallbackBlock)(NSDictionary *ackDict);
/** 异常回调函数 */
@property(strong) void (^errorCallbackBlock)();
/** 包 id */
@property (strong, nonatomic) NSString *packetId;
@property (strong, nonatomic) NSTimer *timer;

+ (instancetype)callbackWithAckBlock:(void (^)(NSDictionary *ackDict))ack andErrorBlock:(void (^)())error;

@end
