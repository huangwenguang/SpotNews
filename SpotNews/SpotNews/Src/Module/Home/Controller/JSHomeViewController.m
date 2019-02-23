//
//  HomeViewController.m
//  imageZoom
//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "JSHomeViewController.h"
#import "MsgAllObject.h"
#import "JSHomeHeaderView.h"
#import "JSHomeNavigationBarView.h"
#import "MsgObject.h"
#import "JSBreakingNewsViewController.h"
#import "OnDemandViewController.h"
#import "LiveViewController.h"


@interface JSHomeViewController ()<UIGestureRecognizerDelegate>

{

     CGFloat lastScale;
       CGPoint pointLeftTop;
}
    @property (nonatomic, strong) UIImageView *myView;
@end

@implementation JSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNav];
    [self UIbulid];
    //20秒注册通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:TSSOCKET_P_RECEIVE_NEWS object:nil userInfo:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self testNextDay];
    });
}
#pragma mark 初始UI
-(void)UIbulid
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0,RECTSTATUS_HEIGHT+NAVIGATIONBAR_HEIGHT, self.view.frame.size.width,JSViewBoundsTabbarFrame);
    contentView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    [self addChildViewController:[[JSBreakingNewsViewController alloc] init]];
    [self addChildViewController:[[OnDemandViewController alloc] init]];
    [self addChildViewController:[[LiveViewController alloc] init]];
    self.showingVc = self.childViewControllers[0];
    self.showingVc.view.frame = CGRectMake(0,0, self.view.frame.size.width,JSViewBoundsTabbarFrame);
    [self.view addSubview:self.showingVc.view];

}
#pragma mark 创建导航栏
-(void)buildNav
{
    NSArray *titleArr=[NSArray arrayWithObjects:@"突发新闻",@"点播",@"直播", nil];
   JSHomeNavigationBarView *navView = [[JSHomeNavigationBarView alloc]initWithFrame:CGRectMake(0, 0,self.viewBounds.size.width,JSTabBar_HEIGHT) titleArray:titleArr];
    navView.backgroundColor=[UIColor clearColor];
    navView.selectedIndex=0;
    navView.clickBlock=^(int index){
        [self switchViewComtroller:index];
    };
    [self.navigationController.navigationBar addSubview:navView];
    
}
#pragma mark 当前控制器
-(void)switchViewComtroller:(NSUInteger)index
{
    [self.showingVc.view removeFromSuperview];
    NSUInteger curindex = index;
    self.showingVc = self.childViewControllers[curindex];
    self.showingVc.view.frame = CGRectMake(0,0, self.view.frame.size.width,JSViewBoundsTabbarFrame);
    [self.view addSubview:self.showingVc.view];
}
/**
 * 屏幕即将旋转到某个方向时会调用这个方法
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@ willRotateToInterfaceOrientation", self.class);
}
#pragma mark 状态栏通知
-(void)testNextDay{
    NSString *testMsg=@"0#1#2016-02-20 00:00:00#财政部副部长部副部长部副部长部副部长部副部长部副部长部副部长部副部长部副部长部副部长史耀斌：中国经济改革调整后将越来越好。#####0###20160219101253184100";
    NSArray *tmp = [testMsg componentsSeparatedByString:@"#"];
    if ([tmp[0] isEqualToString:@"0"]) { // 快讯
        MsgObject *msg = [MsgObject messageWithArray:tmp];
        if ([msg.content length] == 0) { //如果为空，则不加载
            return;
        }
         [KGStatusBar showSuccessWithStatus:msg.content];
       // [Util showStatusMessage:msg.content];
    }
}



@end
