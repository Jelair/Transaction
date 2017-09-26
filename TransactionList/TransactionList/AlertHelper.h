//
//  AlertHelper.h
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertHelper : NSObject

+ (AlertHelper *)shareHelper;
- (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc;
- (void)setCancelBtnWithTitle:(NSString *)title handlerBlock:(void(^)())block;
- (void)setDefaultBtnWithTitle:(NSString *)title handlerBlock:(void(^)())dblcok;
- (void)show;

@end
