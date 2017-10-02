//
//  MessageViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageViewModel : NSObject

- (void)getAllMessageWithBlock:(void(^)(id messageData))block;

- (void)getUserNameByUserId:(int)userId completeBlock:(void(^)(id data))block;

@end
