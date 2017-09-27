//
//  ContractViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ContractViewModel.h"
#import "DataBase+DBInterface.h"
#import "Message.h"

@implementation ContractViewModel

- (void)getAllContracts:(void(^)(id contractData))block{
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    NSArray *array = [[DataBase shareDataBase] getAllContractByUser:userId];
    if (block) {
        block(array);
    }
}

- (void)deleteContractByContractId:(int)contractId completeBlock:(void(^)(BOOL isSuccess))block{
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    BOOL b = [[DataBase shareDataBase] deleteContract:contractId from:userId];
    if (block) {
        block(b);
    }
}

- (void)searchContractByTel:(NSString *)tel completeBlock:(void(^)(id contractData))block{
    NSArray *array = [[DataBase shareDataBase] searchContractByTel:tel];
    if (block) {
        block(array);
    }
}

- (void)applyContractWith:(int)contractId completeBlock:(void(^)(BOOL isSuccess))block{
    int userId = [[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue];
    Message *msg = [Message new];
    msg.messageIsRead = 0;
    msg.messageSenderId = userId;
    msg.messageSendTime = [TimeHelper getCurrentTime];
    msg.messageContent = @"对方请求添加您为联系人";
    msg.messageType = 1;
    BOOL b = [[DataBase shareDataBase] applyContractWith:msg to:contractId];
    if (block) {
        block(b);
    }
}

@end
