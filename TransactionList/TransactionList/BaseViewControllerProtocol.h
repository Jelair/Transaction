//
//  BaseViewControllerProtocol.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BaseViewModelProtocol;
@protocol BaseViewControllerProtocol <NSObject>
@optional
- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;

- (void)bs_bindViewModel;
- (void)bs_addSubviews;
- (void)bs_layoutNavigation;
- (void)bs_recoverKeyboard;
@end
