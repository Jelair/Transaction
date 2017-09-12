//
//  ZJLTabBarController.m
//  TransactionList
//
//  Created by NowOrNever on 12/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTabBarController.h"
#import "ZJLNavigationController.h"

#import "ZJLTabBar.h"

@interface ZJLTabBarController ()<ZJLTabBarDelegate>

@end

@implementation ZJLTabBarController

+ (void)initialize{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildVc];
    
    ZJLTabBar *tabbar = [[ZJLTabBar alloc] init];
    tabbar.mDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
}

- (void)setUpAllChildVc{
    UIViewController *task = [[UIViewController alloc] init];
    [self setUpOneChildVcWithVc:task image:@"task" selectImage:@"task_h" title:@"今日任务"];
    
    UIViewController *message = [[UIViewController alloc] init];
    [self setUpOneChildVcWithVc:message image:@"message" selectImage:@"message_h" title:@"消息"];
    
    UIViewController *contract = [[UIViewController alloc] init];
    [self setUpOneChildVcWithVc:contract image:@"contract" selectImage:@"contract_h" title:@"联系人"];
    
    UIViewController *setting = [[UIViewController alloc] init];
    [self setUpOneChildVcWithVc:setting image:@"setting" selectImage:@"setting_h" title:@"设置"];
}

- (void)setUpOneChildVcWithVc:(UIViewController *)vc image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title{
    ZJLNavigationController *nav = [[ZJLNavigationController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor lightGrayColor];
    UIImage *mImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = mImage;
    UIImage *mSelectImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = mSelectImage;
    vc.tabBarItem.title = title;
    vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark -- mDelegate
- (void)tabbarRecordButtonClick:(ZJLTabBar *)tabbar{
    NSLog(@"click!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
