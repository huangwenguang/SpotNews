//
//  TSSocketCallback.m
//  TestDemo
//
//  Created by 郑浦东 on 15/3/18.
//  Copyright (c) 2015年 iQQBot. All rights reserved.
//

#import "SocketCallback.h"
@interface SocketCallback ()

@end
@implementation SocketCallback

+ (instancetype)callbackWithAckBlock:(void (^)(NSDictionary *))ack andErrorBlock:(void (^)())error {
    SocketCallback * call = [[SocketCallback alloc] init];
    call.ackCallbackBlock = ack;
    call.errorCallbackBlock = error;
    call.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:call selector:@selector(onTimeout) userInfo:nil repeats:NO];
    //[call.timer fire];
    return call;
}

- (void)onTimeout {
    if (self.errorCallbackBlock) {
        self.errorCallbackBlock();
    }
    if ([self.delegate respondsToSelector:@selector(socketCallbackOnTimeout:)]) {
        [self.delegate socketCallbackOnTimeout:self];
    }
}

@end
