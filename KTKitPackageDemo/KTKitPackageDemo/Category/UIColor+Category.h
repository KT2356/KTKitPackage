//
//  UIColor+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

#pragma mark - RGB
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

#pragma mark - RGB & alpha
+ (UIColor *)colorWithRGBHex:(UInt32)hex
                       alpha:(float)alpha;

#pragma mark - RGBA
+ (UIColor *)colorWithRGBA:(NSUInteger)rgbaValue;

@end
