//
//  MsgObject.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/11.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "MsgObject.h"
//快讯列表
#define kContentPadding 67 //内容距离2边的总和
#define LiveKFontSize  15
@implementation MsgObject
+ (instancetype)messageWithTempClass:(MsgAllObject *)temp {
    MsgObject *msg = [[MsgObject alloc] init];
    msg.newstimespan=temp.newstimespan;
    msg.content = temp.content;
    msg.publictime = temp.newstime;
    msg.important = temp.important == 0;
    msg.imageurl = [temp.pic stringByReplacingOccurrencesOfString:@"_lite" withString:@""];
    msg.url=temp.url;
    return msg;
}
+ (instancetype)messageWithString:(NSString *)str {
    NSArray *arr = [str componentsSeparatedByString:@"#"];
    
    return [self messageWithArray:arr];
}
+ (instancetype)messageWithArray:(NSArray *)arr {
    MsgObject *msg = [[MsgObject alloc] init];
    msg.content = arr[3];
    msg.publictime = [NSDate dateWithCNString:arr[2]];
    msg.url=arr[4];
    msg.important = ((NSString *)arr[1]).intValue == 0;
    msg.imageurl = arr[6];
    if (arr.count > 11) {
        msg.newstimespan = arr[11];
    }
    return msg;
}
-(void)setPublictime:(NSDate *)publictime{
    _publictime=publictime;
    _publictimeFormat=[publictime formatWithFormatString:@"HH:mm:ss"];
}
- (void)setContent:(NSString *)content {
    @try {
        content = [content stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
        NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:0 error:nil];
        
        content = [regularExpretion stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length) withTemplate:@""];
        NSString *tempContent=[content stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (tempContent.length==0) {
            content=tempContent;
        }
        _content = content;
        _retSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-kContentPadding,MAXFLOAT) options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[CommonUtils getFanTiFont:LiveKFontSize]} context:NULL].size;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}
@end
