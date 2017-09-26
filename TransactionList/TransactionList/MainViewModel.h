//
//  MainViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject

- (void)getTaskData:(void(^)(id taskData))block;

- (void)getAllTaskData:(void(^)(id taskData))block;

- (void)finishTaskWithTask:(int)taskId complete:(void (^)(BOOL))block;

@end
