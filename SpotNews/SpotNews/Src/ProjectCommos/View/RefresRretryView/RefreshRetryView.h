//
//  RefreshRetryView.h
//  ChildCareUser
//
//  Created by carmen on 15/12/11.
//  Copyright © 2015年 3uol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSRefreshRetryView : UIView
+(instancetype)refreshRetryView;
@property(nonatomic,strong) UIView *refreshRetryView;
@property(nonatomic,strong) UIButton *refreshBtn;
@property(nonatomic,copy) RefreshRetryClick refreshClick;
@end
