//
//  ExampleViewController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/12.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSExampleViewController6.h"
#import "InterfaceModel.h"
#import "CZCarGroup.h"
#import "JSHomeHeaderView.h"
#import "CarGroupCell.h"
static NSString *cellIndentify=@"cell";

@interface JSExampleViewController6 ()

@end

@implementation JSExampleViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTabBarView=NO;
    [self showBackBtn];
    self.title=@"首页";
    self.view.backgroundColor=[UIColor clearColor];
   // [self dataJSON];
    [self tableViewInit];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableViewInit
{

    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBounds) style:UITableViewStylePlain];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mytableview.backgroundColor =[UIColor clearColor];
    [self setExtraCellLineHidden:self.mytableview];
    self.mytableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.mytableview.mj_header endRefreshing];
        });
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mytableview.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.mytableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.mytableview.mj_footer endRefreshing];
        });
    }];
    [self.view addSubview:self.mytableview];
    
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData1
{
     [self.mytableview reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
         [self.mytableview.mj_header endRefreshing];
    });
    
    

}
- (void)loadNewData
{
    [self.mytableview reloadData];
    [self.mytableview.mj_footer endRefreshing];
    
}

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [CZCarGroup carGroupsList];
    }
    return _data;

}

-(void)dataJSON
{
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars_simple" ofType:@"plist"]];
    self.data = [NSMutableArray array];
    
    for (NSDictionary *dict in dictArray) {
        InterfaceModel *interfaceModel = [InterfaceModel interfaceWithDict:dict];
        [self.data addObject:interfaceModel];
        
    }
    
    
}

-(void)viewDidLayoutSubviews {
    
    if ([self.mytableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mytableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.mytableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.mytableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.data = nil;
}

- (void)dealloc {
    self.data = nil;
}
//4 实现数据源的方法
#pragma mark - 数据源的方法
// 返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}
//返回每一组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CZCarGroup *carGroup = self.data[section];
    return carGroup.cars.count;
}
//返回每一行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    CarGroupCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentify];
   
    if (cell==nil) {
        
        cell=[[CarGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentify];
        
    }
//    CGRect cellFrame = [cell.contentView frame];
//    cellFrame.origin=CGPointMake(0, -40);
//    [cell.contentView setFrame:cellFrame];
  
    //2 给cell内部的子控件赋值
    CZCarGroup *carGroup = self.data[indexPath.section];
    [cell setCellValue:carGroup.cars[indexPath.row]];
       //3 返回cell
    

    return cell;
}

#pragma mark 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
#pragma mark 自定义头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CZCarGroup *carGroup = self.data[section];
  [[JSHomeHeaderView sharedInstance] initWithFrame1:CGRectMake(0, 0,SCREEN_WIDTH,40) carGroup:carGroup];
  return [JSHomeHeaderView sharedInstance].view;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)];
//     view.backgroundColor=[UIColor clearColor];
//    UIView *back=[[UIView alloc] initWithFrame:CGRectMake(8, 0, 150, 40)];
//    back.backgroundColor=[UIColor whiteColor];
//    back.layer.borderColor=[CommonUtils translateHexStringToColor:@"#107bcf"].CGColor;
//    back.layer.borderWidth=1;
//    back.layer.masksToBounds=YES;
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, back.frame.size.width, back.frame.size.height)];
//    
//    label.textColor = [UIColor redColor];
//    
//    label.backgroundColor = [UIColor clearColor];
//    
//    label.text = carGroup.title;
//    
//    [back addSubview:label];
//    [view addSubview:back];
//    return view;
    
}
#pragma mark 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}


@end
