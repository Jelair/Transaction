//
//  NotificationHelper.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "NotificationHelper.h"
#import <UserNotifications/UserNotifications.h>

@implementation NotificationHelper

+ (void)registerNotificationwithTask:(NSDictionary *)task{
    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = task[@"taskPlace"];
    content.subtitle = task[@"taskStartTime"];
    content.body = task[@"taskContent"];
    content.sound = [UNNotificationSound defaultSound];
    
    NSTimeInterval alertTime = [[TimeHelper stringToDateWith:task[@"taskStartTime"]] timeIntervalSinceNow];
    //创建通知触发
    if (alertTime < 0) {
        return;
    }
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alertTime repeats:NO];
    NSMutableString *identifier = [NSMutableString stringWithFormat:@"identifier"];
    
    [identifier appendFormat:@"%@",task[@"taskId"]];
    //创建通知请求
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    //将请求加入通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加通知");
        }
    }];
}

+ (void)registerNotification:(NSTimeInterval)alertTime with:(NSString *)str{
    //创建通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"有任务啦";
    content.subtitle = @"2017-09-27 9:00";
    content.body = @"eat a break afternoon";
    content.sound = [UNNotificationSound defaultSound];
    
    //创建通知触发
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alertTime repeats:NO];
    
    //创建通知请求
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:str content:content trigger:trigger];
    
    //将请求加入通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加通知");
        }
    }];
}

+ (void)cancelAllNotification{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllDeliveredNotifications];
    [center removeAllPendingNotificationRequests];
}

+ (void)cancelNotification:(int)taskId{
    NSMutableString *identifier = [NSMutableString stringWithFormat:@"identifier"];
    [identifier appendFormat:@"%d",taskId];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

@end
