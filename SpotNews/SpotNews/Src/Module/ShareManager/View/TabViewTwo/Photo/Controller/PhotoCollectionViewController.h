//
//  photoCollectionViewController.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//


#import "JSShareViewController.h"
@protocol ShareCameraViewControllerDelegate;

@interface PhotoCollectionViewController : JSBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, strong) UIImage *image;
@property(nonatomic,weak) id<ShareCameraViewControllerDelegate> delegate;
@end
@protocol ShareCameraViewControllerDelegate <NSObject>

-(void)ShareCameraViewController:(PhotoCollectionViewController *)picker image:(UIImage *)image;

@end
