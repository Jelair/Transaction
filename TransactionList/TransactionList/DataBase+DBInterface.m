//
//  DataBase+DBInterface.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "DataBase+DBInterface.h"
#import "User.h"
#import "TimeHelper.h"

@implementation DataBase (DBInterface)

#pragma mark -- 用户操作接口
//添加用户
- (BOOL)addUser:(User *)user{
    NSString *sql = @"INSERT INTO user(userName,userAccount,userPassword,userGender,userAge,userTel,userIcon)VALUES(?,?,?,?,?,?,?)";
    NSArray *array = @[user.userName,user.userAccount,user.userPassword,@(user.userGender),@(user.userAge),user.userTel,user.userIcon];
    return [self noResultSetWithSql:sql with:array];
}

//查找用户
- (NSArray *)findUser:(NSString *)userAccount{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM user WHERE userAccount = '%@'",userAccount];
    NSArray *users = [self qureyWithSql:sql];
    return users;
}

- (void)lookUsers{
    NSArray *users = [self qureyWithSql:@"SELECT * FROM user"];
    NSLog(@"%s----%@",__FUNCTION__,users);
}

//删除用户
- (BOOL)deleteUser:(User *)user{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM user WHERE userId = %d", user.userId];
    return [self noResultSetWithSql:sql];
}

//更新用户,只开放修改用户密码，电话，头像
- (BOOL)updateUser:(User *)user{
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'user' SET userPassword = ?, userTel = ?, userIcon = ? WHERE userId = ? "];
    NSArray *array = @[user.userPassword,user.userTel,user.userIcon,@(user.userId)];
    return [self noResultSetWithSql:sql with:array];
}

#pragma mark -- 联系人操作接口
//返回一个用户的所有联系人
- (NSArray *)getAllContractByUser:(User *)user{
    return nil;
}

//添加联系人
- (BOOL)addContract:(int)contractId to:(int)userId{
    NSString *sql = @"INSERT INTO userRelations(userId,contractId,userRelationsTime)VALUES(?,?,?)";
    NSArray *array = @[@(userId),@(contractId),[TimeHelper getCurrentTime]];
    return [self noResultSetWithSql:sql with:array];
}

#pragma mark -- 任务操作接口

#pragma mark -- 消息操作接口

@end
