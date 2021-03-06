//
//  UIView+IBspectable.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBspectable)
@property (assign, nonatomic) IBInspectable float    cornerRadius;
@property (assign, nonatomic) IBInspectable float    borderWidth;
@property (strong, nonatomic) IBInspectable UIColor  *borderColor;
@property (strong, nonatomic) IBInspectable NSString *backHexColor;
@property (strong, nonatomic) IBInspectable NSString *textHexColor;
@property (assign, nonatomic) IBInspectable float    textSize;
@property (assign, nonatomic) IBInspectable BOOL     masksToBounds;
@end
