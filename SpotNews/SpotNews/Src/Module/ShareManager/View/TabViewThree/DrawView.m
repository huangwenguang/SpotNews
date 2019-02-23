//
//  DrawView.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/28.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "DrawView.h"
@interface DrawView ()



@end

@implementation DrawView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setImage:(UIImage *)image
{
     _image=image;
    [self.paths addObject:_image];
    [self setNeedsDisplay];//重绘

}
-(void)clear
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];

}

-(void)undo
{
    [self.paths removeLastObject];
     [self setNeedsDisplay];
}


-(NSMutableArray *)paths
{
    if(_paths==nil)
    {
        _paths=[NSMutableArray array];
    
    }
    return _paths;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
// 初始化设置
- (void)setUp
{
    // 添加pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
  
    
    _lineWidth = 1;
    _pathColor = [UIColor redColor];
}
#pragma mark 当手指拖动的时候调用
-(void)pan:(UIPanGestureRecognizer *)pan
{
    //获取当前手指触摸点
    CGPoint curP=[pan locationInView:self];
    //获取开始点
    if(pan.state==UIGestureRecognizerStateBegan)
    {
        //创建贝瑟尔路径
        self.path=[[DrawPath alloc] init];
        //设置线宽
        self.path.lineWidth=self.lineWidth;
        //给路径设置颜色
       self.path.pathColor=self.pathColor;
        // 设置路径的起点
        [self.path moveToPoint:curP];
        //保存描述好的路径
        [self.paths addObject:self.path];
    
    }
    //添加线到当前触摸点
    [self.path addLineToPoint:curP];
    //重绘
    [self setNeedsDisplay];

}
#pragma mark 只要调用drawRect 方法就会把之前的内容全部清空
-(void)drawRect:(CGRect)rect
{
for(DrawPath *path in self.paths)
{

     if([path isKindOfClass:[UIImage class]])
     {
         //绘制图片
         UIImage *image=(UIImage *)path;
         [image drawInRect:rect];
     }else
     {
         //画线
         [path.pathColor set];
         [path stroke];
     }
}
}

@end
