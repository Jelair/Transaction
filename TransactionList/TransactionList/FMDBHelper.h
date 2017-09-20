//
//  FMDBHelper.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBHelper : NSObject

//单例
+ (FMDBHelper *)sharedFMDBHelper;


- (void)initDataBaseWithSqls:(NSArray *)sqls;

//无结果集
- (BOOL)noResultSetWithSql:(NSString *)sql;
- (BOOL)noResultSetWithSql:(NSString *)sql with:(NSArray *)array;

//有结果集
- (NSArray *)qureyWithSql:(NSString *)sql;

@end
