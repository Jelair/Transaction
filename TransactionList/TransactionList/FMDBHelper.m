//
//  FMDBHelper.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "FMDBHelper.h"
#import <FMDB.h>

@interface FMDBHelper ()

//数据库文件路径
@property (strong, nonatomic) NSString *fileName;

//数据库对象
@property (strong, nonatomic) FMDatabase *dataBase;
@end

@implementation FMDBHelper

+ (FMDBHelper *)sharedFMDBHelper{
    static FMDBHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[FMDBHelper alloc] init];
    });
    return helper;
}

- (void)createDBWithName:(NSString *)dbName{
    if (dbName.length == 0) {
        self.fileName = nil;
    }else{
        if ([dbName hasSuffix:@".sqlite"]) {
            self.fileName = dbName;
        }else{
            self.fileName = [dbName stringByAppendingString:@".sqlite"];
        }
    }
}

//初始化表
- (void)initDataBaseWithSqls:(NSArray *)sqls{
    self.fileName = @"model.sqlite";
    
    
//    // 1、获取沙盒中数据库的路径
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fullPath =  [path stringByAppendingPathComponent:self.fileName];
//    // 2、判断 caches 文件夹是否存在.不存在则创建
//    NSFileManager *manager = [NSFileManager defaultManager];
//    BOOL tag = [manager fileExistsAtPath:path isDirectory:NULL];
//    
//    if (!tag) {
//        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
//    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[self DBPath]]){
        //NSLog(@"%s--%@",__FUNCTION__, [self DBPath]);
        if(![self openDB]){
            for (NSString *sql in sqls) {
                BOOL isSuc = [self.dataBase executeUpdate:sql];
                if (isSuc) {
                    NSLog(@"表创建成功");
                }else{
                    NSLog(@"表创建失败");
                }
                
            }
            
            [self closeDB];
        }
    }
}

//根据名称创建沙盒路径
- (NSString *)DBPath{
    if (self.fileName) {
        NSString *savePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",self.fileName]];
        
        return savePath;
    }else{
        return @"";
    }
}

//懒加载数据库对象
- (FMDatabase *)dataBase{
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:[self DBPath]];
    }
    return _dataBase;
}

//打开数据库
- (BOOL)openDB{
    if (!self.dataBase) {
        NSLog(@"no database");
        return NO;
    }
    if ([self.dataBase open]) {
        NSLog(@"数据库打开成功");
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        return NO;
    }
}

//关闭数据库
- (void)closeDB{
    BOOL isClose = [self.dataBase close];
    if (isClose) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
    }
}

//无结果集操作
- (BOOL)noResultSetWithSql:(NSString *)sql{
    if ([self openDB]) {
        BOOL isUpdate = [self.dataBase executeUpdate:sql];
        [self closeDB];
        return isUpdate;
    }else{
        [self closeDB];
        return NO;
    }
}

- (BOOL)noResultSetWithSql:(NSString *)sql with:(NSArray *)array{
    if ([self openDB]) {
        BOOL isUpdate = [self.dataBase executeUpdate:sql withArgumentsInArray:array];
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
        FMResultSet *resultSet = [self.dataBase executeQuery:sql];
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
