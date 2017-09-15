//
//  CMRequest.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@class CMRequest;
@protocol CMRequestDelegate <NSObject>

- (void)CMRequest:(CMRequest *)request finished:(NSString *)response;
- (void)CMRequest:(CMRequest *)request Error:(NSString *)error;

@end

@interface CMRequest : NSObject

@property (assign) id <CMRequestDelegate> delegate;

@property (nonatomic, strong) AFHTTPSessionManager* operationManager;
@property (nonatomic, strong) NSOperationQueue* operationQueue;

+ (instancetype)request;

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(CMRequest *, NSString *))success
    failure:(void (^)(CMRequest *, NSError *))failure;

- (void)POST:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(CMRequest *, NSString *))success
    failure:(void (^)(CMRequest *, NSError *))failure;

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary*)parameters;
- (void)getWithURL:(NSString*)URLString;

- (void)cancelAllOperations;

@end
