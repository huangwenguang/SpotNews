//
//  InterfaceModel.h
//  Screenshots
//
//  Created by WenGuangHuang on 16/3/29.
//  Copyright © 2016年 WenGuangHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceModel : NSObject

@property (nonatomic, strong) NSString *ID;

@property (nonatomic, strong) NSString *interName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)interfaceWithDict:(NSDictionary *)dict;
@end
