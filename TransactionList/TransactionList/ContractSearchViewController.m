//
//  ContractSearchViewController.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ContractSearchViewController.h"
#import "MyTextField.h"
#import "ContractDetailView.h"
#import "ContractViewModel.h"

@interface ContractSearchViewController ()<ContractViewDelegate>
@property (nonatomic,strong) ContractDetailView *contractView;
@property (nonatomic,strong) MyTextField *mTextField;
@property (nonatomic,strong) ContractViewModel *cvm;
@property (nonatomic,assign) int contractId;
@end

@implementation ContractSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加联系人";
    [self setUpFrame];
}

- (void)didClickAddButton{
    AlertHelper *alert = [AlertHelper shareHelper];
    
    [self.cvm applyContractWith:self.contractId completeBlock:^(BOOL isSuccess) {
        if(isSuccess){
            [alert alertWithTitle:@"好友申请成功" message:@"待对方同意后即可成为好友" viewController:self];
            [alert setDefaultBtnWithTitle:@"OK" handlerBlock:nil];
            [alert show];
        }
    }];
    
    
}

- (void)searchBtnClick{
    AlertHelper *alert = [AlertHelper shareHelper];
    NSString *telString = self.mTextField.text;
    __weak typeof(self) weakSelf = self;
    if (telString.length < 11 || telString.length > 14) {
        [alert alertWithTitle:@"警告！搜索信息不合法" message:@"电话号码位数：11-14" viewController:self];
        [alert setDefaultBtnWithTitle:@"确定" handlerBlock:nil];
        [alert show];
    }else{
        [weakSelf.cvm searchContractByTel:telString completeBlock:^(id contractData) {
            NSArray *array = contractData;
            if (array.count < 1) {
                [alert alertWithTitle:@"没有找到此人信息" message:nil viewController:weakSelf];
                [alert setDefaultBtnWithTitle:@"确定" handlerBlock:nil];
                [alert show];
            }else{
                weakSelf.contractId = [array[0][@"userId"] intValue];
                [weakSelf.contractView setInfoWithDic:array[0]];
            }
        }];
    }
}

- (void)setUpFrame{
    __weak typeof(self) weakSelf = self;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(80);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    MyTextField *textField = [MyTextField new];
    textField.placeholder = @"请输入电话号码";
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.layer.cornerRadius = 5;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(80);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(searchBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(@30);
    }];
    self.mTextField = textField;
    
    ContractDetailView *cdv = [ContractDetailView new];
    cdv.delegate = self;
    [self.view addSubview:cdv];
    [cdv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textField.mas_bottom).with.offset(20);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.bottom.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.contractView = cdv;
}

- (ContractViewModel *)cvm{
    if (!_cvm) {
        _cvm = [ContractViewModel new];
    }
    return _cvm;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
