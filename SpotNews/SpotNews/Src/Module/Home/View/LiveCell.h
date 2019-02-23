//
//  LiveCell.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/18.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgAllObject.h"
typedef enum{
    TEXT= 0,
    DATA=1
}DataType;
@interface LiveCell : UITableViewCell
@property (nonatomic, strong)  UIView *selectView;
@property (nonatomic, strong)  UIView *bg;
@property (nonatomic, strong)  UIImageView *live_leftSmall;
@property (nonatomic, strong)  UIImageView *line_right_image;
@property (nonatomic, strong)  UIImageView *line_image;
@property (nonatomic, strong)  UIView *timeView;
@property (nonatomic, strong)  UIImageView *time_image;
@property (nonatomic, strong)  UILabel *time_label;
@property (nonatomic, strong)  UILabel *context_label;
@property (nonatomic, strong)  UIImageView *pic_image;
//-(void)setValue:(MsgAllObject *)msgAllObject;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;
/** 消息数据 */
@property (nonatomic, strong) MsgAllObject *msgAllObject;

@property (nonatomic, strong)  UIView *bottomView;
@property (nonatomic, strong)  UILabel *before_label;
@property (nonatomic, strong)  UILabel *expected_label;
@property (nonatomic, strong)  UILabel *published_label;
@property (nonatomic, strong)  UILabel *publishedValue_label;
@property (nonatomic, strong)  UIView *starView;
@property (nonatomic, strong)  UIImageView *starImage;
@property (nonatomic, strong)  UIButton *silverbtn;
@property (nonatomic, strong)  UIImageView *countryImage;

- (id)initWithDataStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;
@end
