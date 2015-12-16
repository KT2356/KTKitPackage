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
@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;


#pragma mark - methods
- (void)clickAction:(ClickBlock)clickBlock;


#pragma mark - animation
- (void)setSize:(CGSize)size withDuration:(NSTimeInterval)lastTime;
- (void)setWidth:(float)width withDuration:(NSTimeInterval)lastTime;
- (void)setHeight:(float)height withDuration:(NSTimeInterval)lastTime;

- (void)setOrigin:(CGPoint)origin withDuration:(NSTimeInterval)lastTime;
- (void)setXPosition:(float)xPosition withDuration:(NSTimeInterval)lastTime;
- (void)setYPosition:(float)yPosition withDuration:(NSTimeInterval)lastTime;

- (void)setCenterPoint:(CGPoint)centerPoint withDuration:(NSTimeInterval)lastTime;
- (void)setCenterY:(float)centerY withDuration:(NSTimeInterval)lastTime;
- (void)setCenterX:(float)centerX withDuration:(NSTimeInterval)lastTime;

#pragma mark - find ViewController
- (UIViewController*)superViewController;
- (UINavigationController *)superNavigationController;
@end
