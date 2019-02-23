//
//  CarGroupCell.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/13.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSBaseCell.h"

@interface CarGroupCell : UITableViewCell
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong)  UILabel *content;
-(void)setCellValue:(NSString *)content;
@end
