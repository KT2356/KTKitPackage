//
//  UIImage+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

//裁剪图片
- (UIImage *)clipImageWithRect:(CGRect)clipFrame {
    CGImageRef refImage = CGImageCreateWithImageInRect(self.CGImage, clipFrame);
    UIImage *newImage = [UIImage imageWithCGImage:refImage];
    CGImageRelease(refImage);
    return newImage;
}

@end
