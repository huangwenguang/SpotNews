//
//  CustomButton.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/31.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PhotoalbumClick)();
@interface CustomButton : UIView
-(id)initWithFrame:(CGRect)frame;
@property(nonatomic,copy) PhotoalbumClick photoalbumClick;
@end
