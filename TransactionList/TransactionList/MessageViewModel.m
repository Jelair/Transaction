//
//  MessageViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MessageViewModel.h"
#import "DataBase+DBInterface.h"

@implementation MessageViewModel

- (void)getAllMessageWithBlock:(void(^)(id messageData))block{
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    NSArray *array = [[DataBase shareDataBase] getUndoMessageByUserId:userId];
    if (block) {
        block(array);
    }
}

- (void)getUserNameByUserId:(int)userId completeBlock:(void (^)(id data))block{

    NSArray *array = [[DataBase shareDataBase] getUserNameBy:userId];
    if (block) {
        block(array);
    }
}

- (void)sendMessageToContract:(int)contractId completeBlock:(void(^)(BOOL isSuccess))block{
    
}

@end
