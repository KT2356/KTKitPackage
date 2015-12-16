//
//  UISlider+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SliderHandler) (float currentValue);

@interface UISlider (Category)

- (void)valueChangedHandler:(SliderHandler)sliderHandler;

@end
