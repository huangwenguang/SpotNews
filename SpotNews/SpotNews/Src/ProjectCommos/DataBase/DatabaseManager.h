//
//  DatabaseManager.h
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

-(void)createImageT;

+ (DatabaseManager *) Instance;
+ (id)allocWithZone:(NSZone *)zone;
@end
