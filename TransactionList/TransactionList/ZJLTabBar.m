//
//  ZJLTabBar.m
//  TransactionList
//
//  Created by NowOrNever on 12/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTabBar.h"

@interface ZJLTabBar ()
@property (nonatomic, weak) UIButton *recordBtn;
@end

@implementation ZJLTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *recordBtn = [[UIButton alloc] init];
        [recordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [recordBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [recordBtn addTarget:self action:@selector(recordBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        self.recordBtn = recordBtn;
        [self addSubview:recordBtn];
    }
    return self;
}

- (void)recordBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(tabbarRecordButtonClick:)]) {
        [self.mDelegate tabbarRecordButtonClick:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            
        }
    }
}

@end
