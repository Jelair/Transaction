//
//  Message.h
//  TransactionList
//
//  Created by NowOrNever on 19/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (nonatomic, assign) int messageId;
@property (nonatomic, assign) int messageType;
@property (nonatomic, strong) NSString *messageContent;
@property (nonatomic, strong) NSString *messageSendTime;
@property (nonatomic, assign) int messageIsRead;
@property (nonatomic, assign) int messageSenderId;
@end
