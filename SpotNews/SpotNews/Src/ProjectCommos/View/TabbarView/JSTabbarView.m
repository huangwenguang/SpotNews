//
//  TabbarView.m
//  ChildCareExpert
//
//  Created by carmen on 15/11/27.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import "JSTabbarView.h"
#import "JSHomeViewController.h"
#import "InterfaceController.h"
#import "JSMoreController.h"
#import "LiveHomeViewController.h"



#import "JSAppDelegate.h"
@implementation JSTabbarView
+(JSTabbarView *)tabbarView
{
    static JSTabbarView *_share=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share=[[JSTabbarView alloc] init];
    });
    return _share;
}

- (void)setupViewControllers{
    
    UIViewController *index =  [[JSHomeViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:index];
    
    UIViewController *secondViewController = [[LiveHomeViewController alloc] init];

    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    
    UIViewController *thirdViewController = [[JSMoreController alloc ] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    tabBarController.delegate=self;

    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController]];

    self.viewController=tabBarController;
    [self customizeTabBarForController:tabBarController];

   
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_bg"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_bg"];
    NSArray *tabBarItemImages         = @[@"home_icon_root", @"home_icon_message", @"home_icon_more"];
    NSArray *tabBarItemImagesSelected = @[@"home_icon_root_selected", @"home_icon_message_selected", @"home_icon_more_selected"];
    NSArray *tabBarItemTitle=@[@"首页",@"消息",@"更多"];
    NSDictionary *titleAttributes_normal = nil;
    NSDictionary *titleAttributes_selected = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        
        titleAttributes_normal = @{
                                   NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                   NSForegroundColorAttributeName: [CommonUtils translateHexStringToColor:@"#b7b7b7"],
                                   };
        titleAttributes_selected = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                     NSForegroundColorAttributeName: [CommonUtils translateHexStringToColor:@"#00AE00"],
                                     };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        titleAttributes_normal = @{
                                   UITextAttributeFont: [UIFont boldSystemFontOfSize:13],
                                   UITextAttributeTextColor: [CommonUtils translateHexStringToColor:@"#b7b7b7"],
                                   };
        titleAttributes_selected = @{
                                     UITextAttributeFont: [UIFont boldSystemFontOfSize:13],
                                     UITextAttributeTextColor: [CommonUtils translateHexStringToColor:@"#00AE00"],
                                     };
        
#endif
    }
    
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages         objectAtIndex:index]];
        UIImage *selectedimage   = [UIImage imageNamed:[tabBarItemImagesSelected objectAtIndex:index]];
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        item.title=[tabBarItemTitle objectAtIndex:index];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.selectedTitleAttributes=titleAttributes_selected;
        item.unselectedTitleAttributes=titleAttributes_normal;
        item.itemHeight =JSTabBar_HEIGHT;//设置高度

               index++;
    }
    

}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController willSelected:(int)index
{

    
    return YES;
}
@end
