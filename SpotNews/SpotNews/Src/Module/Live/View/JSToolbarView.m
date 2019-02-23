//
//  JSToolbarVIew.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSToolbarView.h"
#define JSSpacingX 20

@implementation JSToolbarView
-(id)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
       float w=(frame.size.width-JSSpacingX*5)/4;
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        view.backgroundColor=[UIColor yellowColor];
        [self addSubview:view];
        UIButton *btnPlay=[[UIButton alloc] init];
        [btnPlay setTitle:@"播放" forState:UIControlStateNormal];
        [btnPlay setFrame:CGRectMake(JSSpacingX,0,w,frame.size.height)];
        btnPlay.backgroundColor=[UIColor redColor];
        [btnPlay addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        btnPlay.titleLabel.font=[UIFont systemFontOfSize:10];
        [view addSubview:btnPlay];
        
        UIButton *btnStop=[[UIButton alloc] init];
        [btnStop setTitle:@"停止" forState:UIControlStateNormal];
        [btnStop setFrame:CGRectMake(JSSpacingX+CGRectGetMaxX(btnPlay.frame),0,w,frame.size.height)];
        btnStop.backgroundColor=[UIColor redColor];
        [btnStop addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
        btnStop.titleLabel.font=[UIFont systemFontOfSize:10];
        [view addSubview:btnStop];
        
        UIButton *btnRestore=[[UIButton alloc] init];
        [btnRestore setTitle:@"恢复" forState:UIControlStateNormal];
        [btnRestore setFrame:CGRectMake(JSSpacingX+CGRectGetMaxX(btnStop.frame),0,w,frame.size.height)];
        btnRestore.backgroundColor=[UIColor redColor];
        [btnRestore addTarget:self action:@selector(restoreAction:) forControlEvents:UIControlEventTouchUpInside];
        btnRestore.titleLabel.font=[UIFont systemFontOfSize:10];
        [view addSubview:btnRestore];
        
        
        UIButton *btnSuspended=[[UIButton alloc] init];
        [btnSuspended setTitle:@"暂停" forState:UIControlStateNormal];
        [btnSuspended setFrame:CGRectMake(JSSpacingX+CGRectGetMaxX(btnRestore.frame),0,w,frame.size.height)];
        btnSuspended.backgroundColor=[UIColor redColor];
        [btnSuspended addTarget:self action:@selector(suspendedAction:) forControlEvents:UIControlEventTouchUpInside];
        btnSuspended.titleLabel.font=[UIFont systemFontOfSize:10];
        [view addSubview:btnSuspended];
        
        
        
    
    }
    return self;
}
#pragma mark 播放按钮
-(void)playAction:(UIButton *)sender
{
    if (self.playClick) {
        self.playClick();
    }
    
}
#pragma mark 停止按钮
-(void)stopAction:(UIButton *)sender
{
    if (self.stopClick) {
        self.stopClick();
    }
    
}

#pragma mark 恢复按钮
-(void)restoreAction:(UIButton *)sender
{
    if (self.restoreClick) {
        self.restoreClick();
    }
    
}
#pragma mark 暂停按钮
-(void)suspendedAction:(UIButton *)sender
{
    if (self.suspendedClick) {
        self.suspendedClick();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
