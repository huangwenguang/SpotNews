//
//  DrawView.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/28.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawPath.h"

@interface DrawView : UIView
@property (nonatomic, strong) UIColor *pathColor;
@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) DrawPath *path;

@property (nonatomic, strong) NSMutableArray *paths;


#pragma mark清屏
-(void)clear;
#pragma mark 撤销
-(void)undo;

@end
