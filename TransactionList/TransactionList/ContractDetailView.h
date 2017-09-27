//
//  ContractDetailView.h
//  TransactionList
//
//  Created by NowOrNever on 27/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContractViewDelegate <NSObject>

@optional

- (void)didClickAddButton;

@end

@interface ContractDetailView : UIView
@property (nonatomic,weak) id<ContractViewDelegate> delegate;

@property (nonatomic,strong) UILabel *tel;
@property (nonatomic,strong) UILabel *genderLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *chBtn;

- (void)setInfoWithDic:(NSDictionary *)dic;

@end
