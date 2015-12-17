//
//  UIButton+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/15.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionHandler)(UIButton *sender);

@interface UIButton (Category)

- (void)actionHandler:(ActionHandler)actionHander;

- (void)actionHandler:(ActionHandler)actionHander forControlEvents:(UIControlEvents)controlEvents;

@end
