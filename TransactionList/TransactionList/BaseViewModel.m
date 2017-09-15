//
//  BaseViewModel.m
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel
@synthesize request = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    BaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel bs_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model{
    if (self=[super init]) {
        
    }
    return self;
}

- (CMRequest *)request{
    if (!_request) {
        _request = [CMRequest request];
    }
    return _request;
}

@end
