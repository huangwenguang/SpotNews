//
//  InterfaceController.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/18.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "InterfaceController.h"
#import "JSSignTool.h"
#import "InterfaceModel.h"
#import "JSShareViewController.h"
#import "VideoViewController.h"
#import "LiveHomeViewController.h"

@interface InterfaceController ()
{
    NSString *oldToken;
    
}

@end
@implementation InterfaceController
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.title=@"消息";
    [self dataJSON];
    [self tableViewInit];
//    self.mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBoundsTabbarFrame) style:UITableViewStylePlain];
//    [self setExtraCellLineHidden:self.mytableview];
//    self.mytableview.backgroundColor=[UIColor clearColor];
//   // self.mytableview.separatorColor = [UIColor grayColor];
//    self.mytableview.dataSource = self;
//    self.mytableview.delegate = self;
//    [self.view addSubview:self.mytableview];

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


-(void)goBackAction{
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

-(void)tableViewInit
{
    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.viewBounds.size.width,JSViewBoundsTabbarFrame) style:UITableViewStylePlain];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.backgroundColor =[UIColor clearColor];
    [[JSBaseViewController sharedInstance] setExtraCellLineHidden:self.mytableview];
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
-(void)dataJSON
{
      NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"interface" ofType:@"plist"]];
    self.data = [NSMutableArray array];

    for (NSDictionary *dict in dictArray) {
        InterfaceModel *interfaceModel = [InterfaceModel interfaceWithDict:dict];
        [self.data addObject:interfaceModel];
        
    }
    
    
}
-(void)dataDictionary
{
//    [self.data  addObject:@"上传token"];
//    [self.data  addObject:@"设置标签"];
//    [self.data  addObject:@"更新地理位置"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"interface" ofType:@"plist"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    for (NSString *compKey in dataDic) {
        NSDictionary *dic = [dataDic objectForKey:compKey];
        [self.data addObject:dic];
     
//        NSString *ids=[dic objectForKey:@"id"];
//        NSString *interName=[dic objectForKey:@"interName"];
       
    }


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

  
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyID"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CurrencyID"];
    }
    cell.backgroundColor=[UIColor clearColor];
    
    // 显示文本
    InterfaceModel *interfaceModel=self.data[indexPath.row];;
    cell.textLabel.text =interfaceModel.interName;
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
            [self clickConsulting];
            break;
            
        }
        case 101:
        {
            [self clickToken];
            break;
            
        }
         
        case 102:
        {
            [self clicksetTagBtn];
            break;
        }
      
        case 103:
        {
             [self clickupdateArea];
            break;

        }
       
        case 104:
        {
            [self clickdeviceUserLogin];
            break;
            
        }
        
        case 105:
        {
            [self clickdeviceUserLogout];
            break;
            
        }
        case 106:
        {
            [self messageClick];
            break;
            
        }
        case 107:
        {
            [self jietuAction];
            break;
            
        }
        case 108:
        {
            [self videoAction];
            break;
            
        }
        case 109:
        {
            [self liveHomeAction];
            break;
            
        }
        
            
        default:
            break;
    }
    // NSLog(@"点击了-section:%i, row:%i", indexPath.section, indexPath.row);
   
   
}
#pragma mark视频播放
-(void)liveHomeAction
{
    
    LiveHomeViewController *liveHomeViewController=[[LiveHomeViewController alloc] init];
    [self.navigationController pushViewController:liveHomeViewController animated:NO];
}
#pragma mark视频播放
-(void)videoAction
{

    VideoViewController *videoViewController=[[VideoViewController alloc] init];
    [self.navigationController pushViewController:videoViewController animated:NO];
}
#pragma mark创意截图
-(void)jietuAction
{
    JSShareViewController *shareViewController=[[JSShareViewController alloc] init];
    [self.navigationController pushViewController:shareViewController animated:NO];
    
}
#pragma mark 消息重试
-(void)messageClick
{

    JSSystemController *systemController=[[JSSystemController alloc] init];
    [self.navigationController pushViewController:systemController animated:NO];
}
#pragma mark 快讯服务器、报价服务器、k线服务器
- (void)clickConsulting
{
    [APIRequest getHTTPSessionManager:JSMobileServer_URL params:nil success:^(id responseObj) {
        NSLog(@"设置标签%@",responseObj);
        [self UIAlert:@"快讯服务器、报价服务器、k线服务器成功"];
    } failure:^(id NSDictionary) {
        NSLog(@"设置标签%@",NSDictionary);
        [self UIAlert:@"快讯服务器、报价服务器、k线服务器失败"];
        //[APIRequest showNetworkError:NSDictionary];
        
    }];
    
}

- (void)clickToken
{
    
    [self pushToken:[JSSaveTool objectForKey:JSDeviceToken] oldToke:@""];
}

- (void)clicksetTagBtn
{
    [self reuqestSetTag];
}

- (void)clickupdateArea
{
    [self reqestUpdateAreag];
}
#pragma mark 设置标签
- (void)reuqestSetTag{
    NSString *actionStr=@"add";
    NSString *tagStr=@"1,2";
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setObject:actionStr forKey:@"action"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken]  forKey:@"deviceToken"];
    [params setObject:tagStr forKey:@"tag"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_SETTAG params:params
                               success:^(id responseObj) {
        NSLog(@"设置标签%@",responseObj);
        [self UIAlert:@"设置成功"];
    } failure:^(id NSDictionary) {
        NSLog(@"设置标签%@",NSDictionary);
        [self UIAlert:@"设置失败"];
        //[APIRequest showNetworkError:NSDictionary];
        
    }];
}
 -(void)UIAlert:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];

}

#pragma mark 更新地理位置
- (void)reqestUpdateAreag{
    
     NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];

    NSString *provinceStr=[ud objectForKey:@"provinces"];
    NSString *cityStr=[ud objectForKey:@"city"];
    NSString *lng_latStr=[NSString stringWithFormat:@"%@,%@",[ud objectForKey:@"UserLocationLng"],[ud objectForKey:@"UserLocationLat"]];
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setObject:provinceStr forKey:@"province"];
    [params setObject:cityStr forKey:@"city"];
    [params setObject:lng_latStr forKey:@"lng_lat"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken]  forKey:@"deviceToken"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_UPDATEAREA params:params
                               success:^(id responseObj) {
                                   NSLog(@"更新地理位置%@",responseObj);
                                   [self UIAlert:@"更新地理成功"];
                               } failure:^(id NSDictionary) {
                                   NSLog(@"更新地理位置%@",NSDictionary);
                                   [self UIAlert:@"更新地理失败"];
                                   //[APIRequest showNetworkError:NSDictionary];
                                   
                    }];
    

}


#pragma mark 上传 token
- (void)pushToken:(NSString*) token oldToke:(NSString*) oldToke{
    oldToken=oldToke;
    NSString *notifySwitch;//通知是否打开
    UIUserNotificationType types=[[UIApplication sharedApplication] currentUserNotificationSettings].types;
    if (types==UIUserNotificationTypeNone) {
        notifySwitch=@"0";
    }else{
        notifySwitch=@"1";
    }
    
    UIDevice *device = [[UIDevice alloc] init];
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
#if TARGET_IPHONE_SIMULATOR//模拟器
    token=JSIphonedeviceToken;
    [JSSaveTool setObject:token forKey:JSDeviceToken];
#endif
    [params setObject:token forKey:@"deviceToken"];
    [params setObject:device.systemName forKey:@"sysName"];
    [params setObject:device.systemVersion forKey:@"sysVersion"];
    [params setObject:JSCurVersion forKey:@"appVersion"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken]  forKey:@"deviceType"];
    [params setObject:oldToken forKey:@"oldToken"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];

    [APIRequest postHTTPSessionManager:SJURL_UPDATETOKEN params:params
                               success:^(id responseObj) {
                                   NSLog(@"token值%@",responseObj);
                                   [self UIAlert:@"token上传成功"];
                               } failure:^(id NSDictionary) {
                                   NSLog(@"token值%@",NSDictionary);
                                   [self UIAlert:@"token上传失败"];
                                   //[APIRequest showNetworkError:NSDictionary];
                                   
                               }];
}
#pragma mark 绑定用户UID
- (void)clickdeviceUserLogin
{

    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];

    [params setObject:@"101" forKey:@"uid"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken] forKey:@"deviceToken"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_DEVICEUSERLOGIN params:params success:^(id responseObj) {
        NSLog(@"绑定用户UID成功%@",responseObj);
        [self UIAlert:@"绑定用户UID"];
    } failure:^(id NSDictionary) {
        NSLog(@"绑定用户UID失败%@",NSDictionary);
        [self UIAlert:@"绑定用户UID失败"];
        //[APIRequest showNetworkError:NSDictionary];
        
    }];

    
}
#pragma mark 解除绑定用户UID
- (void)clickdeviceUserLogout
{
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    
    [params setObject:@"101" forKey:@"uid"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken]  forKey:@"deviceToken"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_DEVICEUSERLOGOUT params:params success:^(id responseObj) {
        NSLog(@"解除绑定用户UID%@",responseObj);
        [self UIAlert:@"解除绑定用户UID成功"];
    } failure:^(id NSDictionary) {
        NSLog(@"解除绑定用户UID失败%@",NSDictionary);
        [self UIAlert:@"解除绑定用户UID失败"];
        //[APIRequest showNetworkError:NSDictionary];
        
    }];
    


}








@end
