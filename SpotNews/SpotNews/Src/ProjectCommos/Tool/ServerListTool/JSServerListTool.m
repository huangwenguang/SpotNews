//
//  JSServerListTool.m
//  SpotNews
//
//  Created by WenGuangHuang on 16/4/8.
//  Copyright © 2016年 jin10. All rights reserved.
//

#import "JSServerListTool.h"
static JSServerListTool *_sharedServer;
@implementation JSServerListTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharedServer {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
  
        _sharedServer = [[JSServerListTool alloc] init];
        
        
    });
    return _sharedServer;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _sharedServer;
}
-(void)getServerList
{
    
    NSString *path = [[NSString alloc] initWithFormat:JSMobileServer_URL];
    [APIRequest getHTTPSessionManager:path params:nil success:^(id responseObj) {
        NSLog(@"responseObj%@",responseObj);
        self.serverNomalList=[NSMutableArray arrayWithArray:responseObj];
        BOOL  isHave_min=NO;
        for (NSInteger i=0; i< self.serverNomalList.count; i++) {
            if ([ self.serverNomalList[i][@"State"] integerValue] == 0) {
                isHave_min=YES;
                NSString *ipStr=[NSString stringWithFormat:@"%@:%@", self.serverNomalList[i][@"IP"], self.serverNomalList[i][@"Port"]];
                [JSSaveTool setObject:ipStr forKey:JSServerNomal];
                break;
            }
        }
        if (!isHave_min) {
            BOOL isHave_mid=NO;
            for (NSInteger i=0; i< self.serverNomalList.count; i++) {
                if ([ self.serverNomalList[i][@"State"] integerValue] == 1) {
                    isHave_mid=YES;
                         NSString *ipStr=[NSString stringWithFormat:@"%@:%@", self.serverNomalList[i][@"IP"],self.serverNomalList[i][@"Port"]];
                     [JSSaveTool setObject:ipStr forKey:JSServerNomal];
                    break;
                }
            }
            if (!isHave_mid) {
            //    NSInteger  m_nomal=(arc4random() % _serverNomalList.count);
                NSInteger  m_nomal=(arc4random() % 1);
                NSLog(@"m_nomal %ld",(long)m_nomal);
                NSLog(@"_serverNomalList %@",_serverNomalList);
                NSString *ipStr=[NSString stringWithFormat:@"%@:%@",_serverNomalList[m_nomal][@"IP"],_serverNomalList[m_nomal][@"Port"]];
                  [JSSaveTool setObject:ipStr forKey:JSServerNomal];
            }
        }
        if (self.serverListBlock) {
            self.serverListBlock(self.serverNomalList);
        }
         [APISocket sharedSocket];
  
    } failure:^(id NSDictionary) {
            NSLog(@"NSDictionary%@",NSDictionary);
           self.serverNomalList=nil;
        if (self.serverListBlock) {
            self.serverListBlock(self.serverNomalList);
        }
    }];

}
@end
