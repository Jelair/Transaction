//
//  SigninViewController.h
//  TransactionList
//
//  Created by NowOrNever on 20/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigninViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;
@property (weak, nonatomic) IBOutlet UILabel *tipText;
@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@end
