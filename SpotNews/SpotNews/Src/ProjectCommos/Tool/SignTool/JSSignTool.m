//
//  SignTool.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSSignTool.h"
static JSSignTool *_signTool;
@implementation JSSignTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharedSign {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _signTool = [[JSSignTool alloc] init];
        
        
    });
    return _signTool;
}
- (id)copyWithZone:(NSZone *)zone
{    return _signTool;
}
#pragma mark
-(NSMutableDictionary *)sortingArray:(NSMutableDictionary *)params

{
    NSEnumerator *enumerator = [params keyEnumerator];
    id key;
    NSArray *array=[NSArray array];
    NSArray *arrayOld=[NSArray array];
    while ((key = [enumerator nextObject])) {
        NSLog(@"key = %@", key);
        NSLog(@"value = %@", [params objectForKey:key]);
        NSString *str =[key stringByAppendingString:[params objectForKey:key]];
        array = [arrayOld arrayByAddingObject:str];
        arrayOld=array;
    }
    NSArray *newArray = [arrayOld sortedArrayUsingSelector:@selector(compare:)];//排序abc
    NSMutableDictionary *tempDic=[NSMutableDictionary dictionaryWithDictionary:params];
    NSString* string1, *string2,*string3,*string4,*string5,*strSig;
    string1=JSjin;
    string4=JS10;
    int count =(int)newArray.count;
    string2=@"";
    for( int i=0; i<count; i++){
        NSString *str=[newArray objectAtIndex:i];
        str= [string2 stringByAppendingString:str];
        string2=str;
    }
    string3 =[string1 stringByAppendingString:string2];
    string5=[string3 stringByAppendingString:string4];
    strSig=[self setSignStr:string5];
    [tempDic setObject:strSig forKey:@"sign"];
    return tempDic;
}
-(NSString *)setSignStr:(NSString *)strSign
{
    NSString *str=strSign;
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[self encodeString:str];
    //    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //    NSString *zhuanHuanHouDeShuJu = [[NSString alloc] initWithData:[strSign dataUsingEncoding:NSUTF8StringEncoding] encoding:gbkEncoding];//GBK
    //   strSign=[zhuanHuanHouDeShuJu stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//转换成UTF-8s
    // strSign= [zhuanHuanHouDeShuJu stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF-8转GBK
    str=[str md5];
    str=[str lowercaseString];
    return str;
    
}

-(NSString*)encodeString:(NSString*)unencodedString{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
@end
