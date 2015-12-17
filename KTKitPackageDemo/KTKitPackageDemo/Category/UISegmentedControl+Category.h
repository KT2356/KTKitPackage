//
//  UISegmentedControl+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentHandler)(NSInteger currentIndex);
@interface UISegmentedControl (Category)

- (void)valueChangedHandler:(SegmentHandler)clickHandler;

@end
