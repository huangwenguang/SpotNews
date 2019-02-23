//
//  LiveViewController.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/15.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "LiveHomeViewController.h"
#import "JSToolbarView.h"
#import "JSExampleViewController6.h"
#import "JSExampleViewController5.h"
#import "JSExampleViewController4.h"
#import "JSExampleViewController3.h"
#import "JSExampleViewController2.h"
#import "JSExampleViewController1.h"
#import "LiveViewController.h"
#import "JSLabel.h"
#import "InterfaceController.h"
#define lad_tag 700
#define cou_num 8


@interface LiveHomeViewController ()
{
    TCPlayerView *_playerView;
}
@end

@implementation LiveHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isTabBarView=NO;
    self.title=@"消息";
 // self.automaticallyAdjustsScrollViewInsets=NO;
     [self UIBUlid];
 
    // 添加子控制器
    [self setupChildVc];
    // 添加标题
    [self setupTitle];
    
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
   
    // Do any additional setup after loading the view.
}
-(void)UIBUlid
{
    CGFloat h=35;
    self.titleScrollViews=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,h)];
    self.titleScrollViews.tag=101;
    self.titleScrollViews.showsHorizontalScrollIndicator=NO;
    self.titleScrollViews.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.titleScrollViews];
    self.contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollViews.frame), self.view.frame.size.width,JSViewBounds-h)];
        self.contentScrollView.tag=102;


    self.contentScrollView.showsHorizontalScrollIndicator=NO;
    
    self.contentScrollView.showsVerticalScrollIndicator=NO;
           self.contentScrollView.delegate=self;
    [self.view addSubview:self.contentScrollView];
    
}

//添加标题
- (void)setupTitle
{
    // 定义临时变量
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollViews.frame.size.height;
    
    // 添加label
    for (NSInteger i =0; i<cou_num; i++) {
        JSLabel *label = [[JSLabel alloc] init];

        label.text = [self.childViewControllers[i] title];
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollViews addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
        }
    }
    
    // 设置contentSize
    self.titleScrollViews.contentSize = CGSizeMake(cou_num* labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(cou_num * [UIScreen mainScreen].bounds.size.width, 0);
}

/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}
- (void)setupChildVc
{
    
    LiveViewController *social = [[LiveViewController alloc] init];
    social.title = @"直播";
    [self addChildViewController:social];
    
    JSExampleViewController1 *social0 = [[JSExampleViewController1 alloc] init];
    social0.title = @"表格2";
    [self addChildViewController:social0];
    
    JSExampleViewController2 *social1 = [[JSExampleViewController2 alloc] init];
    social1.title = @"表格3";
    [self addChildViewController:social1];
    
    JSExampleViewController3 *social2 = [[JSExampleViewController3 alloc] init];
    social2.title = @"表格4";
    [self addChildViewController:social2];
    
    JSExampleViewController4 *social3 = [[JSExampleViewController4 alloc] init];
    social3.title = @"表格5头部顶上";
    [self addChildViewController:social3];
    
    JSExampleViewController5 *social4 = [[JSExampleViewController5 alloc] init];
    social4.title = @"表格6分组";
    [self addChildViewController:social4];
    InterfaceController *social5 = [[InterfaceController alloc] init];
    social5.title = @"接口";
    [self addChildViewController:social5];
    
    JSExampleViewController6 *social6 = [[JSExampleViewController6 alloc] init];
    social6.title = @"首页";
    [self addChildViewController:social6];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
 
    
    // 让对应的顶部标题居中显示
    JSLabel *label = self.titleScrollViews.subviews[index];
    CGPoint titleOffset = self.titleScrollViews.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollViews.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollViews setContentOffset:titleOffset animated:YES];
   

    // 让其他label回到最初的状态
    for (int i=0;i<cou_num;i++) {
           JSLabel *otherLabel= self.titleScrollViews.subviews[i];
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    

    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    

    if (scale < 0 || scale > self.titleScrollViews.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    JSLabel *leftLabel = self.titleScrollViews.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    JSLabel *rightLabel = (rightIndex == self.titleScrollViews.subviews.count) ? nil : self.titleScrollViews.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
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
