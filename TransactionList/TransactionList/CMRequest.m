//
//  CMRequest.m
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "CMRequest.h"

@implementation CMRequest

+ (instancetype)request{
    return [[self alloc] init];
}

- (instancetype)init{
    if (self=[super init]) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(CMRequest *, NSString *))success failure:(void (^)(CMRequest *, NSError *))failure{
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[CMRequest：%@]",responseJson);
        success(self, responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[CMRequest]:%@", error.localizedDescription);
        failure(self,error);
    }];
}

- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(CMRequest *, NSString *))success failure:(void (^)(CMRequest *, NSError *))failure{
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.operationManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"[CMRequest：%@]",responseJson);
        success(self, responseJson);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[CMRequest]:%@", error.localizedDescription);
        failure(self,error);
    }];
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters{
    [self POST:URLString parameters:parameters success:^(CMRequest *request, NSString *responseString) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
            [self.delegate CMRequest:request finished:responseString];
        }
    } failure:^(CMRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
            [self.delegate CMRequest:request Error:error.description];
        }
    }];
}

- (void)getWithURL:(NSString *)URLString{
    [self GET:URLString parameters:nil success:^(CMRequest *request, NSString *responseString) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:finished:)]) {
            [self.delegate CMRequest:request finished:responseString];
        }
    } failure:^(CMRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(CMRequest:Error:)]) {
            [self.delegate CMRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
