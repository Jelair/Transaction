//
//  ContractViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ContractViewController.h"
#import "ContractSearchViewController.h"
#import "ContractDetailViewController.h"
#import "ContractViewModel.h"

@interface ContractViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) ContractViewModel *cvm;
@end

@implementation ContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushViewController)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    [self.cvm getAllContracts:^(id contractData) {
        weakSelf.dataSource = [contractData mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)pushViewController{
    ContractSearchViewController *vc = [ContractSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"dell"];
    }
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"userName"];
    cell.imageView.image = [UIImage imageNamed:@"person"];
    cell.detailTextLabel.text = dic[@"userTel"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractDetailViewController *vc = [ContractDetailViewController new];
    [vc setInfoWithDic:self.dataSource[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- getter

- (ContractViewModel *)cvm{
    if (!_cvm) {
        _cvm = [ContractViewModel new];
    }
    return _cvm;
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
