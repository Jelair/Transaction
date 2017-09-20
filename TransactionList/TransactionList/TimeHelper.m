//
//  TimeHelper.m
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

+ (TimeHelper *)shareTimeHelper{
    static TimeHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [TimeHelper new];
    });
    return helper;
}

+ (NSString *)getCurrentTime{
    //获取当前日期
    NSDate* date = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateStr = [dateFormat stringFromDate:date];
    NSLog(@"当前时间%@",dateStr);
    return dateStr;
}
// NSDate -> NSString
- (NSString *)dateToStringWith:(NSDate *)date{
    NSDate *locdate = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *str = [formatter stringFromDate:locdate];
    return str;
}

// NSString -> NSDate
- (NSDate *)stringToDateWith:(NSString *)string{
    NSString *timeString = string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:timeString];
    return date;
}

@end
