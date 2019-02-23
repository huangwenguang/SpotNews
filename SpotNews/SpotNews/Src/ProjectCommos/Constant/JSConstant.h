//
//  Constant.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

//型号
#define k_iOS7         ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define k_iOS8         ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=8)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define k_Phone4        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define k_Phone5        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define k_Phone6        ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define k_Phone6Plus    ([[UIScreen mainScreen] bounds].size.height == 736.0f)
//设备整个界面的大小
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// tabbar的高度
#define JSTabBar_HEIGHT 44
//没有tabbar的高度
#define JSViewBounds  self.viewBounds.size.height //504(已经减掉状态栏和导航条的高度)
//有tabbar的高度
#define JSViewBoundsTabbarFrame   self.viewBounds.size.height-JSTabBar_HEIGHT //460


// 导航栏（navigationbar）大小
#define NAVIGATIONBAR  (self.navigationController.navigationBar.frame)

#define NAVIGATIONBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)



//状态栏大小
#define RECTSTATUS ([[UIApplication sharedApplication] statusBarFrame])
#define RECTSTATUS_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

//状态栏变化
#define JSGSetStatusBarHidden(value) [UIApplication sharedApplication].statusBarHidden = value;
#define JSGSetStatusBarStyle(value) [UIApplication sharedApplication].statusBarStyle = value;

#define JSGHideStatusBar [UIApplication sharedApplication].statusBarHidden = YES;
#define JSGShowStatusBar [UIApplication sharedApplication].statusBarHidden = NO;

#define JSGBlackStatusBar [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
#define JSGWhiteStatusBar [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];



#define  FanTiName  @"FZZhunYuan-M02T"


//背景色
#define JSBGCOLOR [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:248.0f/255.0f alpha:1]

#define SAFE_STRING(p)	(p&&![p isKindOfClass:[NSNull class]])? p : @"";

#define ISShow_NSLog 1 发布时注释

#ifdef ISShow_NSLog
#define NSLog(format, ...)  \
NSLog(@"file:%s line:%d\nNSLog:" format,strrchr(__FILE__,'/'),__LINE__, ## __VA_ARGS__)
#else
#define NSLog(format, ...)
#endif

#define kForExportProject 1

#if kForExportProject
#import <TCPlayerSDK/TCPlayerSDK.h>
#else
#import "TCPlayerSDK.h"
#endif



