//
//  MyTextField.m
//  TransactionList
//
//  Created by NowOrNever on 25/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    if (self=[super init]) {
        self.textColor = [UIColor darkGrayColor];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
