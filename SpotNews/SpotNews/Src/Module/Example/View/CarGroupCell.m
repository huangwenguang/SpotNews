//
//  CarGroupCell.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/13.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "CarGroupCell.h"

@implementation CarGroupCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self)
     {
        
      
    self.accessoryType=UITableViewCellAccessoryNone;
    self.backgroundColor=[UIColor clearColor];
    UIView *selected = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,40)];
    selected.backgroundColor=[UIColor clearColor];
    self.selectedBackgroundView = selected;
    UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,40)];
    [self addSubview:bg];
    bg.backgroundColor=[UIColor clearColor];
    self.content=[[UILabel alloc] initWithFrame:CGRectMake(160,0,100,bg.frame.size.height)];
    [self.content setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.content.backgroundColor=[UIColor redColor];
    self.content.font=[UIFont boldSystemFontOfSize:14];
    [bg addSubview:self.content];
    
   }
    return self;
}

-(void)setCellValue:(NSString *)content
{
    self.content.text=content;

}

@end
