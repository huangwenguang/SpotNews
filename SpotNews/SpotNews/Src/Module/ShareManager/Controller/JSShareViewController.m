//
//  ShareViewController1.m
//  JinShi
//
//  Created by WenGuangHuang on 16/3/16.
//  Copyright © 2016年 jin10.com. All rights reserved.
//

#import "JSShareViewController.h"
#import "TabView.h"
#import "TabViewOne.h"
#import "TabViewTwo.h"
#import "TabViewThree.h"
#import "PhotoCollectionViewController.h"
#import "ImageObject.h"
#import "ImageT.h"
@interface JSShareViewController()<ShareCameraViewControllerDelegate>
{
    UIScrollView  *scrollViewOne;
    TabView *tabView;
    TabViewOne *tabViewOne;
    TabViewTwo *tabViewTwo;
    TabViewThree *tabViewThree;
    CGFloat s_h;
    CGFloat s_y;
    DrawView *drawView;
    UIImageView *background_imageView;
    CGPoint pointLeftTop;
   


}

@end

@implementation JSShareViewController
+(instancetype)sharedBase {
    static JSShareViewController *sharedBaseInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBaseInstance = [[JSShareViewController alloc] init];
    });
    return sharedBaseInstance;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"创意截屏";
    NSLog(@"self.view.frame.size.height%f",self.view.frame.size.height);
    NSLog(@"self.viewBounds.size.height%f",self.viewBounds.size.height);
    NSLog(@"[UIScreen mainScreen].bounds.size.height%f",[UIScreen mainScreen].bounds.size.height);
    NSLog(@"self.viewBounds.size.height-JStabBar_HEIGHT%f",self.viewBounds.size.height-JSTabBar_HEIGHT);
    CGFloat view_hh=self.view.frame.size.height-RECTSTATUS_HEIGHT-NAVIGATIONBAR_HEIGHT;
    NSLog(@"view_hh%f",view_hh);
    self.isTabBarView=NO;
    [self showBackBtn];
    self.dataImage=[NSMutableArray array];
     [[DatabaseManager Instance] createImageT];
    [self saveBtn];
    [self UIbulid];

}
-(void)UIbulid
{
    

    [self buildTabView];
    [self addScrollView];
    [self TabOne];
    [self initDrawView];

    
}
#pragma mark 添加画板
-(void)initDrawView
{
    CGFloat x=50.0f;
    CGFloat y=10.0f;
    CGFloat w=self.viewBounds.size.width-(x*2);
    CGFloat h=JSViewBounds-tabView.frame.size.height-scrollViewOne.frame.size.height-2*10;
    background_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
    background_imageView.image=_pic_image;
    [self.view addSubview:background_imageView];
    drawView=[[DrawView alloc] initWithFrame:CGRectMake(x,y,w,h)];
    drawView.backgroundColor=[UIColor clearColor];
    drawView.pathColor=[UIColor colorWithHexString:@"e50000" withAlpha:1];
    [self.view addSubview:drawView];
}
-(void)buildTabView
{
    
    NSArray *titleArr=[NSArray arrayWithObjects:@"盖章",@"表情",@"涂鸦", nil];
    NSArray *picArr=[NSArray arrayWithObjects:@"home_icon_message",@"home_icon_more",@"home_icon_root", nil];
    NSArray *picArrhighlighted=[NSArray arrayWithObjects:@"home_icon_message_selected",@"home_icon_more_selected",@"home_icon_root_selected", nil];
    CGFloat h=44.0f;
    CGFloat y=JSViewBounds-h;
    tabView=[[TabView alloc] initWithFrame:CGRectMake(0,y,self.viewBounds.size.width,h) titleArray:titleArr picArr:picArr picArrhighlighted:picArrhighlighted];
       tabView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_bg"]];
    tabView.selectedIndex=0;
    __weak JSShareViewController *weakSelf =self;
    tabView.clickBlock=^(int index){
        switch (index) {
            case 0:
            {
                 [weakSelf TabOne];
            }
                break;
            case 1:
            {
                  [weakSelf TabTwo];
                
            }
                break;
            case 2:
            {
                  [weakSelf TabThree];
            }
                break;
                
            default:
                break;
        }
        
    };
    [self.view addSubview:tabView];

}


#pragma  mark 返回
-(void)saveBtn
{
//    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backbtn.frame = CGRectMake(15, 5, 38, 38);
//    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
//    [backbtn addTarget: self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithCustomView:backbtn];
//    self.navigationItem.leftBarButtonItem=backItem;

    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(15, 5, 38, 38);
    [rightbtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightbtn addTarget: self action: @selector(saveAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *determine=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem=determine;

}
-(void)backAction
{
  //  [self.navigationController popViewControllerAnimated:YES];
// [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 保存图片
-(void)saveAction
{
    [self delbutFrame];
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    UIBezierPath *path =  [UIBezierPath bezierPathWithRect:drawView.frame];
     [path addClip];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

// 监听保存完成，必须实现这个方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"保存图片成功");
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"保存图片成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
-(void)goBackAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark盖章
-(void)TabOne
{
    [drawView setUserInteractionEnabled:NO];
    tabViewOne=[[TabViewOne alloc] initWithOneFrame:CGRectMake(0,0,scrollViewOne.frame.size.width,scrollViewOne.frame.size.height)];
     tabViewOne.backgroundColor=[UIColor grayColor];
    [scrollViewOne addSubview:tabViewOne];
 

}
#pragma mark添加scrollView
-(void)addScrollView
{
    s_h=54.0f;
    s_y=JSViewBounds-tabView.frame.size.height-s_h;
    scrollViewOne=[[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,s_y, self.viewBounds.size.width,s_h)];
    scrollViewOne.backgroundColor=[UIColor clearColor];
    scrollViewOne.scrollEnabled=YES;//滚动
    scrollViewOne.bounces=NO;// 弹簧
    scrollViewOne.showsHorizontalScrollIndicator=NO;//水平
    [self.view addSubview:scrollViewOne];
}
#pragma mark表情
-(void)TabTwo
{
      [drawView setUserInteractionEnabled:NO];
      self.dataImage=[ImageT selectAll];
     tabViewTwo=[[TabViewTwo alloc] initWithTwoFrame:CGRectMake(0,0,scrollViewOne.frame.size.width,scrollViewOne.frame.size.height) dataImage:self.dataImage];
     tabViewTwo.backgroundColor=[UIColor grayColor];
    __weak JSShareViewController *weakSelf =self;
    tabViewTwo.moreClick=^()
    {
        [weakSelf ActionmMore];
    };
    tabViewTwo.photoClick=^(UIImage * image)
    {
        [weakSelf photoAction:image];
    };
    [scrollViewOne addSubview:tabViewTwo];
    NSLog(@"tabViewTwo.frame.size.width%f",tabViewTwo.frame.size.width);
   scrollViewOne.contentSize = CGSizeMake(tabViewTwo.frame.size.width, tabViewTwo.frame.size.height);
}
#pragma mark 点击图片
-(void)photoAction:(UIImage *)image
{
    self.image=image;
 }
#pragma mark 系统和自定义相册的统一回调
-(void)ShareCameraViewController:(PhotoCollectionViewController *)picker image:(UIImage *)image
{
       NSLog(@"系统相册回调");
      [picker dismissViewControllerAnimated:YES completion:nil];
       self.image=image;
      [self sqlimageContrast];
 

}
#pragma mark sql图片对比
-(void)sqlimageContrast
{
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr=[CommonUtils stringFromDate:datenow withFormat:@"yyyy-MM-dd-HH:mm:ss.SSS"];
  
    ImageObject *imageObj=[ImageT getImageObj:UIImagePNGRepresentation(self.image)];
    if(imageObj!=nil)
    {
        imageObj.datetime=nowtimeStr;
        BOOL flag=[ImageT updateImageObject:imageObj];
        if(flag)
        {
            NSLog(@"更新成功");
            [self TabTwo];
            
        }else
        {
            NSLog(@"更新失败");
            return;
        }
    
    }else
    {
        ImageObject *imageObjc=[[ImageObject alloc] initWithParameters:2 original_image:UIImagePNGRepresentation(self.image) small_image:UIImagePNGRepresentation(self.image) datetime:nowtimeStr];
        BOOL flag=[ImageT insertImage:imageObjc];
        if(flag)
        {
            NSLog(@"插入成功");
             [self TabTwo];
            
        }else
        {
            NSLog(@"插入失败");
            return;
        }
    
    }
  
  
}
#pragma mark 更多
-(void)ActionmMore
{
    
    PhotoCollectionViewController *photoCollectionViewController=[[PhotoCollectionViewController alloc] init];
    photoCollectionViewController.delegate=self;
    UINavigationController *photoNavigationController = [[UINavigationController alloc]initWithRootViewController:photoCollectionViewController];
    [self presentViewController:photoNavigationController
                       animated:YES completion:nil];


}
#pragma mark涂鸦
-(void)TabThree
{
    [drawView setUserInteractionEnabled:YES];

    [self.view bringSubviewToFront:drawView];
    tabViewThree=[[TabViewThree alloc] initWithThreeFrame:CGRectMake(0,0,scrollViewOne.frame.size.width,scrollViewOne.frame.size.height)];
    __weak JSShareViewController *weakSelf =self;
    tabViewThree.backgroundColor=[UIColor grayColor];
    [scrollViewOne addSubview:tabViewThree];
    tabViewThree.viewTwoClick=^(int index,NSString *colorValue){
        switch (index) {
            case 0:
            {
                [weakSelf colorChange:colorValue];
            
            }
                break;
            case 1:
            {
                 [weakSelf colorChange:colorValue];
                
            }
                break;
            case 2:
            {
                 [weakSelf colorChange:colorValue];
            }
                break;
                
            default:
                break;
        }
    };
    
    tabViewThree.viewOneClick=^(int index,NSInteger valueChange){
        switch (index) {
            case 0:
            {
                [weakSelf valueChange:valueChange];
                
            }
                break;
            case 1:
            {
                [weakSelf valueChange:valueChange];
                
            }
                break;
            case 2:
            {
                [weakSelf valueChange:valueChange];
            }
                break;
                
            default:
                break;
        }
    };
    tabViewThree.clearClick=^()
    {
        [weakSelf clear];
    };

}
#pragma mark 清屏
- (void)clear
{
       [drawView clear];
    

}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.scroll_imageView.image = image;
   [self.scroll_imageView sizeToFit];
    self.scrollView_two.contentSize = image.size;
    

   
    [self delbutFrame];
    
}

-(void)delbutFrame
{
    float w=40;
    float h=40;
    float b_x=_scroll_imageView.frame.origin.x-20;
    float b_y=_scroll_imageView.frame.origin.y-20;
    
    if (self.delbut == nil) {
        self.delbut=[[UIButton alloc] initWithFrame:CGRectMake(b_x,b_y,w,h)];
        [self.delbut setImage:[UIImage imageNamed:@"delete_btn"] forState:UIControlStateNormal];
        [self.delbut addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView_two addSubview:self.delbut];
    }else
    {
        self.delbut.frame=CGRectMake(b_x,b_y,w,h);
    }
     [self addDottedline:_scroll_imageView];

}

- (UIImageView *)scroll_imageView
{
    
    float x=(drawView.frame.size.width-_image.size.width)*0.5;
    float y=(drawView.frame.size.height-_image.size.height)*0.5;
   if (_scroll_imageView == nil) {
       
        _scroll_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x,y, _image.size.width,_image.size.height)];
        _scroll_imageView.backgroundColor=[UIColor clearColor];
       _scroll_imageView.tag=70;
       [_scroll_imageView setUserInteractionEnabled:YES];
       [_scroll_imageView setMultipleTouchEnabled:YES];

//       // 旋转手势
//       UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
//       
//       [rotationGestureRecognizer setDelaysTouchesBegan:TRUE];
//       [rotationGestureRecognizer setDelaysTouchesEnded:TRUE];
//       rotationGestureRecognizer.delegate = self;
//       [_scroll_imageView addGestureRecognizer:rotationGestureRecognizer];
        // 移动手势
        UIPanGestureRecognizer *fgpanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fgpanView:)];

       [fgpanGestureRecognizer setMinimumNumberOfTouches:1];
       [fgpanGestureRecognizer setMaximumNumberOfTouches:2];
        [fgpanGestureRecognizer setDelaysTouchesBegan:TRUE];
        [fgpanGestureRecognizer setDelaysTouchesEnded:TRUE];
        fgpanGestureRecognizer.delegate = self;
        [_scroll_imageView addGestureRecognizer:fgpanGestureRecognizer];
        [self.scrollView_two addSubview:_scroll_imageView];

  }

    return _scroll_imageView;
}


#pragma mark 删除scrollView_two
-(void)delClick
{
    
     [self.delbut removeFromSuperview];
    self.delbut =nil;
    [self.scroll_imageView removeFromSuperview];
    self.scroll_imageView=nil;
    [self.scrollView_two removeFromSuperview];
    self.scrollView_two=nil;


}

#pragma mark 添加虚线
-(void)addDottedline:(UIImageView *)imageView
{
              imageView.layer.sublayers=nil;
             CALayer *layer=[imageView layer];
             float w= imageView.image.size.width;
             float h= imageView.image.size.height;
             
             CAShapeLayer *border = [CAShapeLayer layer];
             border.strokeColor = [UIColor whiteColor].CGColor;
             
             border.fillColor = nil;
             
             border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,w,h)].CGPath;
             border.lineWidth = 1.f;
             border.lineCap = @"square";
             border.lineDashPattern = @[@4, @2];
             [layer addSublayer:border];
}

#pragma mark 图片触摸旋转
- (void)rotateView:(UIRotationGestureRecognizer *)recognizer
{
    [self delbutFrame];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: // 开始触发手势
            
            break;
        case UIGestureRecognizerStateEnded: // 手势结束
            
            break;
            
        default:
            break;
    }
    //    NSLog(@"recognizer.rotation%f",recognizer.rotation);
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}
#pragma mark 处理图片拖拉手势
- (void) fgpanView:(UIPanGestureRecognizer *)pan
{
       [self.view bringSubviewToFront:self.scrollView_two];
    CGPoint p=[pan locationInView:self.view];
       [self delbutFrame];
    
    if (pan.state==UIGestureRecognizerStateBegan)
    {
        pointLeftTop=p;
        
    }else if (pan.state==UIGestureRecognizerStateChanged)
    {
        pan.view.center=CGPointMake(pan.view.center.x+(p.x-pointLeftTop.x), pan.view.center.y+(p.y-pointLeftTop.y));
        pointLeftTop=p;
    }else if (pan.state==UIGestureRecognizerStateEnded) {
        
        
     
    }
    
}
#pragma mark  scrollView图片放大缩小
- (UIScrollView *)scrollView_two
{
    if (_scrollView_two == nil) {
        _scrollView_two = [[UIScrollView alloc] initWithFrame:drawView.frame];
        _scrollView_two.showsHorizontalScrollIndicator = NO;
        _scrollView_two.showsVerticalScrollIndicator = NO;
        _scrollView_two.userInteractionEnabled = YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollView_twoClick:)];
        [_scrollView_two addGestureRecognizer:tapGesture];
        _scrollView_two.backgroundColor=[UIColor redColor];
        _scrollView_two.bounces = NO;
        _scrollView_two.delegate = self;
        _scrollView_two.maximumZoomScale = 6.0;
        _scrollView_two.minimumZoomScale =0.1;
        [self.view addSubview:_scrollView_two];
    }
    
    return _scrollView_two;
}


-(void)scrollView_twoClick:(UITapGestureRecognizer *)gesture
{
    [self.delbut removeFromSuperview];
    self.delbut =nil;
    self.scroll_imageView.layer.sublayers=nil;
}


// 1> scrollView要知道缩放谁
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    [self.view bringSubviewToFront:self.scrollView_two];
    
    return self.scroll_imageView;
}

// 2> 滚动视图即将开始缩放，通常不需要写
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"%s", __func__);
}

// 3> 正在缩放，通常也不需要实现
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    NSLog(@"%s", __func__);
    NSLog(@"%@", NSStringFromCGAffineTransform(self.scroll_imageView.transform));
}

// 4> 完成缩放，通常也不需要实现
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
   [self delbutFrame];
    NSLog(@"%s", __func__);
}

#pragma mark 画板传递线宽
- (IBAction)valueChange:(NSInteger)valueChange {
    drawView.lineWidth=valueChange;
}
#pragma mark 画板传递颜色
-(void)colorChange:(NSString *)colorValue
{
    drawView.pathColor=[UIColor colorWithHexString:colorValue withAlpha:1];
}
@end
