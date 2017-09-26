//
//  TaskHistoryTableViewCell.h
//  TransactionList
//
//  Created by NowOrNever on 27/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskHistoryTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *taskContent;
@property (nonatomic,strong) UILabel *taskPlace;
@property (nonatomic,strong) UILabel *taskTime;
@property (nonatomic,strong) UIImageView *isShare;

- (void)updateDataWithDic:(NSDictionary *)dic;
@end
