//
//  BaseView.m
//  TransactionList
//
//  Created by NowOrNever on 14/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init{
    if (self = [super init]) {
        [self bs_setupViews];
        [self bs_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    if (self = [super init]) {
        [self bs_setupViews];
        [self bs_bindViewModel];
    }
    return self;
}

- (void)bs_setupViews{
    
}

- (void)bs_bindViewModel{
    
}

- (void)bs_addReturnKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
}

@end
