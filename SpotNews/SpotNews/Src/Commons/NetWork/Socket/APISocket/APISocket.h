//
//  APISocket.h
//  socketDemo
//
//  Created by WenGuangHuang on 16/4/8.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TSSOCKET_E_SOCKET_CONNECTED @"TS_SOCKET_CONNECTED"
#define TSSOCKET_P_GET_NEWS @"GET_NEWS"//主动请求时讯数据
#define TSSOCKET_PACKID @"TS_PACKETID"
#import "SocketIOPacket.h"
#import "SocketIO.h"
#import "SocketCallback.h"
@interface APISocket : NSObject
/**
 *  获得 TSSocket 的单例对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedSocket;
/**
 *  给服务器发送数据
 *
 *  @param eventName 事件名
 *  @param data      数据
 */
- (void)sendEvent:(NSString *)eventName withData:(NSDictionary *)data;
/**
 *  给服务器发送数据，并等待服务器返回
 *
 *  @param eventName 时间名
 *  @param data      数据
 *  @param ack       成功接收到服务器返回信息时调用的方法
 *  @param error     如果请求超时或网络错误时调用的方法
 */
- (void)sendEvent:(NSString *)eventName withData:(NSDictionary *)data ackBlock:(void (^)(NSDictionary *ackDict))ack errorBlock:(void (^)())error;

-(void)disConnectToSocket;
-(void)connectToSocket;
@end
