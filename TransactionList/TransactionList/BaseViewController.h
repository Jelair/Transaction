//
//  BaseViewController.h
//  TransactionList
//
//  Created by NowOrNever on 15/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControllerProtocol.h"

@interface BaseViewController : UIViewController<BaseViewControllerProtocol>

@property (assign,nonatomic) BOOL isExtendLayout;

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated;

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated;

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem;

@end
