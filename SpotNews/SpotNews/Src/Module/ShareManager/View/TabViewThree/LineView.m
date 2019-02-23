//
//  LineView.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/28.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "LineView.h"

@implementation LineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithLineFrame:(CGRect)frame colorstr :(NSString *)colorstr
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        NSLog(@"frame.size.width%f",frame.size.width);
        self.colorStr=colorstr;
        NSLog(@"self.colorStr%@",self.colorStr);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawUIBezierPathState:rect colorstr:self.colorStr];
   
}
- (void)drawUIBezierPathState:(CGRect)rect colorstr :(NSString *)colorstr
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    
    [path addLineToPoint:CGPointMake(rect.size.width,rect.origin.y)];
    path.lineWidth =3;
    [[UIColor colorWithHexString:colorstr withAlpha:1] set];
    
    [path stroke];
    
}
@end
