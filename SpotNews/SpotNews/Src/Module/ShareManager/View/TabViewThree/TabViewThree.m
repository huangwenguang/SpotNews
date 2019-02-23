//
//  TabViewThree.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//
#define k_viewOne_tag 20
#define k_btn_tag 30
#define k_btn_array 3
#define k_btn_def 5
#define k_spacing_x 30

#define k_btnpen_tag 40
#define k_viewTwo_tag 50
#define k_btnpen_array 3

#define k_line_w 10

#import "TabViewThree.h"
@interface TabViewThree()
{
    CGRect frame_t;

}
@end
@implementation TabViewThree
-(id)initWithThreeFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        frame_t=frame;
        self.colorArray=[NSArray arrayWithObjects:@"#e50000",@"#89fe05",@"#00ffff", nil];
        UIView *viewOne=[[UIView alloc] initWithFrame:CGRectMake(0,0,frame_t.size.width*0.35,frame_t.size.height)];
        viewOne.backgroundColor=[UIColor clearColor];
        [self addSubview:viewOne];
        CGFloat v_x=0.0f;
        CGFloat v_w=viewOne.frame.size.width/3;
        for (int i=0;i<k_btn_array;i++) {
            
            UIView *uiViewOne=[[UIView alloc] initWithFrame:CGRectMake(v_x,0,v_w,viewOne.frame.size.height)];
             uiViewOne.userInteractionEnabled = YES;
            UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick:)];
             uiViewOne.tag=k_viewOne_tag+i;
             [uiViewOne addGestureRecognizer:tapGesture];
             uiViewOne.backgroundColor=[UIColor clearColor];
             [viewOne addSubview:uiViewOne];
            
            CGFloat h=k_btn_def+i*2;
            CGFloat y=(uiViewOne.frame.size.height-h)*0.5;
            CGFloat w=h;
            CGFloat x=(uiViewOne.frame.size.width-w)*0.5;
            UIButton *btns=[[UIButton alloc] initWithFrame:CGRectMake(x,y,w,h)];
            btns.layer.cornerRadius = btns.bounds.size.width * 0.5;
            btns.layer.masksToBounds =YES;
            btns.tag=k_btn_tag+i;
             if(i==0)
            {
                
                btns.backgroundColor=[UIColor colorWithHexString:self.colorArray[0] withAlpha:1];
            }else
            {
                btns.backgroundColor=[UIColor colorWithHexString:@"#c5c9c7" withAlpha:1];
                
            }

            [uiViewOne addSubview:btns];
            v_x=CGRectGetMaxX(uiViewOne.frame);

        }

        UIView *viewTwo=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewOne.frame),0,frame.size.width*0.45,frame.size.height)];
        viewTwo.backgroundColor=[UIColor clearColor];

        [self addSubview:viewTwo];
        CGFloat p_x=0;
        CGFloat p_w=viewTwo.frame.size.width/3;
           for (int i=0;i<k_btnpen_array;i++) {
            UIView *uiViewTwo=[[UIView alloc] initWithFrame:CGRectMake(p_x,0,p_w,viewTwo.frame.size.height)];
               uiViewTwo.userInteractionEnabled = YES;
            UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(penTapClick:)];
            uiViewTwo.tag=k_viewTwo_tag+i;
            [uiViewTwo addGestureRecognizer:tapGesture];
            uiViewTwo.backgroundColor=[UIColor clearColor];
            [viewTwo addSubview:uiViewTwo];
               
               CGFloat h=30;
               CGFloat y=(frame_t.size.height-h)*0.5-k_line_w*0.5;
               CGFloat w=15;
            CGFloat x=(uiViewTwo.frame.size.width-w)*0.5;
            UIButton *btnpen=[[UIButton alloc] initWithFrame:CGRectMake(x,y,w,h)];
               btnpen.backgroundColor=[UIColor clearColor];
            btnpen.tag=k_btnpen_tag+i;
            [btnpen setImage:[UIImage imageNamed:@"AddressEditor"] forState:UIControlStateNormal];
            [btnpen addTarget:self action:@selector(penClick:) forControlEvents:UIControlEventTouchUpInside];
            p_x=CGRectGetMaxX(btnpen.frame)+35;
            [uiViewTwo addSubview:btnpen];
               
            LineView *lineView=[[LineView alloc] initWithLineFrame:CGRectMake(btnpen.frame.origin.x, CGRectGetMaxY(btnpen.frame), btnpen.frame.size.width, 5) colorstr:self.colorArray[i]];
            [uiViewTwo addSubview:lineView];
            p_x=CGRectGetMaxX(uiViewTwo.frame);
            
        }

        
        UIView *viewThree=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(viewTwo.frame),0,frame.size.width*0.2,frame.size.height)];
        viewThree.userInteractionEnabled = YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delClick:)];
        [viewThree addGestureRecognizer:tapGesture];
        
        viewThree.backgroundColor=[UIColor clearColor];
              [self addSubview:viewThree];
        CGFloat b_h=15;
        CGFloat b_w=20;
        CGFloat b_x=(viewThree.frame.size.width-b_w)*0.5;
        CGFloat b_y=(viewThree.frame.size.height-b_h)*0.5-5;
        
        UIButton *delbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        delbutton.frame=CGRectMake(b_x,b_y,b_w,b_h);
        delbutton.backgroundColor=[UIColor clearColor];
        [delbutton setImage:[UIImage imageNamed:@"deleteIX"] forState:UIControlStateNormal];

        [viewThree addSubview:delbutton];
        UILabel *tuyaLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(delbutton.frame), viewThree.frame.size.width, 20)];
        tuyaLabel.textAlignment = NSTextAlignmentCenter;
        tuyaLabel.text=@"清除涂鸦";
        [tuyaLabel setFont:[UIFont systemFontOfSize:10]];
        //tuyaLabel.textColor=[self translateHexStringToColor:@"#858585"];
        tuyaLabel.textColor=[UIColor blackColor];
        [viewThree addSubview:tuyaLabel];
  
    }
    return self;
}

#pragma mark 圆圈事件
-(void)btnClick:(UITapGestureRecognizer *)gesture
{
 UIView *uiView=(UIView *)gesture.view;
  int click=(int)uiView.tag-k_viewOne_tag;
    NSInteger valueChange=2;
    NSLog(@"圆圈事件%i",click);
    self.btnIndex=click;
    for (int i=0; i<k_btn_array; i++) {
        NSLog(@"iiiii%i",i);
        NSLog(@"self.btnIndex%i",self.btnIndex);
        if(self.btnIndex==i)
        {
            UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+i];
            btn.backgroundColor=[UIColor colorWithHexString:self.colorArray[self.penIndex] withAlpha:1];
        }else
        {
            UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+i];
            btn.backgroundColor=[UIColor colorWithHexString:@"#c5c9c7" withAlpha:1];
        }
  
    }
    switch (self.btnIndex) {
        case 0:
        {
            valueChange=2;
        
        }
            break;
        case 1:
        {
            valueChange=4;
        }
            break;
        case 2:
        {
             valueChange=6;
        }
            break;
            
        default:
            break;
    }

    if (self.viewOneClick) {
        self.viewOneClick(self.btnIndex,valueChange);
    }
  }

#pragma mark 清除涂鸦
- (void)delClick:(UITapGestureRecognizer *)gesture
{
   //gesture.view
    NSLog(@"清除涂鸦");
    if (self.clearClick) {
        self.clearClick();
    }

}

#pragma mark 画笔触摸事件
-(void)penTapClick:(UITapGestureRecognizer *)gesture
{
    UIView *uiView=(UIView *)gesture.view;
    int click=(int)uiView.tag-k_viewTwo_tag;
    NSLog(@"画笔事件%i",click);
    self.penIndex=click;
    [self pendo];
}
#pragma mark 画笔点击事件
-(void)penClick:(id)sender
{
    int click=(int)[sender tag]-k_btnpen_tag;
    NSLog(@"画笔事件%i",click);
    self.penIndex=click;
    [self pendo];
}
-(void)pendo
{
    UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+ self.btnIndex];
    btn.backgroundColor=[UIColor colorWithHexString:self.colorArray[self.penIndex] withAlpha:1];
    if (self.viewTwoClick) {
        self.viewTwoClick(self.penIndex,self.colorArray[self.penIndex]);
    }
    

}

-(UIColor *)translateHexStringToColor:(NSString *)hexColor
{
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])  cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])   cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rColorValue = [cString substringWithRange:range];
    range.location = 2;
    NSString *gColorValue = [cString substringWithRange:range];
    range.location = 4;
    NSString *bColorValue = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rColorValue] scanHexInt:&r];
    [[NSScanner scannerWithString:gColorValue] scanHexInt:&g];
    [[NSScanner scannerWithString:bColorValue] scanHexInt:&b];
    return [UIColor colorWithRed:((CGFloat) r / 255.0f) green:((CGFloat) g / 255.0f) blue:((CGFloat) b / 255.0f) alpha:1.0f];
}





@end
