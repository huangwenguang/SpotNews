//
//  AppDelegate.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 jin10. All rights reserved.
//


#import "JSServerListTool.h"
#import "JSSignTool.h"
#import "JSPushTokenTool.h"
#import "PushModel.h"
#import "JSScreenshotView.h"



@interface JSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) NSMutableArray *serverNomalList;
@property(nonatomic,strong) JSScreenshotView *screenshot;

@end

