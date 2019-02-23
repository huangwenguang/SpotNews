//
//  ImageObject.m
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject


- (id)initWithParameters:(int)type
          original_image:(NSData *)original_image
             small_image:(NSData *)small_image
                datetime:(NSString *)datetime
{
    
    ImageObject *object=[[ImageObject alloc] init];
    object.type=type;
    object.original_image=original_image;
    object.small_image=small_image;
    object.datetime=datetime;

    return object;
}
- (id)initWithParameters:(int)imageID
                    type:(int)type
          original_image:(NSData *)original_image
             small_image:(NSData *)small_image
                datetime:(NSString *)datetime;
{
    
    ImageObject *object=[[ImageObject alloc] init];
    object.imageID=imageID;
    object.type=type;
    object.original_image=original_image;
    object.small_image=small_image;
    object.datetime=datetime;
    return object;
}
@end
