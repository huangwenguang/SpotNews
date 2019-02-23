//
//  NoNetworkView.h
//  ChildCareExpert
//
//  Created by carmen on 15/10/28.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoNetworkView : UIView
+(instancetype)sharedNetworkView;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic,strong) UIView *netWorkView;
@property(nonatomic,strong) UILabel *errorLabel;
@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property(nonatomic,strong) UIImageView *imageView;
-(void)showNotNetWork;
-(void)hideNotNetWork;
@end
