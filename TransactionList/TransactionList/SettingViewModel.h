//
//  SettingViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingViewModel : NSObject

- (void)changeTelWith:(NSString *)tel complete:(void(^)(BOOL isSuccess))block;
- (void)changePasswordWith:(NSString *)password complete:(void(^)(BOOL isSuccess))block;
- (void)changeUserIconWith:(NSString *)iconStr complete:(void(^)(BOOL isSuccess))block;

@end
