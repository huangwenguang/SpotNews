//
//  SignTool.h
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Str.h"

@interface JSSignTool : NSObject
+(instancetype)sharedSign;
-(NSMutableDictionary *)sortingArray:(NSMutableDictionary *)params;
@end
