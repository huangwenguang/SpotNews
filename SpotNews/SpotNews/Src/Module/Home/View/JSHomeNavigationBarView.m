//
//  JSNavigationBarVIew.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/15.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSHomeNavigationBarView.h"
#define k_btn_tag 300
#define k_spacingx 20
#define k_underLinew 70
@interface JSHomeNavigationBarView()
{
    NSArray *titleArray;
    UIView *underLine;
    float pix;
}
@end

@implementation JSHomeNavigationBarView

-(id)initWithFrame:(CGRect)frame titleArray:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self)
    {
         titleArray=[NSArray arrayWithArray:arr];
        pix=frame.size.width/(titleArray.count*1.0f);
     UIScrollView   *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        scrollView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navView"]];
        [self addSubview:scrollView];
        for (int i=0;i<titleArray.count;i++) {
            NSString *title=[titleArray objectAtIndex:i];
            UIButton *btn=[[UIButton alloc] init];
            btn.tag=k_btn_tag+i;
            [btn setFrame:CGRectMake(pix*i, 0, pix, frame.size.height)];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[CommonUtils translateHexStringToColor:@"#858585"] forState:UIControlStateNormal];
            
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn addTarget:self action:@selector(sortClick:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
        }
        underLine=[[UIView alloc] initWithFrame:CGRectMake(30, frame.size.height-2,pix, 2)];
        [underLine setBackgroundColor:[CommonUtils translateHexStringToColor:@"#ff7f66"]];
        [scrollView addSubview:underLine];
    }
    return self;
}
-(void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex=selectedIndex;
    UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+selectedIndex];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if(selectedIndex==0)
    {
        underLine.frame=CGRectMake(k_spacingx,underLine.frame.origin.y,k_underLinew, 2);

    }else
    {
    underLine.frame=CGRectMake(k_spacingx+pix*selectedIndex,underLine.frame.origin.y,k_underLinew, 2);
    }
    
}
-(void)sortClick:(UIButton *)sender
{
    int click=(int)sender.tag-k_btn_tag;
    if (self.selectedIndex==click) {
        return;
    }
    UIButton *btn= (UIButton *)[self viewWithTag:k_btn_tag+self.selectedIndex];
    [btn setTitleColor:[CommonUtils translateHexStringToColor:@"#858585"] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if(click==0)
                         {
                             underLine.frame=CGRectMake(k_spacingx,underLine.frame.origin.y,k_underLinew, 2);
                             
                         }else
                         {
                             
                             underLine.frame=CGRectMake(k_spacingx+pix*click,underLine.frame.origin.y,k_underLinew, 2);
                         }
                    
                        
                     } completion:^(BOOL finished) {
                         
                     }];
    _selectedIndex=click;
    if (self.clickBlock) {
        self.clickBlock(_selectedIndex);
    }
}
@end
