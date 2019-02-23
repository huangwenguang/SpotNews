//
//  ImageDB.h
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageObject.h"
#import "DatabaseManager.h"
@interface ImageT : DatabaseManager

/**
 *   插入一条数据
 *
 *  @param obj ImageDB 模型
 */
+(BOOL)insertImage:(ImageObject *)obj;
/**
 *  根据imageID查询一条记录
 *
 *  @param imageID imageID
 *
 *  @return ImageISObject
 */
+(ImageObject *)getImageObject:(int)imageID;
/**
 *  根据small_image查询一条记录
 *
 *  @param imageID imageID
 *
 *  @return ImageISObject
 */
+(ImageObject *)getImageObj:(NSData *)small_image;

/**
 *  根据imageID删除一条记录
 *
 *  @param imageID imageID
 *
 *  @return deleteImageObject
 */
+(BOOL)deleteImageObject:(int)imageID;

/**
 *  更新ImageDB模型
 *
 *  @param obj ImageDB
 *
 *  @return BOOL
 */
+(BOOL)updateImageObject:(ImageObject *)obj;


/**
 *  查询所有数据
 *
 *  @return NSMutableArray
 */
+(NSMutableArray *)selectAll;
/**
 *  根据类型查询
 *
 *  @param type type
 *
 *  @return NSMutableArray
 */
+(NSMutableArray *)selectArray:(int)type;

@end
