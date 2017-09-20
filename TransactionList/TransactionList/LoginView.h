//
//  LoginView.h
//  TransactionList
//
//  Created by NowOrNever on 16/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

+(LoginView *)instanceLoginView;
@end
