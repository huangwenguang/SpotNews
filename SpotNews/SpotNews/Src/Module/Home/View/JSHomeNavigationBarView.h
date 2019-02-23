//
//  JSNavigationBarVIew.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/15.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSHomeNavigationBarView : UIView
-(id)initWithFrame:(CGRect)frame titleArray:(NSArray *)arr;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,copy) HomeNavigationBarViewClick clickBlock;
@end
