//
//  PhotoCollectionViewCell.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"


#define k_viewTage 5000
#define k_saveTag 1000

@implementation PhotoCollectionViewCell

-(void)UIBuild:(NSInteger)index countNum:(NSInteger)countNum
{
    self.countNumber=countNum;
    float t_w=self.contentView.frame.size.width;
    float t_h=self.contentView.frame.size.height;
    
    self.uiVIew=[[UIView alloc] initWithFrame:CGRectMake(0, 0,t_w,t_h)];
      self.uiVIew.backgroundColor=[UIColor whiteColor];

     [self addSubview:  self.uiVIew];
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,   self.uiVIew.frame.size.width,   self.uiVIew.frame.size.height)];
     self.imageView.image=[UIImage imageNamed:@"danjianbao"];
    self.imageView.userInteractionEnabled = YES;

    
//    CALayer *layer=[self.imageView layer];
//    //是否设置边框以及是否可见
//    [layer setMasksToBounds:YES];
//    //设置边框圆角的弧度
//   // [layer setCornerRadius:10.0];
//    //设置边框线的宽
//    [layer setBorderWidth:1];
//    //设置边框线的颜色
//    [layer setBorderColor:[[UIColor grayColor] CGColor]];
       [ self.uiVIew addSubview:self.imageView];
    float w=25;
    float h=25;
    float x=CGRectGetMaxY(self.imageView.frame)-w-5;
    float y=CGRectGetMaxX(self.imageView.frame)-h-5;
    self.saveBtn=[[UIButton alloc] initWithFrame:CGRectMake(x, y,w,h)];
    [self.saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    self.saveBtn.tag=k_saveTag+index;
    self.saveBtn.hidden=YES;
    self.saveBtn.userInteractionEnabled = YES;

    [ self.uiVIew addSubview:self.saveBtn];

}

-(void)setCellValue:(PhotoModel *)photoModel
{
     self.imageView.image=[UIImage imageNamed:photoModel.icon];
}
@end
