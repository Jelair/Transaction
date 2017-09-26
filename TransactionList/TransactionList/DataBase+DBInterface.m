//
//  DataBase+DBInterface.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "DataBase+DBInterface.h"
#import "User.h"
#import "Task.h"
#import "Message.h"
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

//注销用户
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

- (BOOL)updateUserWithTel:(NSString *)userTel userId:(int)userId{
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'user' SET userTel = %@ WHERE userId = %d",userTel,userId];
    return [self noResultSetWithSql:sql];
}

- (BOOL)updateUserWithIcon:(NSString *)userIcon userId:(int)userId{
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'user' SET userIcon = %@ WHERE userId = %d",userIcon,userId];
    return [self noResultSetWithSql:sql];
}

- (BOOL)updateUserWithPassword:(NSString *)userPassword userId:(int)userId{
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'user' SET userPassword = %@ WHERE userId = %d",userPassword,userId];
    return [self noResultSetWithSql:sql];
}
#pragma mark -- 联系人操作接口
//返回一个用户的所有联系人
- (NSArray *)getAllContractByUser:(User *)user{
    NSString *sql = [NSString stringWithFormat:@"SELECT `user`.userId,`user`.userAge,`user`.userGender,`user`.userName,`user`.userTel,`user`.userIcon,userrelations.userRelationsTime FROM user RIGHT JOIN userrelations ON `user`.userId = userrelations.contractId WHERE `userRelations`.userId = %d",user.userId];
    NSArray *array = [self qureyWithSql:sql];
    return array;
}

//根据电话号码搜索联系人
- (NSArray *)searchContractByTel:(NSString *)tel{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM user WHERE userTel = '%@'",tel];
    NSArray *users = [self qureyWithSql:sql];
    return users;
}

//添加联系人
/**
 * @param contractId 要添加的联系人id
 * @param userId 使用者id
 */
- (BOOL)addContract:(int)contractId to:(int)userId{
    NSString *createTime = [TimeHelper getCurrentTime];
    NSString *sql = @"INSERT INTO userRelations(userId,contractId,userRelationsTime)VALUES(?,?,?)";
    NSArray *array1 = @[@(userId),@(contractId),createTime];
    BOOL addF = [self noResultSetWithSql:sql with:array1];
       NSArray *array2 = @[@(contractId),@(userId),createTime];
    BOOL addS = [self noResultSetWithSql:sql with:array2];
    return addF&&addS;
}

//删除联系人
- (BOOL)deleteContract:(int)contractId from:(int)userId{
    NSString *sql1 = [NSString stringWithFormat:@"DELETE FROM userRelations WHERE userId = %d AND contractId = %d",contractId,userId];
    NSString *sql2 = [NSString stringWithFormat:@"DELETE FROM userRelations WHERE userId = %d AND contractId = %d",userId,contractId];
    BOOL delF = [self noResultSetWithSql:sql1];
    BOOL delS = [self noResultSetWithSql:sql2];
    return delF&&delS;
}

#pragma mark -- 任务操作接口
//添加任务
- (BOOL)addTask:(Task *)task{
    NSString *sql = @"INSERT INTO task(taskStartTime,taskCreateTime,taskContent,taskPlace,taskOperator,taskIsFinish)VALUES(?,?,?,?,?,?)";
    NSArray *array = @[task.taskStartTime,task.taskCreateTime,task.taskContent,task.taskPlace,@(task.taskOperator),@(task.taskIsFinish)];
    BOOL b = [self noResultSetWithSql:sql with:array];
    return b;
}

//获取没做的任务
- (NSArray *)getUndoTaskDataBy:(int)userId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM task WHERE taskOperator = %d AND taskIsFinish = 0",userId];
    NSArray *array = [self qureyWithSql:sql];
    return array;
}

//获取已做的任务
- (NSArray *)getDidTaskDataBy:(int)userId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM task WHERE taskOperator = %d AND taskIsFinish = 1",userId];
    NSArray *array = [self qureyWithSql:sql];
    return array;
}

//更新任务状态
- (BOOL)finishTask:(int)taskId{
    NSString *sql = [NSString stringWithFormat:@"UPDATE 'task' SET taskIsFinish = 1 WHERE taskId = %d",taskId];
    BOOL b = [self noResultSetWithSql:sql];
    return b;
}

#pragma mark -- 消息操作接口

@end
