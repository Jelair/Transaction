//
//  SigninViewController.m
//  TransactionList
//
//  Created by NowOrNever on 20/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "SigninViewController.h"
#import "User.h"
#import "DataBase+DBInterface.h"

@interface SigninViewController (){
    int _flag;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UIButton *genderBtn;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.user = [User new];
    [self.returnButton addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _genderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _genderBtn.frame = self.mTextField.frame;
    [_genderBtn setBackgroundColor:[UIColor lightGrayColor]];
    [_genderBtn setTitle:@"男" forState:UIControlStateNormal];
    [_genderBtn setTitle:@"女" forState:UIControlStateSelected];
    [_genderBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_genderBtn setHidden:YES];
    [self.view addSubview:_genderBtn];
    
}

- (void)genderBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)nextButtonClick{
    NSLog(@"flag = %d", _flag);
    
    NSString *textStr = self.mTextField.text;
    
    
    switch (_flag) {
        case 0:
            if (textStr.length > 0) {
                if ([self checkUserAccount:textStr]) {
                    self.user.userAccount = textStr;
                    _flag++;
                    self.mTextField.text = @"";
                    self.signInFailureText.text = @"请输入密码";
                }else{
                    self.signInFailureText.text = @"登录名重复，请重新输入";
                }
            }else{
                self.signInFailureText.text = @"登录名不能为空，请输入";
            }
            break;
        case 1:
            if (textStr.length > 3) {
                self.user.userPassword = textStr;
                _flag++;
                self.mTextField.text = @"";
                self.signInFailureText.text = @"请输入用户名";
            }else{
                self.signInFailureText.text = @"密码不少于3位，请重新输入";
            }
            break;
        case 2:
            if (textStr.length > 0) {
                self.user.userName = textStr;
                _flag++;
                self.mTextField.text = @"";
                self.signInFailureText.text = @"请输入年龄";
            }else{
                self.signInFailureText.text = @"用户名不能为空，请重新输入";
            }
            break;
        case 3:
            if (textStr.length > 0) {
                if([self deptNumInputShouldNumber:textStr]){
                    self.user.userAge = [textStr intValue];
                    _flag++;
                    [self.mTextField setHidden:YES];
                    //[self.mTextField removeFromSuperview];
                    [self.genderBtn setHidden:NO];
                    self.signInFailureText.text = @"请选择您的性别";
                    [self.nextButton setTitle:@"确定注册" forState:UIControlStateNormal];
                }else{
                    self.signInFailureText.text = @"年龄不合法，请重新输入";
                }
                
            }else{
                self.signInFailureText.text = @"年龄不能为空，请重新输入";
            }
            break;
        case 4:
            self.user.userGender = _genderBtn.selected ? 0 : 1;
            self.user.userTel = @"无";
            self.user.userIcon = @"null";
            
            if ([self registerUser:self.user]) {
                self.signInFailureText.text = @"注册成功";
                [self.genderBtn setHidden:YES];
                [self.tipText setHidden:YES];
                [self.nextButton setHidden:YES];
            }else{
                self.signInFailureText.text = @"注册失败";
            }
            
            break;
        default:
            break;
    }
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

- (BOOL)registerUser:(User *)user{
    User *u = user;
    return [[DataBase shareDataBase] addUser:u];
}

- (BOOL)checkUserAccount:(NSString *)string{
    if (string.length < 1) {
        return NO;
    }
    [[DataBase shareDataBase] lookUsers];
    NSString *str = string;
    NSArray *users = [[DataBase shareDataBase] findUser:str];
    return users.count==0;
}

- (void)returnButtonClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
