//
//  BaseCell.m
//  Created by WenGuangHuang on 16/4/6.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithXib{
    
    return nil ;
    
}
-(void)fillCellWithBean:(id)bean{
    
}
+(CGFloat)returnCellRowHeight:(id)bean{
    return 0 ;
}
@end
