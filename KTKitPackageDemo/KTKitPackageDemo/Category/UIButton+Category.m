//
//  UIButton+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/15.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIView+Category.h"
#import <objc/runtime.h>

@interface UIButton ()
@property (nonatomic, copy) ActionHandler actionHander;
@end

static const void *ktButtonActionKey = &ktButtonActionKey;
@implementation UIButton (Category)

- (void)addAction:(ActionHandler)actionHander {
    [self addTarget:self action:@selector(executeAction) forControlEvents:UIControlEventTouchUpInside];
    self.actionHander = actionHander;
}

- (void)addAction:(ActionHandler)actionHander forControlEvents:(UIControlEvents)controlEvents {
    [self addTarget:self action:@selector(executeAction) forControlEvents:controlEvents];
    self.actionHander = actionHander;
}

- (void)executeAction {
    //点击button 取消super VC子视图的 FirstResponse
    [self resignFirstResponseInViewController];
    if (self.actionHander) {
        self.actionHander(self);
    }
}

- (ActionHandler)actionHander {
    return objc_getAssociatedObject(self, ktButtonActionKey);
}

-(void)setActionHander:(ActionHandler)actionHander {
    objc_setAssociatedObject(self, ktButtonActionKey, actionHander, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
