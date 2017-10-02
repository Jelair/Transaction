//
//  MessageDetailViewController.m
//  TransactionList
//
//  Created by NowOrNever on 27/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageViewModel.h"
#import "MyLabel.h"

@interface MessageDetailViewController ()
@property (nonatomic,strong) NSDictionary *mDic;
@property (nonatomic,strong) MessageViewModel *mvm;
@property (nonatomic,strong) MyLabel *msgContent;
@property (nonatomic,strong) MyLabel *msgTime;
@property (nonatomic,strong) MyLabel *msgSender;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    int contactId = [self.mDic[@"messageSenderId"] intValue];
    _msgContent.text = [NSString stringWithFormat:@"信息内容：%@",self.mDic[@"messageContent"]];
    _msgTime.text = [NSString stringWithFormat:@"发送时间：%@",self.mDic[@"messageSendTime"]];
    __weak typeof(self) weakSelf = self;
    [self.mvm getUserNameByUserId:contactId completeBlock:^(id data) {
        NSArray *arr = data;
        if (arr.count > 0) {
            weakSelf.msgSender.text = [NSString stringWithFormat:@"信息发送者：%@",arr[0][@"userName"]];
        }
    }];
}

- (void)setUpFrame{
    __weak typeof(self) weakSelf = self;
    MyLabel *msgContent = [MyLabel new];
    msgContent.text = @"信息内容：";
    [self.view addSubview:msgContent];
    [msgContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(84);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.height.mas_offset(@30);
    }];
    _msgContent = msgContent;
    
    MyLabel *msgTime = [MyLabel new];
    msgTime.text = @"发送时间:";
    [self.view addSubview:msgTime];
    [msgTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(msgContent.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.height.mas_offset(@30);
    }];
    _msgTime = msgTime;
    
    MyLabel *msgSender = [MyLabel new];
    msgSender.text = @"发送者：";
    [self.view addSubview:msgSender];
    [msgSender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(msgTime.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(-20);
        make.height.mas_offset(@30);
    }];
    _msgSender = msgSender;
}

- (void)setInfoWithDic:(NSDictionary *)dic{
    self.mDic = [dic copy];
    
}

- (MessageViewModel *)mvm{
    if (!_mvm) {
        _mvm = [MessageViewModel new];
    }
    return _mvm;
}

@end
