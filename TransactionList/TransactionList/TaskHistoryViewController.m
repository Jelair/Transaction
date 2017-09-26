//
//  TaskHistoryViewController.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "TaskHistoryViewController.h"
#import "MainViewModel.h"
#import "TaskHistoryTableViewCell.h"

@interface TaskHistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MainViewModel *mvm;
@end

@implementation TaskHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"任务";
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.mvm getAllTaskData:^(id taskData) {
        self.dataSource = [taskData copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //MainDetailController *vc = [MainDetailController new];
    //[vc setInfoWithDic:self.dataSource[indexPath.row]];
    //[self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dell"];
    if (!cell) {
        cell = [[TaskHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"dell"];
        
    }
    [cell updateDataWithDic:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark -- getter

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 70;
    }
    return _tableView;
}

- (MainViewModel *)mvm{
    if (!_mvm) {
        _mvm = [MainViewModel new];
    }
    return _mvm;
}
@end

