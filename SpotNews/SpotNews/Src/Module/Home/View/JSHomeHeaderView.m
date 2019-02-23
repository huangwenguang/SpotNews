//
//  HeaderView.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/13.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSHomeHeaderView.h"

@implementation JSHomeHeaderView

#pragma mark - 单例
static id instance_;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}
-(void)initWithFrame:(CGRect)frame msgSectionObject:(MsgSectionObject *)msgSectionObject;
{

       self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)];
        self.view.backgroundColor=[UIColor clearColor];
        UIView *back=[[UIView alloc] initWithFrame:CGRectMake(8, 0,30, 32)];
        back.backgroundColor=[UIColor whiteColor];
        back.layer.borderColor=[CommonUtils translateHexStringToColor:@"#107bcf"].CGColor;
        back.layer.borderWidth=1;
        back.layer.masksToBounds=YES;
      [self.view addSubview:back];
    
      CGFloat y=1;
     CGFloat h=18;
      UILabel *lbDay = [[UILabel alloc] initWithFrame:CGRectMake(0, y,back.frame.size.width, h)];
      lbDay.textAlignment=NSTextAlignmentCenter;
      lbDay.textColor=[CommonUtils translateHexStringToColor:@"#107bcf"];
     // lbDay.text=[msgSectionObject.sectionTime formatWithFormatString:@"dd"];
      lbDay.text=@"18";
      lbDay.font=[UIFont boldSystemFontOfSize:16];
     [back addSubview:lbDay];
    
    
    CGFloat m_y=CGRectGetMaxY(lbDay.frame);
    CGFloat m_h=15;
    UILabel *lbMon=[[UILabel alloc] initWithFrame:CGRectMake(0,m_y, back.frame.size.width,m_h)];
    lbMon.backgroundColor=[UIColor clearColor];
   // lbMon.text=[NSString stringWithFormat:@"%@月",[msgSectionObject.sectionTime formatWithFormatString:@"M"]];
    lbMon.text=[NSString stringWithFormat:@"%@月",@"4"];
    lbMon.font=[CommonUtils getFanTiFont:11];
    lbMon.textColor=[CommonUtils translateHexStringToColor:@"#107bcf"];
    lbMon.textAlignment=NSTextAlignmentCenter;

   
    [back addSubview:lbMon];
  
    
}

-(void)initWithFrame1:(CGRect)frame carGroup:(CZCarGroup *)carGroup
{
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH, 40)];
    self.view.backgroundColor=[UIColor clearColor];
    UIView *back=[[UIView alloc] initWithFrame:CGRectMake(8, 10, 150, 32)];
    back.backgroundColor=[UIColor whiteColor];
    back.layer.borderColor=[CommonUtils translateHexStringToColor:@"#107bcf"].CGColor;
    back.layer.borderWidth=1;
    back.layer.masksToBounds=YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, back.frame.size.width, back.frame.size.height)];
    
    label.textColor = [UIColor redColor];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.text = carGroup.title;
    
    [back addSubview:label];
    [self.view addSubview:back];

    
}

@end
