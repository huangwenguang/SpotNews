//
//  UIImage+Image.h

//
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;


// 快速拉伸图片
+ (instancetype)imageWithStretchableImageName:(NSString *)imageName;

@end
