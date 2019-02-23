//
//  TabViewTwo.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MoreClick)();
typedef void(^PhotoClick)(UIImage *image);
@interface TabViewTwo : UIView
-(id)initWithTwoFrame:(CGRect)frame dataImage:(NSMutableArray *)dataImage;
@property(nonatomic,copy) MoreClick moreClick;
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,copy) PhotoClick photoClick;

@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,strong)UIImageView* imageView;
@end
