//
//  MoreController.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSBaseViewController.h"


@interface JSMoreController : JSBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, strong) UITableView *mytableview;
@end
