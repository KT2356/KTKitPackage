//
//  UIScrollView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIScrollView+Category.h"
#import "UIView+Category.h"

@implementation UIScrollView (Category)

#pragma mark - KVO 渐隐导航栏
- (void)dismissNavigationBarWhenOffset {
    [self addObserver:self forKeyPath:@"contentOffset" options: NSKeyValueObservingOptionNew context: nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGFloat offset = self.contentOffset.y;
    CGFloat delta = offset / 64.f;
    delta = MAX(0, delta);
    if ([[self superNavigationController] isKindOfClass:[UINavigationController class]]) {
        [self superNavigationController].navigationBar.alpha = 1 - delta;
    }
}


//- (void)dealloc {
//    if ([self isKindOfClass:[UITableView class]]) {
//            [self removeObserver:self forKeyPath:@"contentOffset"];
//    }
//}


@end
