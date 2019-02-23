//
//  TabViewTwo.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "TabViewTwo.h"
#import "ImageObject.h"
#define k_count 4
#define image_spacing_x 15
#define image_tag 300

@interface TabViewTwo()
{
    CGRect _lastRect;
    float t_w;
    float p_w;
    float p_h;
}
@end
@implementation TabViewTwo
-(id)initWithTwoFrame:(CGRect)frame  dataImage:(NSMutableArray *)dataImage
{
    self.selectedIndex=-1;
    if (self==[super initWithFrame:frame]) {
        float w=(frame.size.width-60)/k_count;
        float h=frame.size.height;
        p_h=frame.size.height;
        p_w=w;
        self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];

        self.scrollView.scrollEnabled=YES;//滚动
        self.scrollView.bounces=NO;// 弹簧
        self.scrollView.showsHorizontalScrollIndicator=NO;//水平
        self.scrollView.userInteractionEnabled = YES;
        self.scrollView.backgroundColor=[UIColor clearColor];
        [self addSubview:self.scrollView];
        

        UIView *uiView=[[UIView alloc] initWithFrame:CGRectMake(0,0,w,h)];
          uiView.backgroundColor=[UIColor clearColor];
        uiView.userInteractionEnabled = YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreClick:)];
        [uiView addGestureRecognizer:tapGesture];
        [self.scrollView addSubview:uiView];
        float m_w=20;
        float m_h=20;
        float m_x=(uiView.frame.size.width-m_w)*0.5;
        float m_y=image_spacing_x;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(m_x,m_y,m_w,m_h)];
      
        imageView.image=[UIImage imageNamed:@"add"];
        [uiView addSubview:imageView];
       float t_x=(uiView.frame.size.width-30)*0.5;
        UILabel *textTitle=[[UILabel alloc] initWithFrame:CGRectMake(t_x,CGRectGetMaxY(imageView.frame)-5,30,30)];
      //  textTitle.textColor=[UIColor colorWithHexString:@"#858585" withAlpha:1];
        textTitle.textAlignment=NSTextAlignmentCenter;
        textTitle.text=@"更多";
        textTitle.font=[UIFont systemFontOfSize:10];
        [uiView addSubview:textTitle];
        
        float v_x=uiView.frame.size.width+image_spacing_x;
        NSMutableArray *girdArr = [NSMutableArray array];
       if(dataImage.count>0)
       {
           for (int i =0; i<dataImage.count; i++) {
               ImageObject *imageObj=dataImage[i];
               CGFloat x =i*(p_w+image_spacing_x)+v_x;
               self.imageView =  [self addGridWithX:x y:0 tag:i imageData:imageObj.small_image];
               if (i ==dataImage.count-1) {
                   _lastRect = self.imageView.frame;
               }
               [girdArr addObject:self.imageView];
           }
           //self.scrollView.subviews[49];
           UIView* lastView = [girdArr lastObject];
           CGFloat contentW= CGRectGetMaxX(lastView.frame)+image_spacing_x;
           NSLog(@"contentW%f",contentW);
           self.scrollView.contentSize = CGSizeMake(contentW,frame.size.height);
       
       }
      

    }
    return self;
}

- (UIImageView*)addGridWithX:(CGFloat)x y:(CGFloat)y tag:(int)tag imageData:(NSData *)imageData
{
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(x,y,p_w,p_h)];
    imageView.image=[UIImage imageWithData: imageData];
    imageView.tag=image_tag+tag;
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
    [imageView addGestureRecognizer:tapGesture];
    [self.scrollView addSubview:imageView];
    return imageView;
}
-(void)imageViewClick:(UITapGestureRecognizer *)gesture
{
    
    UIImageView *imageView=(UIImageView *)gesture.view;
    int click =(int)imageView.tag-image_tag;
     NSLog(@"触摸更多click%i",click);
    if (self.selectedIndex==click) {
        return;
    }
  
    if (self.photoClick)
    {
     self.photoClick(imageView.image);
    }
    

}
#pragma mark 点击图片
-(void)photoClick:(UIImage *)image
{
    if (self.photoClick) {
        self.photoClick(image);
    }
}

#pragma mark 触摸更多
-(void)moreClick:(UITapGestureRecognizer *)gesture
{
    if (self.moreClick) {
        self.moreClick();
    }
    NSLog(@"触摸更多");
}
@end
