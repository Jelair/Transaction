//
//  DataBase.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
static DataBase *dataBase;
@interface DataBase ()<NSCopying, NSMutableCopying>{
    FMDatabase  *_db;
}

@end

@implementation DataBase

+ (DataBase *)shareDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[DataBase alloc] init];
        [dataBase initDataBase];
    });
    return dataBase;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (dataBase == nil) {
        dataBase = [super allocWithZone:zone];
    }
    return dataBase;
}

-(id)copy{
    return self;
}

-(id)mutableCopy{
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}

- (void)initDataBase{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    
    
    
    if ([manager fileExistsAtPath:filePath]) {
        NSLog(@"文件已存在");
        // 实例化FMDataBase对象
        _db = [FMDatabase databaseWithPath:filePath];
        return;
    }
    
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
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    if ([_db open]) {
        NSLog(@"数据库打开成功");
        // 初始化数据表
        for (NSString* sql in sqls) {
            BOOL isOk = [_db executeUpdate:sql];
            if (isOk) {
                NSLog(@"表创建成功");
            }else{
                NSLog(@"表创建失败");
            }
        }
        [_db close];
    }
}

#pragma mark -- operate database
//打开数据库
- (BOOL)openDB{

    if ([_db open]) {
        NSLog(@"数据库打开成功");
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        return NO;
    }
}

//关闭数据库
- (void)closeDB{
    BOOL isClose = [_db close];
    if (isClose) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
    }
}

//无结果集操作
- (BOOL)noResultSetWithSql:(NSString *)sql{
    if ([self openDB]) {
        BOOL isUpdate = [_db executeUpdate:sql];
        [self closeDB];
        return isUpdate;
    }else{
        [self closeDB];
        return NO;
    }
}

- (BOOL)noResultSetWithSql:(NSString *)sql with:(NSArray *)array{
    if ([self openDB]) {
        BOOL isUpdate = [_db executeUpdate:sql withArgumentsInArray:array];
        [self closeDB];
        return isUpdate;
    }else{
        [self closeDB];
        return NO;
    }
}

//有返回结果集的操作
- (NSArray *)qureyWithSql:(NSString *)sql{
    if ([self openDB]) {
        FMResultSet *resultSet = [_db executeQuery:sql];
        NSMutableArray *resultArray = [NSMutableArray array];
        while ([resultSet next]) {
            NSDictionary *dic = [resultSet resultDictionary];
            [resultArray addObject:dic];
        }
        [resultSet close];
        [self closeDB];
        return resultArray;
    }else{
        return nil;
    }
}

@end
