//
//  MessageViewController.m
//  TransactionList
//
//  Created by NowOrNever on 24/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewModel.h"

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

#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dell"];
    }
    cell.textLabel.text = @"test";
    cell.imageView.image = [UIImage imageNamed:@"msg"];
    return cell;
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
    }
    return _tableView;
}

@end
