//
//  InterfaceController.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/18.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//


#import "JSBaseViewController.h"
#import "JSSaveTool.h"
#import "JSPushTokenTool.h"
#import "JSSystemController.h"


@interface InterfaceController :JSBaseViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, strong) UITableView *mytableview;
/**
 * 上传token
 */
- (void)clickToken;
/**
 *  设置标签
 */
- (void)clicksetTagBtn;
/**
 *  地理位置
 */
- (void)clickupdateArea;
/**
 *  绑定用户UID
 */
- (void)clickdeviceUserLogin;
/**
 *  解除绑定用户UID
 */
- (void)clickdeviceUserLogout;
@end
