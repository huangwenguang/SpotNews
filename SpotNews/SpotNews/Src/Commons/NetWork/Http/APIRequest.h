//
//  APIRequest.h
//  SanYouDemo
//
//  Created by hwg on 15/9/22.
//  Copyright © 2015年 sanyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface APIRequest : AFHTTPSessionManager<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
+(instancetype)sharedClient;
+(void)getURLSessionTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure;

+(void)postURLSessionTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure;


+(void)URLSessionDataTask:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure;

+(void)getHTTPSessionManager:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure;
+(void)postHTTPSessionManager:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(id NSDictionary))failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)showNetworkError:(NSDictionary *)dict;
+(void)AFNetworkingErrorDomain:(NSDictionary *) dict;

@end

@interface IWFormData : NSObject
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *mimeType;
@end
