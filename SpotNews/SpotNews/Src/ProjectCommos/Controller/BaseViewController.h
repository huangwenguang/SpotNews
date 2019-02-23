//
//  BaseViewController.h
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoNetworkView.h"
#import "AFNetworking.h"
//#define ISShow_NSLog 1  //发布时注释
#ifdef ISShow_NSLog
#define NSLogEx(format, ...)  \
NSLog(@"file:%s line:%d\nNSLog:"format,strrchr(__FILE__,'/'),__LINE__, ## __VA_ARGS__)
#else
#define NSLogEx(format, ...)
#endif
@interface BaseViewController : UIViewController
+(instancetype)sharedBase;
@property(nonatomic,assign) CGRect viewBounds;
-(void)showBackBtn;
-(void)hideBackBtn;
-(void)backBtnClick;
-(void) showAlert:(NSString*) title message:(NSString*) message;
-(void) showLoading;
-(void) showLoadingWithText:(NSString *) text;
-(void) hideLoading;
-(void) showErrorWithText:(NSString *) text;
-(void) showSuccessWithText:(NSString*) text;
-(void) showSuccessWithTextTypeNone:(NSString*) text;
-(void) showSuccessWithTextTypeGradient:(NSString*) text;
-(void)httpRequestStatus:(CommonReturnIntegerBlock)returnValue;
-(void)httpRequestStatus;
- (BOOL) isBlankString:(NSString *)string;
@property(nonatomic,assign) NSInteger AFNetworkReachabilityStatus;
@property(nonatomic,strong) NoNetworkView *noNetworkView;
@property(nonatomic,strong)  UIWindow *keyv;
@property(nonatomic,assign) BOOL isTabBarView;

@end
