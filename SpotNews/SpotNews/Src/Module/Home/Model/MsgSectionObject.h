//
//  MsgSectionObject.h
//  JinShi
//
//  Created by GU on 15/5/7.
//  Copyright (c) 2015年 jin10.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgSectionObject : NSObject

@property(nonatomic,strong) NSDate *sectionTime;
@property(nonatomic,strong) NSMutableArray *msgObjectList;
@end
