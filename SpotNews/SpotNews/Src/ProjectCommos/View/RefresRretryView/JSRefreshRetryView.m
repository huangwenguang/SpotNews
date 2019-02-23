//
//  RefreshRetryView.m
//  ChildCareUser
//
//  Created by carmen on 15/12/11.
//  Copyright © 2015年 3uol. All rights reserved.
//

#import "JSRefreshRetryView.h"

@implementation JSRefreshRetryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)refreshRetryView {
    static JSRefreshRetryView *refreshView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        refreshView = [[JSRefreshRetryView alloc] init];
        
    });
    return refreshView;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.refreshRetryView=[[UIView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, frame.size.height)];
        [self.refreshRetryView setBackgroundColor:[CommonUtils translateHexStringToColor:@"#ecefef"]];
        self.refreshRetryView.alpha=0.8;
        [self addSubview: self.refreshRetryView];
        float w=200;
        float h=50;
        float x=(self.refreshRetryView.frame.size.width-w)*0.5;
        float y=self.refreshRetryView.frame.size.height*0.3;
        self.refreshBtn=[[UIButton alloc] initWithFrame:CGRectMake(x,y,w,h)];
        [self.refreshBtn setTitle:@"刷新重试" forState:(UIControlStateNormal)]                   ;
        [self.refreshBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)]    ;
        self.refreshBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar64"]];        ;
        [self.refreshBtn addTarget:self action:@selector(refreshRetryClick) forControlEvents:(UIControlEventTouchUpInside)]                                                 ;
        self.refreshBtn.layer.masksToBounds = YES                                               ;
        self.refreshBtn.layer.cornerRadius  = 3;
        [self.refreshRetryView addSubview:self.refreshBtn];
        

    }
    return self;
}
-(void)refreshRetryClick
{
    if (self.refreshClick) {
        self.refreshClick();
    }
}

@end
