//
//  MoreController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSMoreController.h"
#import "InterfaceModel.h"
#import "JSExampleViewController.h"
#import "JSExampleViewController1.h"
#import "JSExampleViewController2.h"
#import "JSExampleViewController3.h"
#import "JSExampleViewController4.h"
#import "JSExampleViewController5.h"
#import "JSExampleViewController6.h"
#import "LoginViewController.h"
@interface JSMoreController (){
  UIButton *rightbtn;
}

@end
@implementation JSMoreController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    self.title=@"更多";
    [self navigationView];
    [self dataJSON];
    [self tableViewInit];
}
-(void)navigationView
{
    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(15, 5, 38, 38);
    [rightbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [rightbtn addTarget: self action: @selector(loginAction:) forControlEvents: UIControlEventTouchUpInside];
    [rightbtn setBackgroundColor:[UIColor clearColor]];

    [rightbtn setTitleColor:[CommonUtils translateHexStringToColor:@"#696969"] forState:UIControlStateNormal];
    // [rightbtn setAdjustsImageWhenHighlighted:NO];
    UIBarButtonItem *determine=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem=determine;
    
}
-(void)loginAction:(UIButton *)sender
{
//    LoginViewController *loginViewController=[[LoginViewController alloc] init];
    LoginViewController *login=[[LoginViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:^{
        
    }];

}
-(void)tableViewInit
{
    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBoundsTabbarFrame) style:UITableViewStylePlain];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.backgroundColor =[UIColor clearColor];
    
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
-(void)dataJSON
{
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"More" ofType:@"plist"]];
    self.data = [NSMutableArray array];
    
    for (NSDictionary *dict in dictArray) {
        InterfaceModel *interfaceModel = [InterfaceModel interfaceWithDict:dict];
        [self.data addObject:interfaceModel];
        
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
    [[JSBaseViewController sharedInstance] setExtraCellLineHidden:tableView];
    return cell;
}

#pragma mark - UITableView 代理方法
#pragma mark 设置某一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.row % 2== 0) {
    //        return 100;
    //    }
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
        case 108:
        {
            JSExampleViewController *exampleViewController=[[JSExampleViewController alloc] init];
            [self.navigationController pushViewController:exampleViewController animated:NO];
            break;
            
        }
        case 109:
        {
            JSExampleViewController1 *exampleViewController1=[[JSExampleViewController1 alloc] init];
            [self.navigationController pushViewController:exampleViewController1 animated:NO];
            break;
            
        }
        case 110:
        {
            JSExampleViewController2 *exampleViewController2=[[JSExampleViewController2 alloc] init];
            [self.navigationController pushViewController:exampleViewController2 animated:NO];
            break;
            
        }
        case 111:
        {
            JSExampleViewController3 *exampleViewController3=[[JSExampleViewController3 alloc] init];
            [self.navigationController pushViewController:exampleViewController3 animated:NO];
            break;
            
        }
        case 112:
        {
            JSExampleViewController4 *exampleViewController4=[[JSExampleViewController4 alloc] init];
            [self.navigationController pushViewController:exampleViewController4 animated:NO];
            break;
            
        }
        case 113:
        {
            JSExampleViewController5 *exampleViewController5=[[JSExampleViewController5 alloc] init];
            [self.navigationController pushViewController:exampleViewController5 animated:NO];
            break;
            
        }
        case 114:
        {
            JSExampleViewController6 *exampleViewController6=[[JSExampleViewController6 alloc] init];
            [self.navigationController pushViewController:exampleViewController6 animated:NO];
            break;
            
        }
            
            
            
        default:
            break;
    }
    // NSLog(@"点击了-section:%i, row:%i", indexPath.section, indexPath.row);
    
    
}

@end
