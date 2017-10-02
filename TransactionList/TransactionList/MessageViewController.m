//
//  MessageViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewModel.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MessageViewModel *mvm;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    [self.mvm getAllMessageWithBlock:^(id messageData) {
        weakSelf.dataSource = messageData;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dell"];
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"messageContent"];
    cell.imageView.image = [UIImage imageNamed:@"msg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailViewController *vc = [MessageDetailViewController new];
    [vc setInfoWithDic:self.dataSource[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- getter

- (MessageViewModel *)mvm{
    if (!_mvm) {
        _mvm = [MessageViewModel new];
    }
    return _mvm;
}

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
    }
    return _tableView;
}

@end
