//
//  BaseViewProtocol.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BaseViewModelProtocol;
@protocol BaseViewProtocol <NSObject>
@optional
- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;

- (void)bs_bindViewModel;
- (void)bs_setupViews;
- (void)bs_addReturnKeyBoard;

@end
