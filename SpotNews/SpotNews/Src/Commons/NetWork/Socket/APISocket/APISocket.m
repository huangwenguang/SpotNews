//
//  APISocket.m
//  socketDemo
//
//  Created by WenGuangHuang on 16/4/8.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "APISocket.h"



@interface APISocket()<SocketIODelegate,SocketCallbackDelegate>
@property (strong, nonatomic) SocketIO *socket;
@property (assign, nonatomic) BOOL isConnect;
@property (strong, nonatomic) NSMutableDictionary *callBacks;
@end
static APISocket *tsSocket;
@implementation APISocket
+(id)sharedSocket {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tsSocket = [[self alloc] init];
    });
    return tsSocket;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (tsSocket == nil) {
        return [super allocWithZone:zone];
    }
    return tsSocket;
}

- (instancetype)init {
    if (self = [super init]) {
        self.callBacks = [NSMutableDictionary dictionary];
        self.socket = [[SocketIO alloc] initWithDelegate:self];
        [self connectToSocket];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIApplicationDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)UIApplicationDidBecomeActiveNotification{
    [self connectToSocket];
    
}
- (void)applicationWillTerminate {

    [self disConnectToSocket];
}
- (void)connectToSocket
{
    //    if (self.isConnect) {
    //        return;
    //    }
    NSString *server=[self getServerNomal];
    NSArray *arr=[server componentsSeparatedByString:@":"];
    [self.socket connectToHost:arr[0] onPort:[arr[1] integerValue]];
}
-(NSString*)getServerNomal{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSString *array=[def objectForKey:@"ServerNomal"];
    return array;
}

- (void)disConnectToSocket
{
 
    [self.socket disconnect];
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error{
    NSLog(@"快讯服务器断开连接");
   //  [LoginManager instance].isConnected=NO;
    self.isConnect=NO;
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self connectToSocket];
    });
    
}
- (void)socketIODidConnect:(SocketIO *)socket{
    
    self.isConnect=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:TSSOCKET_E_SOCKET_CONNECTED object:nil];
    //[[LoginManager instance] loginToServerwithType:NO];
}
- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSString *packetId = packet.dataAsJSON[1][TSSOCKET_PACKID];
    NSLog(@"packetId=%@",packetId);
    if (packetId.length != 0) {
        SocketCallback *callback = self.callBacks[packetId];
        if (callback) {
            //停止定时器
            [callback.timer invalidate];
            if (callback.ackCallbackBlock) {
                callback.ackCallbackBlock(packet.dataAsJSON[1]);
            }
            [self.callBacks removeObjectForKey:packetId];
        }
        return;
    }
    
    // 这个是主动监听的
    [[NSNotificationCenter defaultCenter] postNotificationName:packet.name object:nil userInfo:packet.dataAsJSON[1]];
}

- (void)sendEvent:(NSString *)eventName withData:(NSDictionary *)data {
    [self.socket sendEvent:eventName withData:data];
}

- (void)sendEvent:(NSString *)eventName withData:(NSDictionary *)data ackBlock:(void (^)(NSDictionary *))ack errorBlock:(void (^)())error {
    if(self.socket.isConnected == NO) {
        //        error();
        //        return;
        NSString *packetId =@"";
        for(int i=0; i<3; i++)
        {
            packetId = [packetId stringByAppendingFormat:@"%i",(arc4random() % 9)+1];
        }
        NSLog(@"packetId_send=%@",packetId);
        NSMutableDictionary * data_packet = [[NSMutableDictionary alloc] initWithDictionary:data];
        data_packet[TSSOCKET_PACKID] = packetId;
        SocketCallback *callback = [SocketCallback callbackWithAckBlock:ack andErrorBlock:error];
        callback.delegate = self;
        callback.packetId = packetId;
        [self.callBacks setValue:callback forKey:packetId];
        //        [self.socket sendEvent:eventName withData:data_packet];
    }else{
        NSString *packetId =@"";
        for(int i=0; i<3; i++)
        {
            packetId = [packetId stringByAppendingFormat:@"%i",(arc4random() % 9)+1];
        }
        NSLog(@"packetId_send=%@",packetId);
        NSMutableDictionary * data_packet = [[NSMutableDictionary alloc] initWithDictionary:data];
        data_packet[TSSOCKET_PACKID] = packetId;
        SocketCallback *callback = [SocketCallback callbackWithAckBlock:ack andErrorBlock:error];
        callback.delegate = self;
        callback.packetId = packetId;
        [self.callBacks setValue:callback forKey:packetId];
        [self.socket sendEvent:eventName withData:data_packet];
    }
    
    
}

- (void)socketCallbackOnTimeout:(SocketCallback *)callback {
    [self.callBacks removeObjectForKey:callback.packetId];
}

@end
