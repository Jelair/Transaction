//
//  LoginViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RWSignInResponse)(BOOL);
@interface LoginViewModel : NSObject


- (void)signInWithUsername:(NSString *)username password:(NSString *)password complete:(RWSignInResponse)completeBlock;
@end
