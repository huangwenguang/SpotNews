//
//  JSServerListTool.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/8.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JSServerListTool : NSObject
@property(nonatomic,copy) ServerListBlock serverListBlock;
@property(nonatomic,strong) NSMutableArray *serverNomalList;
+(instancetype)sharedServer;
/**
 *  请求服务器列表 快讯服务器、报价服务器、k线服务器
 */
-(void)getServerList;
@end
