//
//  UIView+IBspectable.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIView+IBspectable.h"
#import "UIColor+Category.h"

@implementation UIView (IBspectable)
@dynamic cornerRadius;
@dynamic borderColor;
@dynamic borderWidth;
@dynamic masksToBounds;
@dynamic backHexColor;
@dynamic textHexColor;
@dynamic textSize;

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

- (void)setBackHexColor:(NSString *)backHexColor {
    NSScanner *scanner = [NSScanner scannerWithString:backHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    self.backgroundColor = [UIColor colorWithRGBHex:hexNum];
}

- (void)setTextHexColor:(NSString *)textHexColor {
    NSScanner *scanner = [NSScanner scannerWithString:textHexColor];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return;
    if ([self respondsToSelector:@selector(textColor)]) {
        [self setValue:[UIColor colorWithRGBHex:hexNum] forKey:@"textColor"];
    } else if([self respondsToSelector:@selector(tintColor)]) {
        [self setValue:[UIColor colorWithRGBHex:hexNum] forKey:@"tintColor"];
    }

}

- (void)setTextSize:(float)textSize {
    if ([self respondsToSelector:@selector(font)]) {
        [self setValue:[UIFont systemFontOfSize:textSize] forKey:@"font"];
    }
}
@end
