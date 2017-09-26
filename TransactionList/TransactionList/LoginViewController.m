//
//  LoginViewController.m
//  TransactionList
//
//  Created by NowOrNever on 14/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginView.h"
#import "SigninViewController.h"
#import "ZJLTabBarController.h"

@interface LoginViewController ()
@property (weak, nonatomic)  UITextField *usernameTextField;
@property (weak, nonatomic)  UITextField *passwordTextField;
@property (weak, nonatomic)  UIButton *signInButton;
@property (weak, nonatomic)  UILabel *signInFailureText;
@property (weak, nonatomic)  UIButton *signUpButton;

@property (nonatomic) BOOL passwordIsValid;
@property (nonatomic) BOOL usernameIsValid;
@property (strong, nonatomic) LoginViewModel *signInService;
@property (strong, nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.signInService = [LoginViewModel new];
    [self initUI];
    
    // handle text changes for both text fields
    [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.signInButton addTarget:self action:@selector(signInButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton addTarget:self action:@selector(signUpButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    // initially hide the failure message
    self.signInFailureText.hidden = YES;
    [self updateUIState];
}

- (void)initUI{
    _loginView = [LoginView instanceLoginView];
    [self.view addSubview:_loginView];
    self.usernameTextField = _loginView.usernameTextField;
    self.passwordTextField = _loginView.passwordTextField;
    self.signInButton = _loginView.signInButton;
    self.signInFailureText = _loginView.signInFailureText;
    self.signUpButton = _loginView.signUpButton;
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

- (void)signUpButtonTouched:(id)sender{
    SigninViewController *vc = [SigninViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)signInButtonTouched:(id)sender {
    // disable all UI controls
    self.signInButton.enabled = NO;
    self.signInFailureText.hidden = YES;
    NSLog(@"click,%@", self.signInService);
    // sign in
    [self.signInService signInWithUsername:self.usernameTextField.text
                                  password:self.passwordTextField.text
                                  complete:^(BOOL success) {
                                      self.signInButton.enabled = YES;
                                      self.signInFailureText.hidden = success;
                                      if (success) {
                                          ZJLTabBarController *vc = [ZJLTabBarController new];
                                          [self presentViewController:vc animated:YES completion:nil];
                                      }
                                  }];
}


// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
- (void)updateUIState {
    self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (void)usernameTextFieldChanged {
    self.usernameIsValid = [self isValidUsername:self.usernameTextField.text];
    [self updateUIState];
}

- (void)passwordTextFieldChanged {
    self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
    [self updateUIState];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
