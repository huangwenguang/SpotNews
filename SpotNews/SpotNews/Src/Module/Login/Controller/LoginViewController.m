//
//  LoginViewController.m
//  Ucan_3D
//
//  Created by carmen on 15/3/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//


#import "LoginViewController.h"
//#import "RegisteredViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBackBtn];
    self.title=@"登陆";
    self.view.backgroundColor=[CommonUtils translateHexStringToColor:@"#f6f4f4"];
    [self bulidUI];
    //[UserInfo shareUserInfo].passLogin = @"";
}

#pragma mark 添加ScrollView滚动
-(void)addScrollView
{
    UIScrollView *scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.viewBounds.size.width,self.viewBounds.size.height)];
    [scrollViews setBackgroundColor:[CommonUtils translateHexStringToColor:@"#f6f4f4"]];
    [self.view addSubview:scrollViews];
    _scrollView=scrollViews;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    [self.loginField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

#pragma mark添加scroll内容
-(void)bulidUI
{
    [self addScrollView];
    float  x= _scrollView.frame.size.width*0.05;
    
    float imagewhitd=_scrollView.frame.size.width-(2*x);
    float imagehight=44.0f;
    self.loginField=[[UITextField alloc] initWithFrame:CGRectMake(x,36,imagewhitd,imagehight)];
    self.loginField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.loginField.font=[UIFont systemFontOfSize:14];
    self.loginField.placeholder=@"请输入账号";
    self.loginField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.loginField.background=[UIImage imageNamed:@"textBackground"];
    
    
    float xlogin=10;
    float wview=45.0f;
    float loginwidth=40.0f;
//    if([[CommonUtils getCurrentLanguage] isEqualToString:@"en"])
//    {
//        wview=80.0f;
//        loginwidth=75.0f;
//    }
    UIView *viewlogin = [[UIView alloc] initWithFrame:CGRectMake(0, 0,wview,imagehight)];
    float ylogintext=(imagehight-40)*0.5;
    UILabel *logintext=[[UILabel alloc] initWithFrame:CGRectMake(xlogin,ylogintext,loginwidth,40)];
    logintext.textColor=[CommonUtils translateHexStringToColor:@"#d3ad5b"];
    logintext.font=[UIFont boldSystemFontOfSize:15];
    logintext.text=@"账号";
    [viewlogin addSubview:logintext];
    
    viewlogin.backgroundColor=[UIColor clearColor];
    self.loginField.leftView = viewlogin;
    self.loginField.tag=0;
    self.loginField.delegate=self;
    self.loginField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:self.loginField];
    
    
    
    float ypwd=CGRectGetMaxY(self.loginField.frame)+20;
    self.pwdField=[[UITextField alloc] initWithFrame:CGRectMake(x,ypwd,imagewhitd,imagehight)];
    self.pwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.pwdField.placeholder=@"请输入密码";
    self.pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdField.background=[UIImage imageNamed:@"textBackground"];
    self.pwdField.font=[UIFont systemFontOfSize:14];
    self.pwdField.secureTextEntry = YES;
    
    UIView *viewpwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0,wview,imagehight)];
    float ypwdtext=(imagehight-40)*0.5;
    UILabel *pwdtext=[[UILabel alloc] initWithFrame:CGRectMake(xlogin,ypwdtext,loginwidth,40)];
    pwdtext.textColor=[CommonUtils translateHexStringToColor:@"#d3ad5b"];
    pwdtext.font=[UIFont boldSystemFontOfSize:15];
    pwdtext.text=@"密码";
    [viewpwd addSubview:pwdtext];
    
    viewpwd.backgroundColor=[UIColor clearColor];
    self.pwdField.leftView = viewpwd;
    self.pwdField.tag=1;
    self.pwdField.delegate=self;
    self.pwdField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:self.pwdField];
    
    
    float yloginBut=CGRectGetMaxY(self.pwdField.frame)+30;
    self.loginBut=[[UIButton alloc] initWithFrame:CGRectMake(x,yloginBut,imagewhitd,imagehight)];
    [self.loginBut addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.loginBut setTitle:@"登陸" forState:UIControlStateNormal];
    [self.loginBut setTitleColor:[CommonUtils translateHexStringToColor:@"#00bcd2"] forState:UIControlStateNormal];
    [self.loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.loginBut setBackgroundImage:[UIImage imageNamed:@"textBackground"] forState:UIControlStateNormal];
    [self.loginBut setBackgroundImage:[UIImage imageNamed:@"loginBackgourd"] forState:UIControlStateHighlighted];
    [_scrollView addSubview:self.loginBut];
    
    
    
    
    float ypwdBut=CGRectGetMaxY(self.loginBut.frame)+20;
    self.registeredBut=[[UIButton alloc] initWithFrame:CGRectMake(x,ypwdBut,imagewhitd,imagehight)];
    [self.registeredBut addTarget:self action:@selector(pwdClick:) forControlEvents:UIControlEventTouchUpInside];
    self.registeredBut.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.registeredBut setTitle:@"注册" forState:UIControlStateNormal];
    [self.registeredBut setTitleColor:[CommonUtils translateHexStringToColor:@"#00bcd2"] forState:UIControlStateNormal];
    [self.registeredBut setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.registeredBut setBackgroundImage:[UIImage imageNamed:@"textBackground"] forState:UIControlStateNormal];
    [self.registeredBut setBackgroundImage:[UIImage imageNamed:@"loginBackgourd"] forState:UIControlStateHighlighted];
    [_scrollView addSubview:self.registeredBut];
    
}

#pragma mark 登录事件
-(void)loginClick:(UIButton *)sender;
{

    if (![self validation]) {
        return;
    }
    NSString *userName=self.loginField.text;
    NSString *pwd=self.pwdField.text;
    //第一步：构建请求参数
//    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:userName,@"userName",pwd,@"pwd", nil];
//
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    
    [params setObject:@"101" forKey:@"uid"];
    [params setObject:[JSSaveTool objectForKey:JSDeviceToken] forKey:@"deviceToken"];
    
    params=[[JSSignTool sharedSign]sortingArray:params];
    [APIRequest postHTTPSessionManager:SJURL_DEVICEUSERLOGIN params:params success:^(id responseObj) {
        NSLog(@"绑定用户UID成功%@",responseObj);
        [MBProgressHUD showSuccess:@"成功"];
    } failure:^(id NSDictionary) {
        [MBProgressHUD showError:@"登陆失败" toView:self.view];
        
    }];
    
    
    
}
#pragma mark 注册事件
-(void)pwdClick:(UIButton *)sender;
{
    
//    RegisteredViewController *registeredController=[[RegisteredViewController alloc] init];
//    
//    [self.navigationController pushViewController:registeredController animated:YES];  // push 到注册   ja
}

#pragma mark验证是否为空
-(BOOL)validation
{
    
    if(![CommonUtils isValidationNull:self.loginField.text])
    {
        [MBProgressHUD showError:@"请输入账号"];
        return NO;
    }
    if(![CommonUtils isValidationNull:self.pwdField.text])
    {
         [MBProgressHUD showError:@"请输入密码"];
        return NO;
    }
    return true;
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
