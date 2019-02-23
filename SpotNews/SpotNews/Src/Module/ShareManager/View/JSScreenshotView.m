//
//  ScreenshotView.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/19.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSScreenshotView.h"

@implementation JSScreenshotView
+(instancetype)screenshotView {
    static JSScreenshotView *screenshot= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenshot = [[JSScreenshotView alloc] init];
        
    });
    return screenshot;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame image:(UIImage *)image;

{
    if (self==[super initWithFrame:frame]) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
         view.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [view addGestureRecognizer:singleTap1];
        view.backgroundColor=[UIColor grayColor];
        [self addSubview:view];
        //添加显示
        UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image];
        imgvPhoto.frame = CGRectMake(0,0,view.frame.size.width,view.frame.size.height-30);
        //添加边框
        CALayer * layer = [imgvPhoto layer];
        layer.borderColor = [[UIColor grayColor] CGColor];
        layer.borderWidth = 5.0f;
         [view addSubview:imgvPhoto];
        CGFloat x=(view.frame.size.width-30)*0.5;
        UILabel *share=[[UILabel alloc] initWithFrame:CGRectMake(x,CGRectGetMaxY(imgvPhoto.frame),30,25)];
        share.text=@"分享";
        share.textColor=[UIColor whiteColor];
        share.font=[UIFont systemFontOfSize:15];
        [view addSubview:share];

}
return self;
}
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
  if(self.screenshotClick)
  {
      self.screenshotClick();
  }
    
}

- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}
/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

@end
