//
//  JSToolbarVIew.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PlayClick)();
typedef void(^StopClick)();
typedef void(^RestoreClick)();
typedef void(^SuspendedClick)();
@interface JSToolbarView : UIView
@property(nonatomic,copy) PlayClick playClick;
@property(nonatomic,copy) StopClick stopClick;
@property(nonatomic,copy) RestoreClick restoreClick;
@property(nonatomic,copy) SuspendedClick suspendedClick;
@end
