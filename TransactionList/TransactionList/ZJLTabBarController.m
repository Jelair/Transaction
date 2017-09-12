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

@interface ZJLTabBarController ()

@end

@implementation ZJLTabBarController

+ (void)initialize{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildVc];
}

- (void)setUpAllChildVc{
    UIViewController *vc = [[UIViewController alloc] init];
    [self setUpOneChildVcWithVc:vc image:@"" selectImage:@"" title:@""];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
