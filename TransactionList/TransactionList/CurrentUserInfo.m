//
//  CurrentUserInfo.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "CurrentUserInfo.h"


@interface CurrentUserInfo ()
@property (nonatomic,strong) NSDictionary* user;
@end

@implementation CurrentUserInfo

+ (CurrentUserInfo *)defaultUserInfo{
    static CurrentUserInfo *userInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[CurrentUserInfo alloc] init];
    });
    return userInfo;
}

//登录成功，存储用户信息
- (BOOL)setUserInfo:(NSDictionary *)user{
    self.user = [user copy];
    return YES;
}

//用户登出，去除用户信息
- (BOOL)removeUserInfo{
    self.user = nil;
    return YES;
}

//使用用户信息
- (NSDictionary *)getUserInfo{
    return self.user;
}

@end
