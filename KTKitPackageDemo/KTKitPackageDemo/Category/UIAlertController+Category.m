//
//  UIAlertController+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)

- (instancetype)initActionSheetWithTitle:(NSString *)title
                        ActionTitleArray:(NSArray *)actionTitleArray
                           CancelHandler:(void(^)())cancelHandler
                           ActionHandler:(void(^)(int index))actionHander
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                    cancelHandler();
                                                             }
                                   ];
    [alertVC addAction:cancelAction];
    if (actionTitleArray && actionTitleArray.count > 1) {
        for (int i = 0; i < actionTitleArray.count; i++) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionTitleArray[i]
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                                                                    actionHander(i);
                                                                }
                                          ];
            [alertVC addAction:alertAction];
        }
    }
    return alertVC;
}

- (instancetype)initSingleAlertWithTitle:(NSString *)title
                             withMessage:(NSString *)message
                           actionHandler:(void (^)())handler
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            handler();
    }];
    [alertVC addAction:cancelAction];

    return alertVC;
}

- (instancetype)initSingleAlertWithTitle:(NSString *)title
                           actionHandler:(void (^)())handler
{
    return [self initSingleAlertWithTitle:title
                              withMessage:nil
                            actionHandler:handler];
}

- (instancetype)initAlertWithTitle:(NSString *)title
                       withMessage:(NSString *)message
                     cancelHandler:(void (^)())cancelHandler
                         OKHandler:(void (^)())okHandler
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancelHandler();
    }];
        
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            okHandler();
    }];
        
    [alertVC addAction:cancelAction];
    [alertVC addAction:okAction];
    return alertVC;
}

- (instancetype)initAlertWithTitle:(NSString *)title
                     cancelHandler:(void (^)())cancelHandler
                         OKHandler:(void (^)())okHandler
{
   return  [self initAlertWithTitle:title
                 withMessage:nil
               cancelHandler:cancelHandler
                   OKHandler:okHandler];
}


@end
