//
//  TabViewThree.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"
typedef void(^ViewTwoClick)(int index,NSString *colorValue);
typedef void(^ViewOneClick)(int index,NSInteger valueChange);
typedef void(^ClearClick)();

@interface TabViewThree : UIScrollView
-(id)initWithThreeFrame:(CGRect)frame;
@property(nonatomic,copy) ViewTwoClick viewTwoClick;
@property(nonatomic,assign) int penIndex;
@property(nonatomic,strong) NSArray *colorArray;

@property(nonatomic,copy) ViewOneClick viewOneClick;
@property(nonatomic,assign) int btnIndex;

@property(nonatomic,copy) ClearClick clearClick;

@end
