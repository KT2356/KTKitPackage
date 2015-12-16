//
//  UIView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

@interface UIView ()<UIGestureRecognizerDelegate>
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
                [self setNeedsLayout];
                [self layoutIfNeeded];
        }
    }
}

- (void)setWidth:(float)width withDuration:(NSTimeInterval)lastTime {
    [UIView animateWithDuration:lastTime animations:^{
        [self setWidth:width];
    }];
}

#pragma mark - height
- (float)height {
    return self.bounds.size.height;
}

- (void)setHeight:(float)height {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeHeight) {
            constrain.constant = height;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
    }
}

- (void)setHeight:(float)height withDuration:(NSTimeInterval)lastTime {
    [UIView animateWithDuration:lastTime animations:^{
        [self setHeight:height];
    }];
}

#pragma mark - xPosition
- (float)xPosition {
    return self.frame.origin.x;
}

- (void)setXPosition:(float)xPosition {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeLeft) {
            constrain.constant = xPosition;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
    }
}

- (void)setXPosition:(float)xPosition withDuration:(NSTimeInterval)lastTime {
    [UIView animateWithDuration:lastTime animations:^{
        [self setXPosition:xPosition];
    }];
}

#pragma mark - yPosition
- (float)yPosition {
    return self.frame.origin.y;
}

- (void)setYPosition:(float)yPosition {
    for (NSLayoutConstraint *constrain in self.superview.constraints) {
        if (constrain.firstItem == self && constrain.firstAttribute == NSLayoutAttributeTop) {
            constrain.constant = yPosition;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
    }
}

- (void)setYPosition:(float)yPosition withDuration:(NSTimeInterval)lastTime {
    [UIView animateWithDuration:lastTime animations:^{
        [self setYPosition:yPosition];
    }];
}

#pragma mark - origin
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    [self setXPosition:origin.x];
    [self setYPosition:origin.y];
}

- (void)setOrigin:(CGPoint)origin withDuration:(NSTimeInterval)lastTime{
    [UIView animateWithDuration:lastTime animations:^{
        [self setOrigin:origin];
    }];
}

#pragma mark - size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    [self setWidth:size.width];
    [self setHeight:size.height];
}

- (void)setSize:(CGSize)size withDuration:(NSTimeInterval)lastTime{
    [UIView animateWithDuration:lastTime animations:^{
        [self setSize:size];
    }];
}

#pragma mark - centerX
- (float)centerX {
    return self.center.x;
}

- (void)setCenterX:(float)centerX {
    [self setXPosition:(centerX - self.width/2)];
}

- (void)setCenterX:(float)centerX withDuration:(NSTimeInterval)lastTime{
    [UIView animateWithDuration:lastTime animations:^{
        [self setCenterX:centerX];
    }];
}

#pragma mark - centerY
- (float)centerY {
    return self.center.y;
}

- (void)setCenterY:(float)centerY {
    [self setYPosition:(centerY - self.height/2)];
}

- (void)setCenterY:(float)centerY withDuration:(NSTimeInterval)lastTime{
    [UIView animateWithDuration:lastTime animations:^{
        [self setCenterY:centerY];
    }];
}


#pragma mark - centerPoint
- (CGPoint)centerPoint {
    return self.center;
}

- (void)setCenterPoint:(CGPoint)centerPoint {
    [self setCenterX:centerPoint.x];
    [self setCenterY:centerPoint.y];
}

- (void)setCenterPoint:(CGPoint)centerPoint withDuration:(NSTimeInterval)lastTime{
    [UIView animateWithDuration:lastTime animations:^{
        [self setCenterPoint:centerPoint];
    }];
}

#pragma mark - public methods
- (void)clickAction:(ClickBlock)clickBlock {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClick)];
    tapped.cancelsTouchesInView = NO;
    tapped.delegate             = self;
    [self addGestureRecognizer:tapped];
    self.clickBlock             = clickBlock;
}

#pragma mark - private methods
- (void)viewDidClick {
    if (self.clickBlock) {
        self.clickBlock(self);
    }
    //点击事件时，取消super VC子视图的 FirstResponse
    [self resignFirstResponseInViewController];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIControl class]]){
        return NO;
    }
    return YES;
}

#pragma mark - setter/getter
- (ClickBlock)clickBlock {
    return objc_getAssociatedObject(self, clickBlockKey);
}

- (void)setClickBlock:(ClickBlock)clickBlock{
    objc_setAssociatedObject(self, clickBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - findViewController
- (UIViewController*)superViewController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mark - findViewController
- (UINavigationController *)superNavigationController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mark - resignFirstResponse 
- (void)resignFirstResponseInViewController {
    UIViewController *superVC = [self superViewController];
    for (UIView *view in superVC.view.subviews) {
        if ([view respondsToSelector:@selector(isFirstResponder)]) {
            [view resignFirstResponder];
        }
    }
}

@end
