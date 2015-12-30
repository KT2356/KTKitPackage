//
//  UIWindow+EasterEgg.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/29.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EasterEggTrigerBlock)(void);

@interface UIWindow (EasterEgg)
- (void)easterEggTrigerCount:(NSInteger)trigerCount
                trigerHander:(EasterEggTrigerBlock)trigerBlock;
@end
