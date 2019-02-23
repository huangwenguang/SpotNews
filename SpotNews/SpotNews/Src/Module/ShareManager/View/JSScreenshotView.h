//
//  ScreenshotView.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/19.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ScreenshotClick)(void); //截图分享按钮
@interface JSScreenshotView : UIView
+(JSScreenshotView *)screenshotView;
-(id)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (UIImage *)imageWithScreenshot;
@property(nonatomic,copy) ScreenshotClick screenshotClick;
@end
