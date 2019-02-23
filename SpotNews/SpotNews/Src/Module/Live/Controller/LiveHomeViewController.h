//
//  LiveHomeViewController.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/19.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSBaseViewController.h"

@interface LiveHomeViewController : JSBaseViewController<UIScrollViewDelegate>
@property (nonatomic,retain)  UIScrollView *titleScrollViews;
@property (nonatomic,retain)  UIScrollView *contentScrollView;
@end
