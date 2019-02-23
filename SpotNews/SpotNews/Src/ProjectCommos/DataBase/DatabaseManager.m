//
//  DatabaseManager.m
//  Ucan_3D
//
//  Created by carmen on 15/4/20.
//  Copyright (c) 2015年 ucanmoblie. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"
#import "Util.h"

@implementation DatabaseManager



-(void)createImageT
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[CommonUtils DBpath]]) {
        [CommonUtils DBpath];
    }
    FMDatabase * db = [FMDatabase databaseWithPath:[CommonUtils DBpath]];
//    NSLog(@"k_URLDB%@",[Common DBpath]);
    if ([db open]) {
        NSString * sql = @"CREATE TABLE IF NOT EXISTS sharephotos ('imageID' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,'type' INTEGER ,'original_image' blob,'small_image' blob,  datetime TimeStamp NOT NULL DEFAULT (datetime('now','localtime')))";
        
        if ([db executeUpdate:sql]) {
            NSLog(@"create success");
        }
        else {
            NSLog(@"create fail");
        }
        [db close];
    }
    else {
       NSLog(@"open database error");
    }
    
}
static DatabaseManager * instance = nil;
+ (DatabaseManager *) Instance
{
        if(nil == instance)
        {
            instance=[[self alloc] init];
        }

    return instance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}
@end
