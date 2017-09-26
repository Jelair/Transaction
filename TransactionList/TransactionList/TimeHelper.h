//
//  TimeHelper.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject

+ (TimeHelper *)shareTimeHelper;

+ (NSString *)getCurrentTime;

+ (NSDate *)stringToDateWith:(NSString *)string;

@end
