//
//  ViewController.m
//  02-远程视频播放(AVPlayer)
//
//  Created by apple on 15/8/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "OnDemandViewController.h"
#import "VideoPlayView.h"
#import "FullViewController.h"

@interface OnDemandViewController () <VideoPlayViewDelegate>

@property (weak, nonatomic) VideoPlayView *playView;

@property (nonatomic, strong) FullViewController *fullVc;

@end

@implementation OnDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupVideoPlayView];
    
//    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"]];
       AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[[NSBundle mainBundle] URLForResource:@"promo_full.mp4" withExtension:nil]];
      self.playView.playerItem = item;
}

- (void)setupVideoPlayView
{
    VideoPlayView *playView = [VideoPlayView videoPlayView];
    playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view addSubview:playView];
    self.playView = playView;
    self.playView.delegate = self;
}

- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self presentViewController:self.fullVc animated:YES completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
            [self.view addSubview:self.playView];
        }];
    }
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}
-(void)viewWillDisappear:(BOOL)animated
{
   
    [self.playView.player pause];
    
    [self.playView removeProgressTimer];

    
}

@end
