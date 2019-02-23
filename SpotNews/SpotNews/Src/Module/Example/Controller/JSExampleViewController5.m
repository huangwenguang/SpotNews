//
//  ExampleViewController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/12.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSExampleViewController5.h"
#import "InterfaceModel.h"
#import "CZCarGroups.h"

@interface JSExampleViewController5 ()

@end

@implementation JSExampleViewController5
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTabBarView=NO;
    [self showBackBtn];
    self.title=@"表格6分组";
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

    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBounds) style:UITableViewStyleGrouped];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
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

-(NSArray *)data
{
    if (_data == nil) {
        _data = [CZCarGroups carGroupsList];
    }
    return _data;

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
    CZCarGroups *carGroup = self.data[section];
    return carGroup.cars.count;
}
//返回每一行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建可重用cell对象
    static NSString *reuseId = @"car";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    //2 给cell内部的子控件赋值
    //
    CZCarGroups *carGroup = self.data[indexPath.section];
    
    cell.textLabel.text = [carGroup.cars[indexPath.row] name];
    cell.imageView.image = [UIImage imageNamed:[carGroup.cars[indexPath.row] icon]];
    
    
    //3 返回cell
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    CZCarGroup *carGroup = self.carGroups[section];
    //    return carGroup.title;
    return [self.data[section] title];
}
//返回组的索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //kvc
    return [self.data valueForKeyPath:@"title"];
}

@end
