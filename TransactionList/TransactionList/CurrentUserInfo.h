//
//  CurrentUserInfo.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CurrentUserInfo : NSObject

//单例生成唯一对象
+ (CurrentUserInfo *)defaultUserInfo;
//登录成功，存储用户信息
- (BOOL)setUserInfo:(NSDictionary *)user;

//用户登出，去除用户信息
- (BOOL)removeUserInfo;

//使用用户信息
- (NSDictionary *)getUserInfo;
@end
