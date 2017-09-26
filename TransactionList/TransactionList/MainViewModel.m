//
//  MainViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MainViewModel.h"
#import "DataBase+DBInterface.h"

@implementation MainViewModel

- (void)getTaskData:(void (^)(id))block{
    NSArray *array = [[DataBase shareDataBase] getUndoTaskDataBy:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    if (block) {
        block(array);
    }
}

- (void)finishTaskWithTask:(int)taskId complete:(void (^)(BOOL))block{
    BOOL b = [[DataBase shareDataBase] finishTask:taskId];
    if (block) {
        block(b);
    }
}

@end
