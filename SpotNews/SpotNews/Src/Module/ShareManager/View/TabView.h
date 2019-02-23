//
//  TabView.h
//  JinShi
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 jin10.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TabViewClick)(int index);
@interface TabView : UIView

-(id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray picArr:(NSArray *)picArr picArrhighlighted:(NSArray *)picArrhighlighted;
@property(nonatomic,copy) TabViewClick clickBlock;
@property(nonatomic,assign) int selectedIndex;
@end
