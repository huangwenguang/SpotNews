//
//  ImageDB.m
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import "ImageT.h"
#import "FMDatabase.h"
#import "Util.h"
//@property (nonatomic , copy) NSData *original_image;
//@property (nonatomic , copy) NSData *small_image;
//@property (nonatomic , strong) NSString *datetime;
@implementation ImageT


+(BOOL)insertImage:(ImageObject *)obj
{
    //Share photos
    
    BOOL isComplete;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    if ([db open]) {
        NSString * sql = @"insert into sharephotos (type,original_image, small_image, datetime) values(?,?,?,?)";
        isComplete = [db executeUpdate:sql,[NSString stringWithFormat:@"%i",obj.type],obj.original_image,obj.small_image,obj.datetime];
        if (isComplete) {
            NSLog(@"ImageISObject 插入一条消息内容-成功");
        } else {
           NSLog(@"ImageISObject 插入一条消息内容-错误");
        }
        [db close];
    }
    return isComplete;
    
}


+(ImageObject *)getImageObject:(int)imageID
{
    ImageObject * object;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    if ([db open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from sharephotos where imageID=%i limit 0,1",imageID];
        FMResultSet * rs = [db executeQuery:sql];
        if ([rs next]) {
            object= [[ImageObject alloc] init];
            int imageID = [rs intForColumn:@"imageID"];
            int type = [rs intForColumn:@"type"];
            NSData * original_image = [rs dataForColumn:@"original_image"];
            NSData * small_image = [rs dataForColumn:@"small_image"];
            NSString * datetime = [rs stringForColumn:@"datetime"];
            object= [object initWithParameters:imageID type:type  original_image:original_image small_image:small_image  datetime:datetime];
        }
        [db close];
    }
    return object;
    
}

+(ImageObject *)getImageObj:(NSData *)small_image
{

    ImageObject * object;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    if ([db open]) {
        NSString *sql=@"select * from sharephotos where small_image=? limit 0,1";
        FMResultSet * rs = [db executeQuery:sql,small_image];
        if ([rs next]) {
            object= [[ImageObject alloc] init];
            int imageID = [rs intForColumn:@"imageID"];
            int type = [rs intForColumn:@"type"];
            NSData * original_image = [rs dataForColumn:@"original_image"];
            NSData * small_image = [rs dataForColumn:@"small_image"];
            NSString * datetime = [rs stringForColumn:@"datetime"];
            object= [object initWithParameters:imageID type:type  original_image:original_image small_image:small_image  datetime:datetime];
        }
        [db close];
    }
    return object;
}
+(BOOL)deleteImageObject:(int)imageID
{
    BOOL worked=NO;
    
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    if ([db open])
        
    {
        NSString *queryString=[NSString stringWithFormat:@"delete from sharephotos where imageID=%i",imageID];
        worked = [db executeUpdate:queryString];
        
    }
    [db close];
    return worked;
    
}
+(BOOL)updateImageObject:(ImageObject *)obj;
{
    
    NSLog(@"最新datetime%@",obj.datetime);
    BOOL worked=NO;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    
    if ([db open])
    {
        NSString *queryString=[NSString stringWithFormat:@"update sharephotos  set datetime='%@' where imageID=%i",obj.datetime,obj.imageID];
        worked = [db executeUpdate:queryString];
    }
    [db close];
    return worked;
}
+(NSMutableArray *)selectAll
{
    ImageObject * object;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    NSMutableArray * arrayList = [[NSMutableArray alloc] init];
    
    if ([db open]) {
        NSString *queryString=@"select * from sharephotos order by datetime desc ";
        FMResultSet *rs=[db executeQuery:queryString];
        
        while([rs next]) {
            object= [[ImageObject alloc] init];
            int imageID = [rs intForColumn:@"imageID"];
            int type = [rs intForColumn:@"type"];
            NSData * original_image = [rs dataForColumn:@"original_image"];
            NSData * small_image = [rs dataForColumn:@"small_image"];
            NSString * datetime = [rs stringForColumn:@"datetime"];
            NSLog(@"查询所有datetime%@",datetime);
            object= [object initWithParameters:imageID type:type  original_image:original_image small_image:small_image datetime:datetime];
            
            [arrayList addObject:object];

        }
        
        [db close];
    }
    return arrayList;
    
}
+(NSMutableArray *)selectArray:(int)type
{
    ImageObject * object;
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
    
    NSMutableArray *arrayList=[NSMutableArray array];
    if ([db open]) {
        NSString *queryString=[NSString stringWithFormat:@"select * from sharephotos where type=%i order by datetime desc ",type];;
        FMResultSet *rs=[db executeQuery:queryString];
        
        while([rs next]) {
            object= [[ImageObject alloc] init];
            int imageID = [rs intForColumn:@"imageID"];
            int type = [rs intForColumn:@"type"];
            NSData * original_image = [rs dataForColumn:@"original_image"];
            NSData * small_image = [rs dataForColumn:@"small_image"];
            NSString * datetime = [rs stringForColumn:@"datetime"];
            object= [object initWithParameters:imageID type:type  original_image:original_image small_image:small_image datetime:datetime];
            [arrayList addObject:object];

            
        }
        
        [db close];
    }
    //       NSArray *array = [NSArray arrayWithObject:arrayList];
    
    return arrayList;
}


@end
