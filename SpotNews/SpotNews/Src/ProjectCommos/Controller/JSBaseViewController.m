//
//  BaseViewController.m
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "JSBaseViewController.h"
#import "SVProgressHUD.h"

@implementation UINavigationController (RotationFix)



@end
@interface JSBaseViewController ()
{
    NSInteger stackedControllerCountOfNavigation;
    UILabel *showTestVersionLabel;
}
@end

@implementation JSBaseViewController

+(instancetype)sharedInstance {
static JSBaseViewController *sharedBaseInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBaseInstance = [[JSBaseViewController alloc] init];
        
    });
    return sharedBaseInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isTabBarView=YES;
     JSGShowStatusBar
    JSGWhiteStatusBar
 //
    self.view.backgroundColor=[UIColor clearColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showStatusMessage:) name:KNotification_ShowStatusMessage object:nil];
    //self.navigationController.navigationBar.translucent = YES;
    
    [self hideBackBtn];
    if([CommonUtils isIOS7])
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
      self.automaticallyAdjustsScrollViewInsets=YES;
    }
    else
    {

        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
    
    }

    self.viewBounds=[CommonUtils resizeViewBoundsforTable:self.view.bounds withNavBarHeight:JSTabBar_HEIGHT];
    [self changeNavBarTitleColor];
}
-(void)showStatusMessage:(NSNotification*)value{
    NSString *msg=[value object];
    [KGStatusBar showSuccessWithStatus:msg];
    
}



//返回按钮
-(void)showBackBtn
{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 44, 44)];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];//设置按钮点击事件
    [leftBtn setImage:[UIImage imageNamed:@"Nav_back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButon = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
        
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil action:nil];
        negativeSpacer.width = -20;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButon];
    }else
        
        self.navigationItem.leftBarButtonItem = leftBarButon;
    
}

//隐藏返回按钮
-(void)hideBackBtn
{
    self.navigationItem.leftBarButtonItem=nil;
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
}
//返回按钮点击事件
-(void)backBtnClick
{
        [self hideLoading];
        if ([self.navigationController popViewControllerAnimated:YES]) {
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }

}
-(void)setIsTabBarView:(BOOL)isTabBarView
{
    _isTabBarView=isTabBarView;
    if (_isTabBarView)
    {
        self.viewBounds=CGRectMake(self.viewBounds.origin.x, self.viewBounds.origin.y, self.viewBounds.size.width, self.viewBounds.size.height-49);
        self.rdv_tabBarController.tabBarHidden=!_isTabBarView;
    }
}

//修改banner title颜色
-(void)changeNavBarTitleColor
{
    
    UIColor *cc = [UIColor whiteColor];
    if ([CommonUtils IOSVersion]>=6.0) {
        NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey:NSForegroundColorAttributeName];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    else
    {
        NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey:UITextAttributeTextColor];
        self.navigationController.navigationBar.titleTextAttributes = dict;
    }
    
    [self.view setBackgroundColor:JSBGCOLOR];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.rdv_tabBarController.tabBarHidden=!_isTabBarView;
    if(![NSStringFromClass(self.class) isEqualToString:@"MyCertificationViewController"]||![NSStringFromClass(self.class) isEqualToString:@"RootViewController"])
    {
       [self httpRequestStatus];
    }
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
   

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   [MobClick endLogPageView:NSStringFromClass(self.class)];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
#ifdef JSAppIsTestVersion
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, self.viewBounds.size.height*0.5-30, 50, 30)];
    lable.text=JSAppIsTestVersion;
    [lable setFont:[UIFont systemFontOfSize:13]];
    [lable setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    [self.view addSubview:lable];
#endif

}
-(void) showAlert:(NSString*) title message:(NSString*) message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void) showLoading
{
    [SVProgressHUD show];
}

-(void) showLoadingWithText:(NSString *) text
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:text];
}

-(void) hideLoading
{
    [SVProgressHUD dismiss];
}


-(void) showErrorWithText:(NSString *) text
{
      [NSThread sleepForTimeInterval:1.0];
     [SVProgressHUD showErrorWithStatus:text];
  // [self performSelector:@selector(showError:) withObject:text afterDelay:5];
}



-(void) showSuccessWithText:(NSString*) text
{
    [SVProgressHUD showSuccessWithStatus:text];
}
-(void) showSuccessWithTextTypeNone:(NSString*) text
{
    [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeNone];
}

-(void) showSuccessWithTextTypeGradient:(NSString*) text
{
    [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeGradient];
}

-(void)httpRequestStatus:(CommonReturnIntegerBlock)returnValue{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                if(returnValue!=nil)
                {
                    returnValue(AFNetworkReachabilityStatusUnknown);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                if(returnValue!=nil)
                {
                    returnValue(AFNetworkReachabilityStatusReachableViaWWAN);
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                if(returnValue!=nil)
                {
                    returnValue(AFNetworkReachabilityStatusReachableViaWiFi);
                }
                
            }
                
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                if(returnValue!=nil)
                {
                    returnValue(AFNetworkReachabilityStatusNotReachable);
                }
            }
                break ;
        }
    }
     
     ];
    [mgr startMonitoring];
    
}

-(void)httpRequestStatus
{
[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(AFNetwork) userInfo:nil repeats:YES];
}
-(void)AFNetwork
{
  
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
              [self hidenotNetwork];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
             [self hidenotNetwork];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{

              [self hidenotNetwork];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
            [self notNetwork];
                        }
                break ;
        }
    }
     
     ];
    [mgr startMonitoring];

}
-(void)hidenotNetwork
{
    if(self.noNetworkView!=nil)
    {
        [self.noNetworkView removeFromSuperview];
        self.noNetworkView=nil;
    }
    
}
-(void)notNetwork
{
        if(self.noNetworkView==nil)
        {
            self.keyv=[UIApplication sharedApplication].keyWindow;
            self.noNetworkView=[[JSNoNetworkView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
           // [self.view bringSubviewToFront:self.noNetworkView];
           [self.keyv addSubview:self.noNetworkView];
        }else
        {
            [self.noNetworkView.indicatorView stopAnimating];
            [self.noNetworkView.indicatorView setHidesWhenStopped:YES];
            self.noNetworkView.errorLabel.hidden=NO;
        
        }

}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    //竖屏
    return UIInterfaceOrientationMaskPortrait;
}


@end
