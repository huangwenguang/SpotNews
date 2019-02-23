//
//  JSNewFeatureCell.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSNewFeatureCell.h"

@implementation JSNewFeatureCell
-(UIButton *)startButton
{
    if (_startButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        
        btn.center = CGPointMake(self.width * 0.5, self.height * 0.9);
        
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        _startButton = btn;
        
        [self addSubview:btn];
    }
    return _startButton;
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:imageV];
        
        _imageView = imageV;
    }
    return _imageView;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) {
        self.startButton.hidden = NO;
        
    }else{
        self.startButton.hidden = YES;
    }
}

- (void)start
{
             [[JSTabbarView tabbarView] setupViewControllers];
    [UIApplication sharedApplication].keyWindow.rootViewController =[JSTabbarView tabbarView].viewController;
}


@end
