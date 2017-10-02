//
//  MainDetailController.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MainDetailController.h"
#import "MyLabel.h"
#import "MyTextField.h"
#import "MainViewModel.h"

@interface MainDetailController ()
@property (nonatomic,strong) MyLabel *taskContent;
@property (nonatomic,strong) MyLabel *taskPlace;
@property (nonatomic,strong) MyLabel *taskTime;
@property (nonatomic,strong) MainViewModel *mvm;
@property (nonatomic,copy) NSDictionary *mDic;
@end

@implementation MainDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"任务";
    [self setUpFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateViewController];
}

- (void)updateViewController{
    self.taskContent.text = _mDic[@"taskContent"];
    self.taskTime.text = _mDic[@"taskStartTime"];
    self.taskPlace.text = _mDic[@"taskPlace"];
}

- (MainViewModel *)mvm{
    if (!_mvm) {
        _mvm = [MainViewModel new];
    }
    return _mvm;
}

- (void)setInfoWithDic:(NSDictionary *)dic{
    _mDic = dic;
}

- (void)setUpFrame{
    __weak typeof(self) weakSelf = self;
    
    //任务内容
    UIImageView *taskContentIcon  = [UIImageView new];
    taskContentIcon.image = [UIImage imageNamed:@"taskContent"];
    [self.view addSubview:taskContentIcon];
    [taskContentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(weakSelf.view).with.offset(100);
    }];
    
    MyLabel *taskContentLabel = [MyLabel new];
    taskContentLabel.text = @"内容";
    [self.view addSubview:taskContentLabel];
    [taskContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.left.equalTo(taskContentIcon.mas_right).with.offset(5);
        make.centerY.equalTo(taskContentIcon);
    }];
    
    MyLabel *taskContent = [MyLabel new];
    [self.view addSubview:taskContent];
    [taskContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskContentIcon);
        make.left.equalTo(taskContentLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    self.taskContent = taskContent;
    
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
        make.top.equalTo(taskContentIcon.mas_bottom).with.offset(30);
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
    
    MyLabel *placeF = [MyLabel new];
    //placeF.placeholder = @"请输入地点";
    [self.view addSubview:placeF];
    [placeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskPlaceIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskPlaceLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.taskPlace = placeF;
    
    //任务时间
    UIImageView *taskTimeIcon = [UIImageView new];
    taskTimeIcon.image = [UIImage imageNamed:@"startTime"];
    [self.view addSubview:taskTimeIcon];
    [taskTimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerX.equalTo(taskContentIcon);
        make.top.equalTo(taskPlaceIcon.mas_bottom).with.offset(30);
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
    
    MyLabel *timeF = [MyLabel new];
    //timeF.placeholder = @"请输入时间";
    [self.view addSubview:timeF];
    [timeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(taskTimeIcon);
        make.height.mas_equalTo(@30);
        make.left.equalTo(taskTimeLabel.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.taskTime = timeF;
    
    //任务执行者
        UIImageView *taskOperatorIcon = [UIImageView new];
        taskOperatorIcon.image = [UIImage imageNamed:@"operator"];
        [self.view addSubview:taskOperatorIcon];
        [taskOperatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerX.equalTo(taskContentIcon);
            make.top.equalTo(taskTimeIcon.mas_bottom).with.offset(30);
        }];
    
        UIView *lineView3 = [UIView new];
        lineView3.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lineView3];
        [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taskOperatorIcon.mas_bottom).with.offset(5);
            make.left.equalTo(weakSelf.view).with.offset(10);
            make.right.equalTo(weakSelf.view).with.offset(-10);
            make.height.mas_equalTo(@1);
        }];
    
        MyLabel *taskOperatorLabel = [MyLabel new];
        taskOperatorLabel.text = @"共享者";
        [self.view addSubview:taskOperatorLabel];
        [taskOperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.left.equalTo(taskOperatorIcon.mas_right).with.offset(5);
            make.centerY.equalTo(taskOperatorIcon);
        }];
    
        MyLabel *operatorF = [MyLabel new];
        //operatorF.placeholder = @"请输入共享着";
        [self.view addSubview:operatorF];
        [operatorF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(taskOperatorIcon);
            make.height.mas_equalTo(@30);
            make.left.equalTo(taskOperatorLabel.mas_right).with.offset(5);
            make.right.equalTo(weakSelf.view).with.offset(-10);
        }];
    
    UIButton *addShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addShareBtn setTitle:@"添加任务共享者" forState:UIControlStateNormal];
    [addShareBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addShareBtn setBackgroundColor:[UIColor clearColor]];
    addShareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addShareBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    addShareBtn.layer.borderWidth = 1;
    addShareBtn.layer.cornerRadius = 5;
    [self.view addSubview:addShareBtn];
    [addShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *deleteShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteShareBtn setTitle:@"删除任务共享者" forState:UIControlStateNormal];
    [deleteShareBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [deleteShareBtn setBackgroundColor:[UIColor clearColor]];
    deleteShareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    deleteShareBtn.layer.borderWidth = 1;
    deleteShareBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    deleteShareBtn.layer.cornerRadius = 5;
    [self.view addSubview:deleteShareBtn];
    [deleteShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addShareBtn.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *taskFinish = [UIButton buttonWithType:UIButtonTypeCustom];
    [taskFinish setBackgroundImage:[UIImage imageNamed:@"finishTask"] forState:UIControlStateNormal];
    [taskFinish addTarget:self action:@selector(finishTask) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:taskFinish];
    [taskFinish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deleteShareBtn.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(weakSelf.view);
    }];
}

- (void)finishTask{
    AlertHelper *alert = [AlertHelper shareHelper];
    [alert alertWithTitle:@"提醒" message:@"确定完成了吗？" viewController:self];
    [alert setDefaultBtnWithTitle:@"完成了" handlerBlock:^{
        [self.mvm finishTaskWithTask:[_mDic[@"taskId"] intValue] complete:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
    [alert setCancelBtnWithTitle:@"还没有" handlerBlock:^{
        
    }];
    [alert show];
}

@end
