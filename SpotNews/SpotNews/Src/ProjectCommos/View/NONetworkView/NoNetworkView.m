//
//  NoNetworkView.m
//  ChildCareExpert
//
//  Created by carmen on 15/10/28.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import "NoNetworkView.h"
@implementation NoNetworkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)sharedNetworkView {
    static NoNetworkView *noNetworkView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noNetworkView = [[NoNetworkView alloc] init];
        
    });
    return noNetworkView;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.netWorkView=[[UIView alloc] initWithFrame:CGRectMake(frame.origin.x,64, frame.size.width, frame.size.height)];
        [self.netWorkView setBackgroundColor:[CommonUtils translateHexStringToColor:@"#ecefef"]];
        self.netWorkView.alpha=0.8;
        [self addSubview: self.netWorkView];
        
        float x=(self.netWorkView.frame.size.width-56)*0.5;
        float y=self.netWorkView.frame.size.height*0.3;
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(x,y,56,56)];
        self.imageView.image=[UIImage imageNamed:@"no_network"];
        [self.imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self.imageView addGestureRecognizer:singleTap1];
        
        
        [self.netWorkView  addSubview:self.imageView];
        float xeorrerLabel=(self.netWorkView.frame.size.width-160)*0.5;
        float yimageView=CGRectGetMaxY(self.imageView.frame)+10;
        self.errorLabel=[[UILabel alloc] initWithFrame:CGRectMake(xeorrerLabel, yimageView, 160, 20)];
        self.errorLabel.backgroundColor=[UIColor clearColor];
        self.errorLabel.font=[UIFont systemFontOfSize:14];
        
        self.errorLabel.text=@"无网络连接，请点击重试";
        [self.netWorkView  addSubview:self.errorLabel];
        self.netWorkView.hidden=NO;
    }
    return self;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    self.errorLabel.hidden=YES;
    [self AddIndicatorView];
    
}
-(void)hideNotNetWork
{
    
    self.netWorkView.hidden=YES;
}

-(void)AddIndicatorView
{

        self.indicatorView=[[UIActivityIndicatorView  alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.imageView.frame), CGRectGetMaxY(self.imageView.frame), 50, 50)];
        self.indicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
        self.indicatorView.color=[UIColor whiteColor];
        self.indicatorView.hidesWhenStopped=NO;
        [self.indicatorView startAnimating];
        [self.netWorkView addSubview:self.indicatorView];
 
    
}
@end
