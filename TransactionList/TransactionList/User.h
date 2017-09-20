//
//  User.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, assign) int userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userAccount;
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, assign) int userGender;
@property (nonatomic, assign) int userAge;
@property (nonatomic, strong) NSString *userTel;
@property (nonatomic, strong) NSString *userIcon;

@end
