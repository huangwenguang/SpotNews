//
//  ImageObject.h
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageObject : NSObject
@property (nonatomic , assign) int imageID;
@property (nonatomic , assign) int type;
@property (nonatomic , copy) NSData *original_image;
@property (nonatomic , copy) NSData *small_image;
@property (nonatomic , strong) NSString *datetime;


//insert Model
- (id)initWithParameters:(int)type
           original_image:(NSData *)original_image
               small_image:(NSData *)small_image
                datetime:(NSString *)datetime;

//select Model
- (id)initWithParameters:(int)imageID
                    type:(int)type
          original_image:(NSData *)original_image
             small_image:(NSData *)small_image
                datetime:(NSString *)datetime;
@end