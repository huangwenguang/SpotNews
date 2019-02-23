//
//  PhotoModel.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/30.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property (nonatomic, strong) NSString *photoID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)interfaceWithDict:(NSDictionary *)dict;
@end
