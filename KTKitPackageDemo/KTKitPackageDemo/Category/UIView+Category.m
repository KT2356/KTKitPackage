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

static const void *clickBlockKey = &clickBlockKey;

#pragma mark - width
- (float)width {
    return self.bounds.size.width;
}
- (void)setWidth:(float)width {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeWidth) {
                constrain.constant = width;
        }
    }
}

#pragma mark - height
- (float)height {
    return self.bounds.size.height;
}
- (void)setHeight:(float)height {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeHeight) {
            constrain.constant = height;
        }
    }
}

#pragma mark - xPosition
- (float)xPosition {
    return self.frame.origin.x;
}
- (void)setXPosition:(float)xPosition {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeLeft) {
            constrain.constant = xPosition;
        }
    }
}

#pragma mark - yPosition
- (float)yPosition {
    return self.frame.origin.y;
}
- (void)setYPosition:(float)yPosition {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeTop) {
            constrain.constant = yPosition;
        }
    }
}

#pragma mark - origin
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    [self setXPosition:origin.x];
    [self setYPosition:origin.y];
}
#pragma mark - size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    [self setWidth:size.width];
    [self setHeight:size.height];
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
