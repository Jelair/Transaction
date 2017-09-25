//
//  RecordViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "RecordViewController.h"
#import "MyLabel.h"
#import "MyTextField.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setupFrame];
}

- (void)setupFrame{
    __weak typeof(self) weakSelf = self;
    
    UIView *navView = [UIView new];
    navView.backgroundColor = [UIColor redColor];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(@64);
        make.left.equalTo(weakSelf.view);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancelBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    //[cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(navView).with.offset(20);
        make.left.equalTo(navView);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"创建任务";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(cancelBtn);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn addTarget:self action:@selector(sureBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setImage:[UIImage imageNamed:@"sure"] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(navView).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(0);
    }];

    //任务内容
    UIImageView *taskContentIcon  = [UIImageView new];
    taskContentIcon.image = [UIImage imageNamed:@"taskContent"];
    [self.view addSubview:taskContentIcon];
    [taskContentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(cancelBtn.mas_bottom).with.offset(50);
    }];
    
    MyLabel *taskContentLabel = [MyLabel new];
    taskContentLabel.text = @"内容";
    [self.view addSubview:taskContentLabel];
    [taskContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskContentIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskContentIcon);
    }];
    
    MyTextField *taskContent = [MyTextField new];
    [self.view addSubview:taskContent];
    [taskContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskContentIcon);
        make.left.equalTo(taskContentLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskContentIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    //任务地点
    UIImageView *taskPlaceIcon = [UIImageView new];
    taskPlaceIcon.image = [UIImage imageNamed:@"taskPlace"];
    [self.view addSubview:taskPlaceIcon];
    [taskPlaceIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(taskContentIcon);
        make.top.equalTo(taskContentIcon.mas_bottom).with.offset(60);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskPlaceIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    MyLabel *taskPlaceLabel = [MyLabel new];
    taskPlaceLabel.text = @"地点";
    [self.view addSubview:taskPlaceLabel];
    [taskPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskPlaceIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskPlaceIcon);
    }];
    
    MyTextField *placeF = [MyTextField new];
    //placeF.placeholder = @"请输入地点";
    [self.view addSubview:placeF];
    [placeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskPlaceIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskPlaceLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    //任务时间
    UIImageView *taskTimeIcon = [UIImageView new];
    taskTimeIcon.image = [UIImage imageNamed:@"startTime"];
    [self.view addSubview:taskTimeIcon];
    [taskTimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(taskContentIcon);
        make.top.equalTo(taskPlaceIcon.mas_bottom).with.offset(60);
    }];
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(5);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    MyLabel *taskTimeLabel = [MyLabel new];
    taskTimeLabel.text = @"时间";
    [self.view addSubview:taskTimeLabel];
    [taskTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskTimeIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskTimeIcon);
    }];
    
    MyTextField *timeF = [MyTextField new];
    //timeF.placeholder = @"请输入时间";
    [self.view addSubview:timeF];
    [timeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskTimeIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskTimeLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    //任务执行者
//    UIImageView *taskOperatorIcon = [UIImageView new];
//    taskOperatorIcon.image = [UIImage imageNamed:@"operator"];
//    [self.view addSubview:taskOperatorIcon];
//    [taskOperatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//        make.centerX.equalTo(taskContentIcon);
//        make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(60);
//    }];
//    
//    UIView *lineView3 = [UIView new];
//    lineView3.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:lineView3];
//    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(taskOperatorIcon.mas_bottom).with.offset(5);
//        make.left.equalTo(weakSelf.view).with.offset(10);
//        make.right.equalTo(weakSelf.view).with.offset(-10);
//        make.height.mas_equalTo(@1);
//    }];
//    
//    MyLabel *taskOperatorLabel = [MyLabel new];
//    taskOperatorLabel.text = @"共享者";
//    [self.view addSubview:taskOperatorLabel];
//    [taskOperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 30));
//        make.left.equalTo(taskOperatorIcon.mas_right).with.offset(5);
//        make.centerY.equalTo(taskOperatorIcon);
//    }];
//
//    MyTextField *operatorF = [MyTextField new];
//    //operatorF.placeholder = @"请输入共享着";
//    [self.view addSubview:operatorF];
//    [operatorF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(taskOperatorIcon);
//        make.height.mas_equalTo(@30);
//        make.left.equalTo(taskOperatorLabel.mas_right).with.offset(5);
//        make.right.equalTo(weakSelf.view).with.offset(-10);
//    }];
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recordBtn.layer.cornerRadius = 30;
    [recordBtn setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [recordBtn setImage:[UIImage imageNamed:@"recording"] forState:UIControlStateSelected];
    [recordBtn addTarget:self action:@selector(recordBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(60);
    }];
    
    UILabel *tipLabel  = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.text = @"请录音";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(recordBtn);
        make.top.equalTo(recordBtn.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
}

- (void)recordBtn_click:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)cancelBtn_click{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)sureBtn_click{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
