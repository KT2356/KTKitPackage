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

- (void)addAction:(ActionHandler)actionHander;

- (void)addAction:(ActionHandler)actionHander forControlEvents:(UIControlEvents)controlEvents;

@end
