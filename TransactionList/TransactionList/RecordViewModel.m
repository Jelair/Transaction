//
//  RecordViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 25/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "RecordViewModel.h"
#import "RecordModel.h"
#import "TimeHelper.h"
#import "DataBase+DBInterface.h"

@implementation RecordViewModel

- (void)addTaskWithContent:(NSString *)content place:(NSString *)place time:(NSString *)time completeHandle:(void (^)(BOOL))block{
    RecordModel *model = [RecordModel new];
    model.taskContent = content;
    model.taskPlace = place;
    model.taskStartTime = time;
    model.taskCreateTime = [TimeHelper getCurrentTime];
    model.taskIsFinish = 0;
    model.taskOperator = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    BOOL result = [[DataBase shareDataBase] addTask:model];
    if (block) {
        block(result);
    }
}

@end
