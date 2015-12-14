//
//  UIView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic, copy) ClickBlock clickBlock;
@end;

@implementation UIView (Category)

@dynamic height;
@dynamic xPosition;
@dynamic yPosition;

static const void *clickBlockKey = &clickBlockKey;

#pragma mark - position
- (float)width {
    return self.bounds.size.width;
}
- (void)setWidth:(float)width {
    if (self.autoresizesSubviews) {
        for (NSLayoutConstraint *constrain in self.superview.constraints) {
            if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeWidth) {
                constrain.constant = width;
            }
        }
        [self layoutIfNeeded];
    } else {
        CGRect rect = self.frame;
        rect.size.width = width;
        self.frame = rect;
    }
}

- (float)height {
    return self.bounds.size.height;
}
- (void)setHeight:(float)height {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeHeight) {
            constrain.constant = height;
        }
    }
    [self layoutIfNeeded];
}
- (float)xPosition {
    return self.frame.origin.x;
}
- (float)yPosition {
    return self.frame.origin.y;
}


#pragma mark - public methods
- (void)clickAction:(ClickBlock)clickBlock {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClick)];
    [self addGestureRecognizer:tapped];
    self.clickBlock = clickBlock;
}

#pragma mark - private methods
- (void)viewDidClick {
    self.clickBlock(self);
}


#pragma mark - setter/getter
- (ClickBlock)clickBlock {
    return objc_getAssociatedObject(self, clickBlockKey);
}

- (void)setClickBlock:(ClickBlock)clickBlock{
    objc_setAssociatedObject(self, clickBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
