//
//  AlertHelper.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "AlertHelper.h"

@interface AlertHelper ()
@property(nonatomic,strong) UIAlertController *alert;
@property (nonatomic,weak) UIViewController *mdelegate;
@end

@implementation AlertHelper

+ (AlertHelper *)shareHelper{
    static AlertHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [AlertHelper new];
    });
    return helper;
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(UIViewController *)vc{
     _alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    _mdelegate = vc;
}

- (void)setCancelBtnWithTitle:(NSString *)title handlerBlock:(void(^)())block{
    if (!_alert) {
        return;
    }
    [_alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }]];
}

- (void)setDefaultBtnWithTitle:(NSString *)title handlerBlock:(void(^)())dblcok{
    if (!_alert) {
        return;
    }
    [_alert addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (dblcok) {
            dblcok();
        }
    }]];
}

- (void)addTextFieldWithBlock:(void(^)(NSString* textString))handlerBlock{
    [_alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        if (handlerBlock) {
            handlerBlock(textField.text);
        }
    }];
}

- (void)show{
    if (_mdelegate) {
        [_mdelegate presentViewController:_alert animated:YES completion:nil];
    }
}

@end
