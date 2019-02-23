//
//  CommonBlock.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 jin10. All rights reserved.
//


typedef void (^CommonReturnIntegerBlock)(NSInteger returnValue);
typedef void(^ServerListBlock)(NSMutableArray *);//请求服务器列表 快讯服务器、报价服务器、k线服务器
typedef void(^RefreshRetryClick)(void);//刷新重试
typedef void(^HomeNavigationBarViewClick)(int index);// 首页工具条





