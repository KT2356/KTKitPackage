//
//  UIView+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(UIView *sender);
@interface UIView (Category)

#pragma mark - position property
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float xPosition;
@property (nonatomic, assign) float yPosition;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;


#pragma mark - methods
- (void)clickAction:(ClickBlock)clickBlock;

@end
