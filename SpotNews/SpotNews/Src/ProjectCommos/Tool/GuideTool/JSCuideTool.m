//
//  JSCuideTool.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSCuideTool.h"
#import "JSNewFeatureController.h"
#import "JSTabbarView.h"
#import "RDVTabBarController.h"

@implementation JSCuideTool
+ (void)chooseRootViewController:(UIWindow *)window
{

    NSString *lastVersion = [JSSaveTool objectForKey:JSVersion];
    if ([JSCurVersion isEqualToString:lastVersion]) {
        [[JSTabbarView tabbarView] setupViewControllers];
       [window setRootViewController:[JSTabbarView tabbarView].viewController];
        [JSSaveTool setBOOL:NO forKey:JSFirstTime];
         window.backgroundColor = [UIColor clearColor];
         [window makeKeyAndVisible];
   
        
    }else{
        JSNewFeatureController *newFeature = [[JSNewFeatureController alloc] init];
        window.rootViewController = newFeature;
        [JSSaveTool setBOOL:YES forKey:JSFirstTime];
        [JSSaveTool setObject:JSCurVersion forKey:JSVersion];
        [window  makeKeyAndVisible];
    }
    
}
@end
