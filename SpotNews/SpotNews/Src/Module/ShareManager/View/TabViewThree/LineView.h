//
//  LineView.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/28.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+helper.h"


@interface LineView : UIView
@property(nonatomic,strong) NSString *colorStr;
-(id)initWithLineFrame:(CGRect)frame colorstr :(NSString *)colorstr;
- (void)drawUIBezierPathState:(CGRect)rect colorstr :(NSString *)colorstr;
@end
