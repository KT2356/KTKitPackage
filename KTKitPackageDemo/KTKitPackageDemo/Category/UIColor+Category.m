//
//  UIColor+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8)  & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
                       alpha:(float)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8)  & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithRGBA:(NSUInteger)rgbaValue
{
    return [UIColor
            colorWithRed:((float)((rgbaValue & 0xFF000000) >> 16)) / 255.0
            green:((float)((rgbaValue & 0xFF0000) >> 8)) / 255.0
            blue:((float)(rgbaValue & 0xFF00)) / 255.0
            alpha:((float)(rgbaValue & 0xFF)) / 255.0];
    
}

@end
