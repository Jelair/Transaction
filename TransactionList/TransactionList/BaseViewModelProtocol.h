//
//  BaseViewModelProtocol.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI
} LSRefreshDataStatus;

@protocol BaseViewModelProtocol <NSObject>

@optional
- (instancetype)initWithModel:(id)model;
@property (strong, nonatomic)CMRequest *request;

- (void)bs_initialize;

@end
