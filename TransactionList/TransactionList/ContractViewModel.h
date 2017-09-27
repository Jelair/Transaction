//
//  ContractViewModel.h
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractViewModel : NSObject

- (void)getAllContracts:(void(^)(id contractData))block;
- (void)deleteContractByContractId:(int)contractId completeBlock:(void(^)(BOOL isSuccess))block;
- (void)searchContractByTel:(NSString *)tel completeBlock:(void(^)(id contractData))block;

- (void)applyContractWith:(int)contractId completeBlock:(void(^)(BOOL isSuccess))block;

@end
