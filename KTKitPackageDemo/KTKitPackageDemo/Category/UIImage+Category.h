//
//  UIImage+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

//裁剪图片
- (UIImage *)clipImageWithRect:(CGRect)clipFrame;

@end
