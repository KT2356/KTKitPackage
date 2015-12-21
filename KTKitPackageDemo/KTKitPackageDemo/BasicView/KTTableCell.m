//
//  KTTableCell.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTTableCell.h"
#import "UIColor+Category.h"

@implementation KTTableCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

/**
 *  @author KT, 2015-12-09 09:38:41
 *
 *  隐藏tableview section 分割线，该线在刷新table时有时会出现
 */
- (void)hideSectionSeparator {
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"] && subview.frame.origin.x == 0) {
            subview.hidden = YES;
        }
    }
}

- (void)setSeparatorInsetZero {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    [self setNeedsLayout];
}

#pragma mark - touches
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor colorWithRGBHex:0xDCDCDC];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self backgroundColorDefault];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self backgroundColorDefault];
}


- (void)backgroundColorDefault {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor whiteColor];
    });
}


#pragma mark -getter
- (NSString *)identifierWithClass {
    return NSStringFromClass([self class]);
}
@end
