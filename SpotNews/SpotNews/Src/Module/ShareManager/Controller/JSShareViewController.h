//
//  ShareViewController1.h
//  JinShi
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 jin10.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"


@interface JSShareViewController :JSBaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
+(instancetype)sharedBase;
-(void)buildTabView;
@property (nonatomic, strong) UIImage *pic_image;
@property (nonatomic, strong)  UIScrollView *scrollView_two;
@property (nonatomic, strong) UIImageView *scroll_imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *delbut;
-(void)photoAction:(UIImage *)image;
@property (nonatomic, strong) NSMutableArray *dataImage;

@end


