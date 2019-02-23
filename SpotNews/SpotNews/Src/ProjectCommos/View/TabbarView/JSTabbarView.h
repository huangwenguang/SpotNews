//
//  TabbarView.h
//  ChildCareExpert
//
//  Created by carmen on 15/11/27.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "CommonUtils.h"
@interface JSTabbarView : NSObject<RDVTabBarControllerDelegate>
+(JSTabbarView *)tabbarView;
- (void)setupViewControllers;
@property (strong, nonatomic) UIViewController *viewController;
@end
