//
//  BaseCell.h
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell
-(instancetype)initWithXib;
-(void)fillCellWithBean:(id)bean;
+(CGFloat)returnCellRowHeight:(id)bean;
@end
