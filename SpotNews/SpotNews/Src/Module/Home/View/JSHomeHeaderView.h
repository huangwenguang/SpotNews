//
//  HeaderView.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/13.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZCarGroup.h"
#import "MsgSectionObject.h"


@interface JSHomeHeaderView : UIView
+ (instancetype)sharedInstance;
@property (nonatomic, strong)  UIView *view;
-(void)initWithFrame:(CGRect)frame msgSectionObject:(MsgSectionObject *)msgSectionObject;
-(void)initWithFrame1:(CGRect)frame carGroup:(CZCarGroup *)carGroup;
@end
