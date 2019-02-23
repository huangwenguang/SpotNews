//
//  PhotoCollectionViewCell.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"


@interface PhotoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIView *uiVIew;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *saveBtn;
-(void)UIBuild:(NSInteger)index countNum:(NSInteger)countNum;
-(void)setCellValue:(PhotoModel *)photoModel;
@property(nonatomic,assign) NSInteger countNumber;
@end
