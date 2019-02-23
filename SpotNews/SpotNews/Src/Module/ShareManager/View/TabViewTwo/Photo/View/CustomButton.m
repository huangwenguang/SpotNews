//
//  CustomButton.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/31.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
-(id)initWithFrame:(CGRect)frame
{
     if (self==[super initWithFrame:frame]){
         float w=frame.size.width;
         float h=frame.size.height;
         UIView *uiView=[[UIView alloc] initWithFrame:CGRectMake(0,0,w,h)];
         uiView.backgroundColor=[UIColor whiteColor];
         uiView.userInteractionEnabled = YES;
         UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(customClick:)];
         [uiView addGestureRecognizer:tapGesture];
         [self addSubview:uiView];
         float m_w=30;
         float m_h=30;
         float m_x=(uiView.frame.size.width-m_w)*0.5;
         float m_y=20;
         UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(m_x,m_y,m_w,m_h)];
         imageView.image=[UIImage imageNamed:@"add"];
         [uiView addSubview:imageView];
         float t_x=(uiView.frame.size.width-30)*0.5;
         UILabel *textTitle=[[UILabel alloc] initWithFrame:CGRectMake(t_x,CGRectGetMaxY(imageView.frame)-5,30,30)];
         
         textTitle.textColor=[CommonUtils translateHexStringToColor:@"#858585"];
         textTitle.textAlignment=NSTextAlignmentCenter;
         textTitle.text=@"自定义";
         textTitle.font=[UIFont systemFontOfSize:10];
         [uiView addSubview:textTitle];
    }
    return self;
}
#pragma mark 自定义相册
-(void)customClick:(UITapGestureRecognizer *)gesture
{
    NSLog(@"自定义相册");
    if(self.photoalbumClick)
    {
        self.photoalbumClick();
    }

}
@end
