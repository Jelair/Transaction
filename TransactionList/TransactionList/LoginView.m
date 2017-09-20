//
//  LoginView.m
//  TransactionList
//
//  Created by NowOrNever on 16/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(LoginView *)instanceLoginView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LoginViewxib" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
