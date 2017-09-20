//
//  FMDBHelper+FMDBInterface.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "FMDBHelper+FMDBInterface.h"
#import "User.h"
#import "TimeHelper.h"

@implementation FMDBHelper (FMDBInterface)


//初始化表
- (void)initDataBase{
    
                        //用户表
    NSArray *sqls = @[@"CREATE TABLE 'user' ('userId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'userName' VARCHAR(30), 'userAccount' VARCHAR(30), 'userPassword' VARCHAR(30), 'userGender' INTEGER, 'userAge' INTEGER, 'userTel' VARCHAR(11), 'userIcon' VARCHAR(50))",
                      //用户关系表
                      @"CREATE TABLE 'userRelations' ('userRelationsId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'userId' INTEGER, 'contractId' INTEGER, 'userRelationsTime' VARCHAR(30))",
                      //任务表
                      @"CREATE TABLE 'task' ('taskId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'taskStartTime' VARCHAR(30), 'taskCreateTime' VARCHAR(30), 'taskContent' VARCHAR(50), 'taskPlace' VARCHAR(20), 'taskOperator' VARCHAR(10), 'taskObject' VARCHAR(10), 'taskIsFinish' INTEGER)",
                      //用户任务关系表
                      @"CREATE TABLE 'utRelations' ('utRelationsId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'userId' INTEGER, 'taskId' INTEGER), 'distributeTime' VARCHAR(30)",
                      //消息表
                      @"CREATE TABLE 'message' ('messageId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'messageType' INTEGER, 'messageContent' VARCHAR(100), 'messageSendTime' VARCHAR(30), 'messageIsRead' INTEGER, 'messageSenderId' INTEGER)",
                      //用户消息关系表
                      @"CREATE TABLE 'umRelations' ('umRelationsId' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'recipientId' INTEGER, 'messageId' INTEGER)"];
    [self initDataBaseWithSqls:sqls];
}


#pragma mark -- 用户操作接口
//添加用户
- (BOOL)addUser:(User *)user{
    NSString *sql = @"INSERT INTO user(userName,userAccount,userPassword,userGender,userAge,userTel,userIcon)VALUES(?,?,?,?,?,?,?)";
    NSArray *array = @[user.userName,user.userAccount,user.userPassword,@(user.userGender),@(user.userAge),user.userTel,user.userIcon];
    return [self noResultSetWithSql:sql with:array];
}

//查找用户
- (NSDictionary *)findUser:(NSString *)userAccount{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM user WHERE userAccount = %@",userAccount];
    NSDictionary *user = [self qureyWithSql:sql][0];
    return user;
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
