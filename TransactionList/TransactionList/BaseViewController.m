//
//  BaseViewController.m
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;
@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    BaseViewController *viewController = [super allocWithZone:zone];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - system
- (UIStatusBarStyle)preferredStatusBarStyle{
    if (self.statusBarStyle) {
        return self.statusBarStyle;
    }else{
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden{
    return self.statusBarHidden;
}

- (void)dealloc{
    NSLog(@"Running:%@ '%@'",self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private
- (void)bs_removeNavgationBarLine{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list = self.navigationController.navigationBar.subviews;
        for(id obj in list){
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView*)obj;
                NSArray *list2 = imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2 = (UIImageView*)obj2;
                        imageView2.hidden = YES;
                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout{
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting{
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusBarHidden:(BOOL)statusBarHidden changeStatusBarAnimated:(BOOL)animated{
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden = isHide;
        }];
    }else{
        self.navigationController.navigationBarHidden = isHide;
    }
}

- (void)layoutNavigationBar:(UIImage *)backGroundImage titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont leftBarButtonItem:(UIBarButtonItem *)leftItem rightBarButtonItem:(UIBarButtonItem *)rightItem{
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont,NSForegroundColorAttributeName:titleColor}];
    }else if(titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }else if (titleFont){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    
    if (leftItem) {
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

#pragma mark - RAC
- (void)bs_addSubviews{}
- (void)bs_bindViewModel{}
- (void)bs_layoutNavigation{}
- (void)bs_getNewData{}

@end
