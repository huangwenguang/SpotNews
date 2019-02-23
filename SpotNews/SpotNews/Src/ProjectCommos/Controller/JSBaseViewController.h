//
//  BaseViewController.h
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSNoNetworkView.h"
#import "AFNetworking.h"

@interface JSBaseViewController : UIViewController
+(instancetype)sharedInstance;
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
@property(nonatomic,assign) NSInteger AFNetworkReachabilityStatus;
@property(nonatomic,strong) JSNoNetworkView *noNetworkView;
@property(nonatomic,strong)  UIWindow *keyv;
@property(nonatomic,assign) BOOL isTabBarView;

//tableview尾部多余处理
- (void)setExtraCellLineHidden: (UITableView *)tableView;




@end
