//
//  RecordViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 25/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordViewModel : NSObject

//定义接口接受数据并返回回调
- (void)addTaskWithContent:(NSString *)content place:(NSString *)place time:(NSString *)time completeHandle:(void(^)(BOOL isSuccess))block;

@end
