//
//  NotificationHelper.h
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationHelper : NSObject

+ (void)registerNotificationwithTask:(NSDictionary *)task;

+ (void)cancelNotification:(int)taskId;
+ (void)cancelAllNotification;
@end
