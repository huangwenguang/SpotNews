//
//  APIRequest.m
//  SanYouDemo
//
//  Created by hwg on 15/9/22.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import "APIRequest.h"

static APIRequest *_sharedClient;
@implementation APIRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(instancetype)sharedClient {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [_sharedClient.requestSerializer setTimeoutInterval:JSWebViewDefaultTimeOut];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
        _sharedClient.responseSerializer=[AFHTTPResponseSerializer serializer];
        _sharedClient.requestSerializer=[AFHTTPRequestSerializer serializer];
        _sharedClient = [[APIRequest alloc] init];
       
      
    });
    return _sharedClient;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _sharedClient;
}

+(void)postURLSessionTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure
{

    NSLog(@"url__%@",url);
    NSURLSessionTask *task=[[APIRequest sharedClient] POST:url parameters:params progress:^(NSProgress *progress)
                        {
                                NSLog(@"%@",progress);
                                
                            } success:^(NSURLSessionDataTask *task, id JSON)
                            {
                                        success(JSON);
                            }failure:^(NSURLSessionDataTask *task, NSError *error)
                            {
                                        failure([self addDictionary:error]);
                            }];
    [task resume];
 
}


+(void)getURLSessionTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure
{

    NSURLSessionTask *task=[[APIRequest sharedClient] GET:url parameters:params progress:^(NSProgress *progress)
                            {
                                NSLog(@"%@",progress);
                                
                            } success:^(NSURLSessionDataTask *task, id JSON)
                            {
                                 success(JSON);
                                
                            }failure:^(NSURLSessionDataTask *task, NSError *error)
                            {
                                   failure([self addDictionary:error]);
                                
                            }];
    [task resume];


}

+(void)URLSessionDataTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
 
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
             success(responseObject);
           // NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];

}

+(void)getHTTPSessionManager:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager GET:url parameters:params progress:^(NSProgress *progress)
     {
         NSLog(@"%@",progress);
     
     } success:^(NSURLSessionDataTask *operation, id responseObject)
        {
       
         
                success(responseObject);
            
          
        }failure:^(NSURLSessionDataTask *operation, NSError *error)
       {
           failure([self addDictionary:error]);
       }];
}

+(void)postHTTPSessionManager:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager POST:url parameters:params progress:^(NSProgress *progress)
     {
         NSLog(@"%@",progress);
         
     } success:^(NSURLSessionDataTask *operation, id responseObject)
     {
         
         
         success(responseObject);
         
         
     }failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         failure([self addDictionary:error]);
     }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id responseObj))success failure:(void (^)(NSError * error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (IWFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    }  progress:^(NSProgress *progress)
     {
         NSLog(@"%@",progress);
         
     }success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(NSDictionary *)setDicttionary:(NSDictionary *)params
{

   NSMutableDictionary *tempDic=[NSMutableDictionary dictionaryWithDictionary:params];
//    [tempDic setObject:JSPlatform forKey:@"platform"];
//    
//    [tempDic setObject:[CommonUtils models] forKey:@"models"];
//    [tempDic setObject: [[UIDevice currentDevice] systemVersion] forKey:@"systemVersion"];
//     [tempDic setObject:JSCurVersion forKey:@"appVersion"];
//    [tempDic setObject:kSystemType forKey:@"systemType"];
//    NSString *userId=[[NSUserDefaults standardUserDefaults] stringForKey:k_UserInfo_userId];
//    NSString *token=[[NSUserDefaults standardUserDefaults] stringForKey:k_UserInfo_token];
//    if(userId.length>0&&userId!=nil)
//    {
//        [tempDic setObject:userId forKey:@"userId"];
//    }else
//    {
//     [tempDic setObject:@"" forKey:@"userId"];
//    }
//    
//    
//    if(token.length>0&&token!=nil)
//    {
//        [tempDic setObject:token forKey:@"token"];
//    }
//    else
//    {
//        [tempDic setObject:@"" forKey:@"token"];
//    }
     return [NSDictionary dictionaryWithDictionary:tempDic];
 
}


+(NSDictionary *)addDictionary:(NSError *)error
{
    NSDictionary *dic=error.userInfo;
    NSMutableDictionary *tempDic=[NSMutableDictionary dictionaryWithDictionary:dic];
    [tempDic setObject:[NSString stringWithFormat:@"%i",(int)error.code] forKey:@"Code"];
    return [NSDictionary dictionaryWithDictionary:tempDic];
}

+(BOOL) APISuccess:(NSDictionary *) dic{
    if (dic == nil) return NO;
    if ([dic objectForKey:@"status"] == nil){
        
        return NO;
    }
    if ([[dic valueForKey:@"status"] intValue] ==1){
        return YES;
    }
    return NO;
}
//+(void)logOut
//{
//    [[UserInfoObject  currentUser] logOut];
//    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//       UIWindow *keyv=[UIApplication sharedApplication].keyWindow;
//    [keyv setRootViewController:[[UINavigationController alloc]
//                                        initWithRootViewController:loginViewController]];
//}

+(NSInteger ) APIErrorCode:(NSDictionary *) dic{
    if (dic == nil) return -1;
    if ([dic objectForKey:@"status"] == nil){
        return -1;
    }
    return [[dic valueForKey:@"status"] intValue];
}

+(void)showNetworkError:(NSDictionary *)dict
{
    
    if ([[dict allKeys] containsObject:@"status"])
    {
        //  [[JSBaseViewController sharedBase] showErrorWithText:[dict valueForKey:@"message"]];
        //[[dict valueForKey:@"message"] intValue];

    }else
    {
        [self AFNetworkingErrorDomain:dict];
    }
    return;
    
}

+(void)AFNetworkingErrorDomain:(NSDictionary *) dict
{

    int code=[[dict objectForKey:@"Code"] intValue];
    switch (code) {
        case -1001:
        {
      //      [[JSBaseViewController sharedBase] showErrorWithText:@"网络连接不稳定，请稍后重试"];
        }
            break;
            
        default:
        {
            NSString *error=[NSString stringWithFormat:@"网络错误:%i",code];
             //   [[JSBaseViewController sharedBase] showErrorWithText:error];
        }
            break;
    }
}



@end
@implementation IWFormData

@end
