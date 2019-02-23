//
//  TabView.m
//  JinShi
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 jin10.com. All rights reserved.
//

#import "TabView.h"
#define k_btn_tag 10
#define k_title_tag 20
#define k_spacingx 70
@interface TabView()
{

    NSArray *titleArrays;
    NSArray *picArrs;
    NSArray *picArrhighlighteds;
    float pix;
    UIView *underLine;
}
@end
@implementation TabView
-(id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray picArr:(NSArray *)picArr picArrhighlighted:(NSArray *)picArrhighlighted
{
    if (self==[super initWithFrame:frame]) {

        
        titleArrays=[NSArray arrayWithArray:titleArray];
        picArrs=[NSArray arrayWithArray:picArr];
        picArrhighlighteds=[NSArray arrayWithArray:picArrhighlighted];
       CGFloat w=(frame.size.width-k_spacingx*2);
        pix=w/(titleArrays.count*1.0f);
            for (int i=0;i<titleArrays.count;i++) {

                NSString *title=[titleArray objectAtIndex:i];
                UIButton *btn=[[UIButton alloc] init];
                btn.tag=k_btn_tag+i;
                CGFloat y=0.0f;
                CGFloat b_h=frame.size.height;
                [btn setFrame:CGRectMake(k_spacingx+pix*i,y, pix,b_h)];
                btn.backgroundColor=[UIColor clearColor];
                UIImage *image=[UIImage imageNamed:[picArrs objectAtIndex:i]];
                [btn setImage:image forState:UIControlStateNormal];
                btn.imageEdgeInsets=UIEdgeInsetsMake(-5,0,0,0);
                [btn addTarget:self action:@selector(sortClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.titleLabel.font=[UIFont systemFontOfSize:10];
                [self addSubview:btn];

                
                CGSize size=[title sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10]}];
                UILabel *titleStr=[[UILabel alloc]init];
                    [btn addSubview:titleStr];
                [titleStr setFrame:CGRectMake(0,btn.frame.size.height-size.height,pix,size.height)];
                [titleStr setFont:[UIFont systemFontOfSize:10]];
                titleStr.tag=k_title_tag+i;
                [titleStr setTextColor:[CommonUtils translateHexStringToColor:@"#858585"]];
                titleStr.textAlignment=NSTextAlignmentCenter;
                titleStr.text=title;
            
                
            }
        CGFloat underLineX=k_spacingx+((pix-10)*0.5);
        underLine=[[UIView alloc] initWithFrame:CGRectMake(underLineX,0, 10, 2)];
        [underLine setBackgroundColor:[CommonUtils translateHexStringToColor:@"#ff7f66"]];
               [self addSubview:underLine];

    }
    return self;
}

-(void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex=selectedIndex;
    UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+ self.selectedIndex];
    [btn setImage:[UIImage imageNamed:[picArrhighlighteds objectAtIndex:selectedIndex]] forState:UIControlStateNormal];
    UILabel *title= (UILabel *)[self viewWithTag:k_title_tag+ self.selectedIndex];
    [title setTextColor:[CommonUtils translateHexStringToColor:@"#15b01a"]];


}
-(void)sortClick:(UIButton *)sender
{
    int click=(int)sender.tag-k_btn_tag;
    if (self.selectedIndex==click) {
        return;
    }
    UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+ self.selectedIndex];
    [btn setImage:[UIImage imageNamed:[picArrs objectAtIndex:self.selectedIndex]] forState:UIControlStateNormal];
    UILabel *title= (UILabel *)[self viewWithTag:k_title_tag+ self.selectedIndex];
    [title setTextColor:[CommonUtils translateHexStringToColor:@"#858585"]];
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        CGFloat x=k_spacingx+((pix-10)*0.5)+pix*click;
                         underLine.frame=CGRectMake(x,0, 10, 2);
                     } completion:^(BOOL finished) {
                         
                     }];

    self.selectedIndex=click;
    if (self.clickBlock) {
        self.clickBlock(self.selectedIndex);
    }


}



@end
