//
//  AppDelegate.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSAppDelegate.h"
#import "JSCuideTool.h"
#import "TCPlayerBottomView.h"
#import "TCPlayerBaseControlView.h"
#import "TCCloudPlayerControlView.h"
#import "JSShareViewController.h"

@interface JSAppDelegate ()
{
    
}

@end

@implementation JSAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      [self keyBoardManager];
       [self MobClick];
    // 配置上报
    [[TCReportEngine sharedEngine] configAppId:kTCCloudPlayerSDKTestAppId];
    
    #if DEBUG
    [[TCReportEngine sharedEngine] setEnv:YES];
    #else
    [[TCReportEngine sharedEngine] setEnv:NO];
    #endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];

    return YES;
}
#pragma mark 检测到截屏
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    CGFloat w=80;
    CGFloat h=110;
    UIImage *image_ = [[JSScreenshotView screenshotView] imageWithScreenshot];
    __weak JSAppDelegate *appDetegate=self;
    
    appDetegate.screenshot=[[JSScreenshotView  alloc] initWithFrame:CGRectMake(self.window.frame.size.width-h,self.window.frame.size.height/2,w,h) image:image_];
    appDetegate.screenshot.screenshotClick=^()
    {
        JSShareViewController *shareView=[[JSShareViewController alloc] init];
        shareView.pic_image=image_;
        
      [appDetegate.screenshot removeFromSuperview];
       UIViewController *appRootVC=[UIApplication sharedApplication].keyWindow.rootViewController;
       [appRootVC presentViewController:[[UINavigationController alloc] initWithRootViewController:shareView] animated:YES completion:^{
      
        }];
    
    };
    [self.window addSubview:appDetegate.screenshot];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [appDetegate.screenshot removeFromSuperview];
    });
}


//键盘管理初始化
-(void)keyBoardManager
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [JSCuideTool chooseRootViewController:self.window];
    [self getServerList];
    [self registeredToken:application];
    return YES;
}
#pragma mark  注册Token
-(void)registeredToken:(UIApplication *)application
{
    // 请求获取DeviceToken
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 1.获取发送通知的权限
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        // 2.注册远程通知
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
#if TARGET_IPHONE_SIMULATOR//模拟器
[[JSPushTokenTool sharePushToken] pushToken:[JSSaveTool objectForKey:JSDeviceToken] oldToke:@""];
#endif


}
#pragma mark并加入以下方法，注：这个方法在用户推送注册成功后调用，在此方法注册推送
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
   // [application registerForRemoteNotifications];
    
}
/**
 *  设备注册通知成功
 *
 *  @param application application
 *  @param deviceToken 设备token
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"设备注册通知成功");
    [[JSPushTokenTool sharePushToken] getToken:[NSString stringWithFormat:@"%@",deviceToken]];
    
}
/**
 *  后台收到本地通知
 *
 *  @param application application
 *  @param userInfo    userInfo
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"userInfo%@",notification.userInfo);

}

/**
  *  设备注册通知失败
  *
  *  @param app UIApplication
  *  @param err NSError
  */
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    NSLog(@"%@",str);
}
#pragma mark 收到远程通知(前台和后台收到信息都会进入此方法)
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    application.applicationIconBadgeNumber += 1;

    NSLog(@"接收userInfo%@",userInfo);
    PushModel *pushModel=[[PushModel sharedPushModel] initWithDict:userInfo];
    if (userInfo) {
        if (application.applicationState == UIApplicationStateActive)
        {
            NSLog(@"前台userInfo%@",userInfo);
            UIAlertView * alerts = [[UIAlertView alloc] initWithTitle:nil message:pushModel.apsModel.alert delegate:self
                                                    cancelButtonTitle:nil otherButtonTitles:@"查看",nil];
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                application.applicationIconBadgeNumber = 0;
            });
            alerts.tag= 101 ;
            [alerts show];
            NSLog(@"刷新数据");
        }
        if (application.applicationState == UIApplicationStateBackground)
        {
            NSLog(@"后台userInfo%@",userInfo);
        }
        if (application.applicationState == UIApplicationStateInactive)
        {
            NSLog(@"点击某条消息进入APP程序状态userInfo%@",userInfo);
        }
        
        // [self Towithdraw:pushModel];
        
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

//请求服务器列表 快讯服务器、报价服务器、k线服务器
-(void)getServerList
{
     [[JSServerListTool sharedServer] getServerList];
    [JSServerListTool sharedServer].serverListBlock=^(NSMutableArray * arrayList)
    {
        self.serverNomalList=arrayList;
        [APISocket sharedSocket];
    };

}
//友盟
-(void)MobClick
{
    [MobClick startWithAppkey:JSUMENGAPP_KEY reportPolicy:BATCH   channelId:nil];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
