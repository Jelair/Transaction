//
//  SettingViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "SettingViewModel.h"
#import "DataBase+DBInterface.h"

@implementation SettingViewModel

- (void)changeTelWith:(NSString *)tel complete:(void (^)(BOOL))block{
    BOOL b = [[DataBase shareDataBase] updateUserWithTel:tel userId:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    
    NSArray *dic = [[DataBase shareDataBase] findUser:[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userAccount"]];
    [[CurrentUserInfo defaultUserInfo] setUserInfo:dic[0]];
    if (block) {
        block(b);
    }
}

- (void)changePasswordWith:(NSString *)password complete:(void(^)(BOOL isSuccess))block{
    BOOL b = [[DataBase shareDataBase] updateUserWithPassword:password userId:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    
    NSArray *dic = [[DataBase shareDataBase] findUser:[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userAccount"]];
    [[CurrentUserInfo defaultUserInfo] setUserInfo:dic[0]];
    if (block) {
        block(b);
    }
}

- (void)changeUserIconWith:(NSString *)iconStr complete:(void(^)(BOOL isSuccess))block{
    BOOL b = [[DataBase shareDataBase] updateUserWithIcon:iconStr userId:[[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userId"] intValue]];
    
    NSArray *dic = [[DataBase shareDataBase] findUser:[[CurrentUserInfo defaultUserInfo] getUserInfo][@"userAccount"]];
    [[CurrentUserInfo defaultUserInfo] setUserInfo:dic[0]];
    if (block) {
        block(b);
    }
}

@end
