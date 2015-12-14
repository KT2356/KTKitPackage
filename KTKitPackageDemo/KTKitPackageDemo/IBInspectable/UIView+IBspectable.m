//
//  UIView+IBspectable.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIView+IBspectable.h"

@implementation UIView (IBspectable)
@dynamic cornerRadius;
@dynamic borderColor;
@dynamic borderWidth;
@dynamic masksToBounds;

#pragma mark - IBInspectable
- (void)setCornerRadius:(float)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (void)setBorderWidth:(float)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}




@end
