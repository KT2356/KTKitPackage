//
//  UISwitch+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UISwitch+Category.h"
#import <objc/runtime.h>

@interface UISwitch ()
@property (nonatomic, copy) SwitchBlock switchBlock;
@end

@implementation UISwitch (Category)
static const void *ktSwitchKey = &ktSwitchKey;

#pragma mark - public methods
- (void)actionHandler:(SwitchBlock)actionHandler {
    [self addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
    self.switchBlock = actionHandler;
}

#pragma mark - private action
- (void)switchAction:(UISwitch *)switchBtn {
    if (self.switchBlock) {
        self.switchBlock(switchBtn.isOn);
    }
}

#pragma mark - setter/getter
- (SwitchBlock)switchBlock {
    return objc_getAssociatedObject(self, ktSwitchKey);
}

- (void)setSwitchBlock:(SwitchBlock)switchBlock {
    objc_setAssociatedObject(self, ktSwitchKey, switchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
