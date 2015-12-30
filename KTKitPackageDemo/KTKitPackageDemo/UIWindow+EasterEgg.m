//
//  UIWindow+EasterEgg.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/29.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIWindow+EasterEgg.h"
#import <objc/runtime.h>

static NSInteger easterEggClickcount;
@interface UIWindow ()
@property (nonatomic, strong) UIView   *tempView;
@property (nonatomic, strong) NSNumber *trigerCount;
@property (nonatomic, strong) NSNumber *tempTimeStamp;
@property (nonatomic, copy)   EasterEggTrigerBlock trigerBlock;
@end

@implementation UIWindow (EasterEgg)

static void const *kEasterEggTempViewKey   = &kEasterEggTempViewKey;
static void const *kEasterEggTrigerBlock   = &kEasterEggTrigerBlock;
static void const *kEasterEggTrigerCount   = &kEasterEggTrigerCount;
static void const *kEasterEggTempTimeStamp = &kEasterEggTempTimeStamp;

#pragma mark - public methods
- (void)easterEggTrigerCount:(NSInteger)trigerCount
                trigerHander:(EasterEggTrigerBlock)trigerBlock
{
    self.trigerCount = [NSNumber numberWithInteger:trigerCount];
    self.trigerBlock = trigerBlock;
}


#pragma mark - hitTest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *testView = [super hitTest:point withEvent:event];
    //去除UIWindows 的响应
    if (testView != self) {
        //根据时间戳去除同一时间多次点击
        if (event.timestamp != self.tempTimeStamp.doubleValue) {
            self.tempTimeStamp = [NSNumber numberWithDouble:event.timestamp];
            //保证两次单击的不是同一个对象
            if (![testView isEqual:self.tempView]) {
                self.tempView = testView;//缓存上次单击的对象
                
                easterEggClickcount ++;
                NSLog(@"easterEggClickcount : %ld",(long)easterEggClickcount);
                //等于trigerPoint 触发彩蛋
                if (easterEggClickcount == [self.trigerCount integerValue]) {
                    easterEggClickcount = 0;
                    if (self.trigerBlock) {
                        self.trigerBlock();
                    }
                }
                //超过trigerPoint 归零
                if (easterEggClickcount > [self.trigerCount integerValue]) {
                    easterEggClickcount = 0;
                }
            }
        }
    }
    return testView;
}

#pragma mark - objc setter/getter
- (UIView *)tempView {
   return  objc_getAssociatedObject(self, kEasterEggTempViewKey);
}

- (void)setTempView:(UIView *)tempView {
    objc_setAssociatedObject(self, kEasterEggTempViewKey, tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (EasterEggTrigerBlock)trigerBlock {
    return objc_getAssociatedObject(self, kEasterEggTrigerBlock);
}

- (void)setTrigerBlock:(EasterEggTrigerBlock)trigerBlock {
    objc_setAssociatedObject(self, kEasterEggTrigerBlock, trigerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)trigerCount {
    return  objc_getAssociatedObject(self, kEasterEggTrigerCount);
}

- (void)setTrigerCount:(NSNumber *)trigerCount {
    objc_setAssociatedObject(self, kEasterEggTrigerCount, trigerCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)tempTimeStamp {
    return  objc_getAssociatedObject(self, kEasterEggTempTimeStamp);
}

- (void)setTempTimeStamp:(NSNumber *)tempTimeStamp {
    objc_setAssociatedObject(self, kEasterEggTempTimeStamp, tempTimeStamp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
