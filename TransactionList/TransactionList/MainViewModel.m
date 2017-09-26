//
//  MainViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MainViewModel.h"
#import "DataBase+DBInterface.h"
#import "NotificationHelper.h"

@interface MainViewModel ()

@end

@implementation MainViewModel

- (void)getTaskData:(void (^)(id))block{
    NSArray *array = [[DataBase shareDataBase] getUndoTaskDataBy:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    NSArray *newArr = [self selectTheTodayTaskFromArray:array];
    NSArray *array2 = [newArr copy];
    [self addNotificationWithArray:array2];
    if (block) {
        block(newArr);
    }
}

- (void)getAllTaskData:(void(^)(id taskData))block{
    NSArray *array = [[DataBase shareDataBase] getDidTaskDataBy:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    if (block) {
        block(array);
    }
}

- (void)addNotificationWithArray:(NSArray *)array{
    [NotificationHelper cancelAllNotification];
    for (NSDictionary *dic in array) {
        [NotificationHelper registerNotificationwithTask:dic];
    }
}

- (NSArray *)selectTheTodayTaskFromArray:(NSArray *)array{
    NSArray *temp = array;
    NSMutableArray *mutableArr = [NSMutableArray array];
    NSString *curTime = [[TimeHelper getCurrentTime] substringToIndex:10];
    for (NSDictionary *dic in temp) {
        NSString *newTime = [dic[@"taskStartTime"] substringToIndex:10];
        if ([newTime isEqualToString:curTime]) {
            [mutableArr addObject:dic];
        }
    }
    
    NSArray *arr = [mutableArr copy];
    return arr;
}

- (void)finishTaskWithTask:(int)taskId complete:(void (^)(BOOL))block{
    BOOL b = [[DataBase shareDataBase] finishTask:taskId];
    if (block) {
        block(b);
    }
}

@end
