//
//  ExampleViewController.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/12.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSExampleViewController5 : JSBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, strong) UITableView *mytableview;
@end
