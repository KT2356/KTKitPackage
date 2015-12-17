//
//  UISegmentedControl+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UISegmentedControl+Category.h"
#import <objc/runtime.h>

@interface UISegmentedControl ()
@property (nonatomic, copy) SegmentHandler tapedHandler;
@end
@implementation UISegmentedControl (Category)
static const void *ktSegmentControllerKey = &ktSegmentControllerKey;

#pragma mark - public methods
- (void)valueChangedHandler:(SegmentHandler)clickHandler {
    [self addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    self.tapedHandler = clickHandler;
}

#pragma mark - private action
- (void)segmentAction:(UISegmentedControl *)Seg {
     NSInteger index = Seg.selectedSegmentIndex;
    if (self.tapedHandler) {
        self.tapedHandler(index);
    }
}

#pragma mark - setter/getter
- (SegmentHandler)tapedHandler {
    return objc_getAssociatedObject(self, ktSegmentControllerKey);
}

- (void)setTapedHandler:(SegmentHandler)tapedHandler {
    objc_setAssociatedObject(self, ktSegmentControllerKey, tapedHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
