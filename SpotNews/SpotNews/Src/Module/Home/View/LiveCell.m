//
//  LiveCell.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "LiveCell.h"
#import <QuartzCore/QuartzCore.h>
@interface LiveCell ()
{
    CGFloat row_h;
}
@end
@implementation LiveCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType=UITableViewCellAccessoryNone;
     
        self.selectView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,tableView.rowHeight)];
        self.selectView.backgroundColor=[UIColor whiteColor];
         self.selectView.alpha=0.2;
        self.selectedBackgroundView = self.selectView;

        self.bg=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,tableView.rowHeight)];
        self.bg.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.bg];
        row_h=tableView.rowHeight;
     
        
        [self UICommBulid];
        
         // 图片
        CGFloat pic_image_w=50;
        CGFloat pic_image_h=50;
        self.pic_image=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.timeView.frame),CGRectGetMaxY(self.context_label.frame)+10,pic_image_w,pic_image_h)];
        [self.pic_image setImage:[UIImage imageNamed:@"dropdown_anim__0001"]];
        [self.bg addSubview:self.pic_image];
        
        
    }
    return self;
}
#pragma mark 公共
-(void)UICommBulid
{
    //标点
    CGFloat x=20;
    CGFloat y=15;
    CGFloat w=8;
    CGFloat h=8;
    self.live_leftSmall=[[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
    [self.live_leftSmall setImage:[UIImage imageNamed:@"live_leftSmall"]];
    [self.bg addSubview:self.live_leftSmall];
    
    CGFloat line_right_y=18;
    CGFloat line_right_w=50;
    self.line_right_image=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.live_leftSmall.frame), line_right_y,line_right_w, 1)];
    self.line_right_image.image=[UIImage imageNamed:@"Nav_bg"];
    [self.bg addSubview:self.line_right_image];
    
    //时间
    CGFloat time_label_y=10;
    self.timeView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.line_right_image.frame)-30,time_label_y,64, 17)];
    self.timeView.backgroundColor=[UIColor whiteColor];
    [self.bg addSubview:self.timeView];
    
    self.time_image=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.timeView.frame.size.width,self.timeView.frame.size.height)];
    self.time_image.image=[UIImage imageNamed:@"live_leftSmallBack"];
    //        self.time_label.layer.cornerRadius = 8;
    //        self.time_label.layer.masksToBounds = YES;
    [self.timeView addSubview: self.time_image];
    
    self.time_label=[[UILabel alloc] initWithFrame:CGRectMake(0,0,self.timeView.frame.size.width,self.timeView.frame.size.height)];
    [self.time_label setTextColor:[UIColor blueColor]];
    self.time_label.text=@"12:32:12";
    [self.time_label setFont:[UIFont systemFontOfSize:13]];
    self.time_label.textAlignment=NSTextAlignmentCenter;
    [self.timeView addSubview:self.time_label];
    
    
    //下边线
    CGFloat line_label_x=24;
    CGFloat line_label_h=row_h;
    self.line_image=[[UIImageView alloc] initWithFrame:CGRectMake(line_label_x,CGRectGetMaxY(self.live_leftSmall.frame),1,line_label_h)];
    self.line_image.image=[UIImage imageNamed:@"Nav_bg"];
    [self.bg addSubview:self.line_image];
    
    
    //内容
    
    CGFloat context_label_w=self.bg.frame.size.width-(CGRectGetMinX(self.timeView.frame)+5)-20;
    self.context_label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.timeView.frame)+5,CGRectGetMaxY(self.timeView.frame)+10,context_label_w, 21)];
    self.context_label.text=@"飞行";
    self.context_label.numberOfLines=0;
    [self.context_label setLineBreakMode:NSLineBreakByWordWrapping];
    [self.context_label setFont:[UIFont systemFontOfSize:13]];
  //  [self.context_label setTextColor:[UIColor redColor]];
    self.context_label.backgroundColor=[UIColor clearColor];
    self.context_label.textAlignment=NSTextAlignmentLeft;
    [self.bg addSubview:self.context_label];

}

- (id)initWithDataStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType=UITableViewCellAccessoryNone;
        
        self.selectView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,tableView.rowHeight)];
        self.selectView.backgroundColor=[UIColor whiteColor];
        self.selectView.alpha=0.2;
        self.selectedBackgroundView = self.selectView;
        
        self.bg=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,tableView.rowHeight)];
        self.bg.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.bg];
        row_h=tableView.rowHeight;
        
        
        [self UICommBulid];
        [self UIPrivateBulid];
        
    
        
        
    }
    return self;

}
#pragma mark私有
-(void)UIPrivateBulid
{
    float h=row_h-CGRectGetMaxY(self.context_label.frame);
    CGFloat spacing_x=5;
     CGFloat before_label_w=64;
    self.bottomView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.context_label.frame), CGRectGetMaxY(self.context_label.frame), self.context_label.frame.size.width,h)];
    self.bottomView.backgroundColor=[UIColor clearColor];
       [self.bg addSubview:self.bottomView];
    

    CGFloat star_w=11;
    CGFloat star_h=11;
    CGFloat s_spacing_x=3;
    self.starView=[[UIView alloc] initWithFrame:CGRectMake(0,h-star_h,star_w*5+s_spacing_x*4,star_h)];
    self.starView.backgroundColor=[UIColor clearColor];
    [self.bottomView addSubview:self.starView];
     //星
    CGFloat x=0;
    for (int i=1; i<=5; i++) {
        
        self.starImage=[[UIImageView alloc] initWithFrame:CGRectMake(x,0,star_w,self.starView.frame.size.height)];
        self.starImage.image=[UIImage imageNamed:@"calender_gray"];
        self.starImage.tag=i;
        [self.starView addSubview:self.starImage];
        x=CGRectGetMaxX(self.starImage.frame)+s_spacing_x;
    }

    CGFloat b_h=15;
    CGFloat b_w=50;
    self.silverbtn=[[UIButton alloc] initWithFrame:CGRectMake(self.bottomView.frame.size.width-2*b_w-10, h-b_h,b_w,b_h)];
    self.silverbtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [self.silverbtn setTitle:@"利空 金银" forState:UIControlStateNormal];
    [self.silverbtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.silverbtn.layer.cornerRadius = 2;
    self.silverbtn.layer.borderWidth=0.5;
    self.silverbtn.layer.borderColor=[UIColor greenColor].CGColor;
    self.silverbtn.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.silverbtn];
    
    
    
    
    
    //前值
    CGFloat before_label_y=CGRectGetMinY(self.starView.frame)-30;
    self.before_label=[[UILabel alloc] initWithFrame:CGRectMake(0,before_label_y,before_label_w, 17)];
    self.before_label.text=@"前值:2.3%";
    self.before_label.font=[UIFont systemFontOfSize:11];
    self.before_label.backgroundColor=[UIColor whiteColor];
    [self.bottomView addSubview:self.before_label];
    
    //预期
    
  
    self.expected_label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.before_label.frame)+spacing_x,before_label_y,before_label_w, 17)];
    self.expected_label.text=@"预期:1.1%";
    self.expected_label.font=[UIFont systemFontOfSize:11];
    self.expected_label.backgroundColor=[UIColor whiteColor];
    self.expected_label.textAlignment=NSTextAlignmentCenter;
    [self.bottomView addSubview:self.expected_label];
    
    //公布
    CGFloat published_label_w=27;
    self.published_label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.expected_label.frame)+2*spacing_x,before_label_y,published_label_w, 17)];
    self.published_label.text=@"公布:";
    self.published_label.font=[UIFont systemFontOfSize:11];
    self.published_label.backgroundColor=[UIColor whiteColor];
    [self.bottomView addSubview:self.published_label];
    
    //公布值
    CGFloat publishedValue_label_w=30;
    self.publishedValue_label=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.published_label.frame),before_label_y,publishedValue_label_w, 17)];
    self.publishedValue_label.text=@"1.1%";
    self.publishedValue_label.backgroundColor=[UIColor clearColor];
    self.publishedValue_label.font=[UIFont systemFontOfSize:11];
    [self.publishedValue_label setTextColor:[UIColor redColor]];
    
    [self.bottomView addSubview:self.publishedValue_label];
    
    CGFloat c_w=31;
    CGFloat c_h=31;
    CGFloat c_y=CGRectGetMinY(self.publishedValue_label.frame)-5;
    self.countryImage=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.publishedValue_label.frame)+15,c_y,c_w,c_h)];
    self.countryImage.image=[UIImage imageNamed:@"美国"];
  
    [self.bottomView addSubview:self.countryImage];

}

-(void)setMsgAllObject:(MsgAllObject *)msgAllObject
{
    _msgAllObject=msgAllObject;
   

//    if(msgAllObject.pic)
//    {
//        self.pic_image.hidden=NO;
//         self.pic_image.image = [UIImage imageNamed:msgAllObject.pic];
//    }else {
//        self.pic_image.hidden = YES;
//    }
      self.context_label.text=msgAllObject.content;
//    // 强制布局
    [self layoutIfNeeded];
//    if (self.pic_image.hidden) { // 没有配图
//        msgAllObject.cellHeight = CGRectGetMaxY(self.context_label.frame) + 10;
//    } else { // 有配图
//        msgAllObject.cellHeight = CGRectGetMaxY(self.pic_image.frame) + 10;
//    }
}
- (void)layoutSubviews
{

    self.context_label.preferredMaxLayoutWidth = self.bg.frame.size.width-(CGRectGetMinX(self.timeView.frame)+5)-20;
}

@end
