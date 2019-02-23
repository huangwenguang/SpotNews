//
//  WebViewViewController.m
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "JSWebViewViewController.h"
#define k_toolBarHeight 44.0f
@interface JSWebViewViewController ()<UIWebViewDelegate>
{
    NSURL *URL;
    NSDictionary *currentCMDDic;
    UIToolbar *toolBar;
    
    UIBarButtonItem *backBtn;
    UIBarButtonItem *fowardBtn;
    
    UIBarButtonItem *refreshBtn;
    NSString *Networkerror;
}
@property(nonatomic,strong) UIWebView *showWebView;
@end

@implementation JSWebViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithURLString:(NSString *)url
{
    if (self=[super init])
    {
        URL=[NSURL URLWithString:url];
    }
    return self;
}

//网页布局
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildToolBar];
    self.showWebView=[[UIWebView alloc] initWithFrame:CGRectMake(self.viewBounds.origin.x, self.viewBounds.origin.y, self.viewBounds.size.width, self.viewBounds.size.height-toolBar.bounds.size.height-49)];
    self.showWebView.delegate=self;
    [self.view addSubview:self.showWebView];
    NSURLRequest *request=[NSURLRequest requestWithURL:URL];
    NSLog(@"%@",URL.absoluteURL);
    [self.showWebView  loadRequest:request];
}

-(void)backBtnClick
{
    
    self.showWebView.delegate=nil;
    [self.showWebView stopLoading];
    [super backBtnClick];
    
}


-(void)buildToolBar
{
    
    if (!self.showToolBar) {
        return;
    }
    backBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(historyBack)];
    
    fowardBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(historyForward)];
    refreshBtn=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    UIBarButtonItem* fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 50;
    NSArray *arr=[NSArray arrayWithObjects:fixedSpace,backBtn,fixedSpace,refreshBtn,fixedSpace,fowardBtn,fixedSpace, nil];
    toolBar =[[UIToolbar alloc] initWithFrame:CGRectMake(self.viewBounds.origin.x, self.viewBounds.origin.y+self.viewBounds.size.height-k_toolBarHeight, self.viewBounds.size.width, k_toolBarHeight)];
    [toolBar setItems:arr];
    [self.view addSubview:toolBar];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

     [[JSBaseViewController sharedInstance] showLoading];
    [self activeBtns];
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   // self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [[JSBaseViewController sharedInstance] hideLoading];
    [self activeBtns];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
    [[JSBaseViewController sharedInstance] showErrorWithText:Networkerror];
    [self activeBtns];
}

-(void)activeBtns
{
    if ([self.showWebView canGoBack]) {
        [backBtn setEnabled:YES];
    }
    else
    {
        [backBtn setEnabled:NO];
    }
    if ([self.showWebView canGoForward]) {
        [fowardBtn setEnabled:YES];
    }
    else
    {
        [fowardBtn setEnabled:NO];
    }
    
}

-(void)historyBack
{
    [self.showWebView goBack];
}

-(void)historyForward
{
    [self.showWebView goForward];
}

-(void)refresh
{
    [self.showWebView reload];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)decodeFromPercentEscapeString:(NSString *) string {
    CFStringRef s=CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                          (__bridge CFStringRef) string,
                                                                          CFSTR(""),
                                                                          kCFStringEncodingUTF8);
    NSString *ss=[NSString stringWithFormat:@"%@",s];
    CFRelease(s);
    return ss;
}

@end
