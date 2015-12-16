//
//  UIAlertController+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Category)

- (instancetype)initActionSheetWithTitle:(NSString *)title
                        ActionTitleArray:(NSArray *)actionTitleArray
                           CancelHandler:(void(^)())cancelHandler
                           ActionHandler:(void(^)(int index))actionHander;

- (instancetype)initSingleAlertWithTitle:(NSString *)title
                             withMessage:(NSString *)message
                           actionHandler:(void (^)())handler;

- (instancetype)initAlertWithTitle:(NSString *)title
                       withMessage:(NSString *)message
                     cancelHandler:(void (^)())cancelHandler
                         OKHandler:(void (^)())okHandler;
@end
