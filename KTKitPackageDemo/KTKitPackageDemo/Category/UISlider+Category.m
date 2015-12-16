//
//  UISlider+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UISlider+Category.h"
#import <objc/runtime.h>

@interface UISlider ()
@property (nonatomic, strong) NSNumber *pastValue;//存储上次值，防止值不变时触发UIControlEventValueChanged
@property (nonatomic, copy) SliderHandler sliderValueChanged;
@end

@implementation UISlider (Category)
static const void *KTSliderKey          = &KTSliderKey;
static const void *KTSliderPastValueKey = &KTSliderPastValueKey;

#pragma mark - public methods
- (void)valueChangedHandler:(SliderHandler)sliderHandler {
    [self addTarget:self action:@selector(sliderValueDidChanged) forControlEvents:UIControlEventValueChanged];
    self.sliderValueChanged = sliderHandler;
}

#pragma mark - private methods
- (void)sliderValueDidChanged {
    if (self.pastValue.floatValue != self.value) {
        self.sliderValueChanged(self.value);
        self.pastValue = [NSNumber numberWithFloat:self.value];
    }
}

#pragma mark - objc/runtime
- (SliderHandler)sliderValueChanged {
    return objc_getAssociatedObject(self, KTSliderKey);
}

- (void)setSliderValueChanged:(SliderHandler)sliderValueChanged {
    objc_setAssociatedObject(self, KTSliderKey, sliderValueChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)pastValue {
    return objc_getAssociatedObject(self, KTSliderPastValueKey);
}

- (void)setPastValue:(NSNumber*)pastValue {
    objc_setAssociatedObject(self, KTSliderPastValueKey, pastValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
 
}
@end
