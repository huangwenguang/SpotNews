//
//  JSBreakingNewsViewController.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/15.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSBreakingNewsViewController : JSBaseViewController
@property (nonatomic, strong) UITableView *mytableview;
@property (nonatomic, strong) NSArray *templist;
@property(strong,nonatomic) NSMutableArray *newsSectionArray;

@end
