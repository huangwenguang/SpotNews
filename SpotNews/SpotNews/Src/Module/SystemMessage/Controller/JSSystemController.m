//
//  SystemController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSSystemController.h"

@implementation JSSystemController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.isTabBarView=NO;
    [self showBackBtn];
    self.title=@"刷新重试";
    [self UIbulid];
    

}
-(void)UIbulid
{
    JSRefreshRetryView *refreshRetryView=[[JSRefreshRetryView alloc] initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,self.viewBounds.size.height)];
    refreshRetryView.refreshClick=^()
    {
        [CommonUtils UIAlert:@"刷新成功"];
    };
    [self.view addSubview:refreshRetryView];

}
@end
