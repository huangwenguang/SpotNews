//
//  ExampleViewController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/12.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSExampleViewController1.h"
#import "InterfaceModel.h"
#import "MJDIYBackFooter.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface JSExampleViewController1 ()

@end

@implementation JSExampleViewController1


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTabBarView=NO;
    [self showBackBtn];
    self.title=@"表格2";
    self.view.backgroundColor=[UIColor clearColor];
    [self dataJSON];
    [self tableViewInit];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableViewInit
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBounds) style:UITableViewStylePlain];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.backgroundColor =[UIColor clearColor];
    [self setExtraCellLineHidden:self.mytableview];
  //   self.mytableview.mj_header.automaticallyChangeAlpha = NO;
   self.mytableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
          [self.mytableview.mj_header endRefreshing];
    }];
    self.mytableview.mj_footer.hidden=YES;
    // 马上进入刷新状态
  //  [self.mytableview.mj_header beginRefreshing];
    
    self.mytableview.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
 // self.mytableview.mj_footer.automaticallyChangeAlpha = YES;

    [self.view addSubview:self.mytableview];
    
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData1
{
        [self.mytableview reloadData];
        [self.mytableview.mj_header endRefreshing];

}
- (void)loadNewData
{
    [self.mytableview reloadData];
    [self.mytableview.mj_footer endRefreshing];
    
}



-(void)dataJSON
{
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"More" ofType:@"plist"]];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

#pragma mark 每一行显示什么数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // 显示文本
    InterfaceModel *interfaceModel=self.data[indexPath.row];;
    cell.textLabel.text =interfaceModel.interName;
     return cell;
}

#pragma mark - UITableView 代理方法
#pragma mark 设置某一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}
#pragma mark 点击了某一行Cell就会触发这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出Cell的选中效果（去掉默认的蓝色背景）
    // 也就是取消选中这一行
    // YES代表蓝色背景慢慢消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // int row=(int)indexPath.row;
    InterfaceModel *interfaceModel=self.data[indexPath.row];
    int row=[interfaceModel.ID intValue];
    switch (row) {
            
            
        case 100:
        {
            
            break;
            
        }
        case 101:
        {
            
            break;
            
        }
            
        case 102:
        {
            
            break;
        }
            
        case 103:
        {
            
            break;
            
        }
            
        case 104:
        {
            
            break;
            
        }
            
        case 105:
        {
            
            break;
            
        }
        case 106:
        {
            
            break;
            
        }
        case 107:
        {
            
            break;
            
        }
            
            
        default:
            break;
    }
    // NSLog(@"点击了-section:%i, row:%i", indexPath.section, indexPath.row);
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
