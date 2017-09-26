//
//  LoginViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "LoginViewModel.h"
#import "DataBase+DBInterface.h"
#import "User.h"


@implementation LoginViewModel
- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        BOOL success = false;
        NSArray *arr = [[DataBase shareDataBase] findUser:username];
        if (arr.count > 0) {
            success = [password isEqualToString:arr[0][@"userPassword"]];
            if (success) {
                [[CurrentUserInfo defaultUserInfo] setUserInfo:arr[0]];
            }
        }
        completeBlock(success);
    });
}

@end
