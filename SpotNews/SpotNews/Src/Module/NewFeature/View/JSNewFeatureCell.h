//
//  JSNewFeatureCell.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/7.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSNewFeatureCell : UICollectionViewCell
@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *startButton;
@property (nonatomic, strong) UIImage *image;
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
