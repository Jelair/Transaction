//
//  Task.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, assign) int taskId;
@property (nonatomic, strong) NSString *taskStartTime;
@property (nonatomic, strong) NSString *taskCreateTime;
@property (nonatomic, strong) NSString *taskContent;
@property (nonatomic, strong) NSString *taskPlace;
@property (nonatomic, assign) int taskOperator;
@property (nonatomic, assign) int taskIsFinish;

@end
