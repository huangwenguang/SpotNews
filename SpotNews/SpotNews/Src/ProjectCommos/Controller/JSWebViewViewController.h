//
//  WebViewViewController.h
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSWebViewViewController : JSBaseViewController
-(id)initWithURLString:(NSString *)url;
@property(nonatomic,assign) BOOL isShowBackBtn;
@property(nonatomic,assign) BOOL showToolBar;

@end
