//
//  photoCollectionViewController.m
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoModel.h"
#import "CustomButton.h"

#define  coll_num 3
#define  coll_width 10
#define k_saveTag 1000

@interface PhotoCollectionViewController ()
{
    PhotoCollectionViewCell *cell;
    UIButton *rightbtn;
    int  dataNum;
    float p_w;
    NSString *width;
    NSString *height;
    UIImage *IfullImage;
    UIImage *IsmallImage;
}
@end

@implementation PhotoCollectionViewController
static NSString * CellIdentifier = @"UICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
     width=@"200";
     height=@"200";
    self.title=@"大家正在使用";
    [self navigationView];
    [self dataJSON];
    [self addCollectionView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dataJSON
{
   NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"]];
    
    self.data = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        PhotoModel *photoModel = [PhotoModel interfaceWithDict:dict];
        [self.data addObject:photoModel];
    }
    if(self.data.count>0)
    {
       [self dataDictionary];
    }
    
    dataNum=(int)self.data.count;
    if(self.data.count==0)
    {
        [self dataDictionary];
    }
   
}

#pragma mark 自定义按钮数据
-(void)dataDictionary
{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    [dataDic setObject:@"101010" forKey:@"photoID"];
    [dataDic setObject:@"自定义" forKey:@"name"];
    [dataDic setObject:@"add" forKey:@"icon"];
        PhotoModel *photoModel = [PhotoModel interfaceWithDict:[NSDictionary dictionaryWithDictionary:dataDic]];
        [self.data addObject:photoModel];
}
-(void)navigationView
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(15, 5, 38, 38);
    [leftbtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftbtn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem=back;
    
    
     rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(15, 5, 38, 38);
    [rightbtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightbtn addTarget: self action: @selector(etermineAction) forControlEvents: UIControlEventTouchUpInside];
      [rightbtn setBackgroundColor:[UIColor clearColor]];
     [rightbtn setUserInteractionEnabled:NO];
    [rightbtn setTitleColor:[CommonUtils translateHexStringToColor:@"#696969"] forState:UIControlStateNormal];
   // [rightbtn setAdjustsImageWhenHighlighted:NO];
    UIBarButtonItem *determine=[[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem=determine;
    
}

#pragma  mark  确定
-(void)etermineAction{
    [self.delegate ShareCameraViewController:self image:self.image];

}
#pragma  mark 返回
-(void)goBackAction{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)addCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
   [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.viewBounds.size.width, self.viewBounds.size.height) collectionViewLayout:flowLayout];

    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
    
   //取消弹簧效果
   // self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled=YES;
    //数据不够一屏时上下滚动
    self.collectionView.alwaysBounceVertical = YES;
    //隐藏横向滚动条
   // [self.collectionView setShowsVerticalScrollIndicator:NO];
    //注册Cell，必须要有
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -- UICollectionViewDataSource
#pragma mark定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}
#pragma mark定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
       __weak PhotoCollectionViewController *weakSelf =self;
 
    if(dataNum==0)
    {
        
        CustomButton *customButton=[[CustomButton alloc] initWithFrame:CGRectMake(0,0,p_w,p_w)];
        customButton.photoalbumClick=^()
        {
            [weakSelf pickerPhoto];
        };
        [cell addSubview:customButton];
    
    }else if(indexPath.item+1==dataNum)
    {
        
        CustomButton *customButton=[[CustomButton alloc] initWithFrame:CGRectMake(0,0,p_w,p_w)];
        customButton.photoalbumClick=^()
        {
            [weakSelf pickerPhoto];
            
        };
        [cell addSubview:customButton];
   
    }else
    {
     [cell UIBuild:indexPath.item countNum:dataNum];
     PhotoModel *photo = self.data[indexPath.item];
  
    [cell setCellValue:photo];

    }

    return cell;
}
#pragma mark 照片
-(void)pickerPhoto
{
    UIImagePickerController *picekerVc = [[UIImagePickerController alloc] init];
    
    picekerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
 
    picekerVc.delegate = self;
    
    // modal
    [self presentViewController:picekerVc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
  
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        [picker dismissViewControllerAnimated:YES completion:^{
             IsmallImage=[self createImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
            // IsmallImage= [[info objectForKey:UIImagePickerControllerOriginalImage] thumbnailImage:200 interpolationQuality:kCGInterpolationDefault];
            [self.delegate ShareCameraViewController:self image:IsmallImage];
        }];
       
        
        // UIImageWriteToSavedPhotosAlbum(IfullImage, self,@selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 等比例生成图片和图片裁剪
- (UIImage *)createImage:(UIImage *)image  {
    float scalew=image.size.width>image.size.height?image.size.width:image.size.height;
    
    if([width intValue]>0&&[height intValue]>0)
    {
        float maxValue=[width intValue]>[height intValue]?[width intValue]:[height intValue];
        float sace=maxValue/scalew;
        CGSize size=CGSizeMake(image.size.width *sace,image.size.height *sace);
        
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0,0,size.width,size.height)];
        UIImage *images = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(scalew<maxValue) return images;
        //图片裁剪
        float x=(images.size.width-[width intValue])*0.5;
        float y=(images.size.height-[height intValue])*0.5;
        CGRect rect = CGRectMake(x, y,[width intValue],[height intValue]);
        CGImageRef cgimg = CGImageCreateWithImageInRect([images CGImage],rect);
        images= [UIImage imageWithCGImage:cgimg];
        CGImageRelease(cgimg);
        return images;
    }
    if([width intValue]>0)
    {
        float maxValue=[width intValue];
        float sace=maxValue/scalew;
        CGSize size=CGSizeMake(image.size.width *sace,image.size.height *sace);
        UIGraphicsBeginImageContext(size);
        
        [image drawInRect:CGRectMake(0,0,size.width,size.height)];
        UIImage *images = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return images;
    }
    if([height intValue]>0)
    {
        float maxValue=[height intValue];
        float sace=maxValue/scalew;
        CGSize size=CGSizeMake(image.size.width *sace,image.size.height *sace);
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0,0,size.width,size.height)];
        UIImage *images = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return images;
    }
    return image;
}

#pragma mark 触摸图片事件
-(void)saveTapAction:(NSInteger)index countNum:(NSInteger)countNum
{
    for (int i=0; i< countNum; i++) {
        if(index==i)
        {
            UIButton *button = (UIButton *)[self.collectionView viewWithTag:k_saveTag+i];
             button.hidden=!button.hidden;
            [self determine:button];
       
        }else
        {
            UIButton *button= (UIButton *)[self.collectionView viewWithTag:k_saveTag+i];
            button.hidden=YES;
        }
    }

}
#pragma mark确定按钮是否可以编辑
-(void)determine:(UIButton *)button
{
    if(button.hidden==YES)
    {
        
        [rightbtn setUserInteractionEnabled:NO];
        [rightbtn setTitleColor:[CommonUtils translateHexStringToColor:@"#696969"]forState:UIControlStateNormal];
        
    }else
    {
        [rightbtn setUserInteractionEnabled:YES];
        [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
#pragma mark定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    p_w=(self.collectionView.frame.size.width-(coll_num*2*coll_width))/coll_num;
    return CGSizeMake(p_w,p_w);
}
#pragma mark定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(coll_width,coll_width, coll_width,coll_width);
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     [self saveTapAction:indexPath.item countNum:dataNum];
      PhotoModel *photo=self.data[indexPath.item];
     self.image=[UIImage imageNamed:photo.icon];
    
}
#pragma mark 返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
