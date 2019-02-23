//
//  LiveViewController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/15.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "LiveViewController.h"
#import "JSToolbarView.h"

@interface LiveViewController ()
{
    TCPlayerView *_playerView;
}
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   self.isTabBarView=NO;
     self.title=@"直播";
    [self UIBulid];
    
    _playerView = [[TCPlayerView alloc] init];
    _playerView.frame = CGRectMake(20, 1, self.view.bounds.size.width - 40, 240);
    //    _playerView.defaultForceToOrientation = UIDeviceOrientationLandscapeLeft;
    [self.view addSubview:_playerView];
    
    [self player];
    
    // Do any additional setup after loading the view.
}
-(void)player
{
    TCPlayItem *item = [[TCPlayItem alloc] init];
    item.type = @"标清";
    
    //item.url = @"http://2527.vod.myqcloud.com/2527_117134a2343111e5b8f5bdca6cb9f38c.f20.mp4";
    item.url = @"http://2356.liveplay.myqcloud.com/2356_a396c946021411e6b91fa4dcbef5e35a_550.m3u8";
    //    item.limitSeconds = 60;
    
    item.startSeconds = [_playerView currentTime];
    
    [_playerView play:item];
}

#pragma mark 创建UI
-(void)UIBulid
{
    CGFloat x=0;
    CGFloat y=JSViewBounds-100;
    CGFloat w=self.view.frame.size.width;
    CGFloat h=50;
    JSToolbarView *toolbarView=[[JSToolbarView alloc] initWithFrame:CGRectMake(x, y, w, h)];

    toolbarView.playClick=^()
    {
        [self player];
    
    };
    toolbarView.stopClick=^()
    {
         [_playerView stop];
        
    };
    toolbarView.restoreClick=^()
    {
      [_playerView playOrPause];
        
    };
    toolbarView.suspendedClick=^()
    {
       [_playerView playOrPause];
        
    };
    [self.view addSubview:toolbarView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
