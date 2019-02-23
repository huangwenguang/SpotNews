//
//  LoginViewController.h
//  Ucan_3D
//
//  Created by carmen on 15/3/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import "JSBaseViewController.h"

@interface LoginViewController : JSBaseViewController<UITextFieldDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property (strong, nonatomic)  UITextField *loginField;
@property (strong, nonatomic)  UITextField *pwdField;
@property (strong, nonatomic)  UIButton *loginBut;
@property (strong, nonatomic)  UIButton *registeredBut;
@end
