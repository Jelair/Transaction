//
//  TaskHistoryTableViewCell.m
//  TransactionList
//
//  Created by NowOrNever on 27/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "TaskHistoryTableViewCell.h"

@implementation TaskHistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupFrame];
    }
    return self;
}

- (void)updateDataWithDic:(NSDictionary *)dic{
    if (dic) {
        self.taskContent.text = dic[@"taskContent"];
        self.taskPlace.text = dic[@"taskPlace"];
        self.taskTime.text = dic[@"taskStartTime"];
        if ([dic[@"taskIsFinish"] intValue] == 1) {
            self.isShare.image = [UIImage imageNamed:@"done"];
        }else{
            NSTimeInterval times = [[TimeHelper stringToDateWith:dic[@"taskStartTime"]] timeIntervalSinceNow];
            if (times < 0) {
                self.isShare.image = [UIImage imageNamed:@"undo"];
            }else{
                self.isShare.image = [UIImage imageNamed:@""];
            }
        }
    }
}

- (void)setupFrame{
    [self.contentView addSubview:self.taskContent];
    [self.contentView addSubview:self.taskPlace];
    [self.contentView addSubview:self.taskTime];
    [self.contentView addSubview:self.isShare];
    
    __weak typeof(self) weakSelf = self;
    [self.taskContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(10);
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.right.equalTo(weakSelf.contentView).with.offset(-40);
        make.height.mas_equalTo(@20);
    }];
    
    [self.isShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(weakSelf.contentView).with.offset(0);
    }];
    
    [self.taskPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.top.equalTo(self.taskContent.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self.taskTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.taskPlace);
        make.height.mas_equalTo(@20);
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
        make.left.equalTo(self.taskPlace.mas_right).with.offset(10);
    }];
}

- (UIImageView *)isShare{
    if (!_isShare) {
        _isShare = [UIImageView new];
        _isShare.image = [UIImage imageNamed:@"todo"];
    }
    return _isShare;
}

- (UILabel *)taskTime{
    if (!_taskTime) {
        _taskTime = [UILabel new];
        _taskTime.textColor = [UIColor redColor];
        _taskTime.font = [UIFont systemFontOfSize:12];
        _taskTime.textAlignment = NSTextAlignmentRight;
    }
    return _taskTime;
}

- (UILabel *)taskPlace{
    if (!_taskPlace) {
        _taskPlace = [UILabel new];
        _taskPlace.textColor = [UIColor redColor];
        _taskPlace.font = [UIFont systemFontOfSize:12];
    }
    return _taskPlace;
}

- (UILabel *)taskContent{
    if (!_taskContent) {
        _taskContent = [UILabel new];
        _taskContent.textColor = [UIColor darkGrayColor];
        _taskContent.font = [UIFont systemFontOfSize:16];
    }
    return _taskContent;
}
@end
