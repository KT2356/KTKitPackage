//
//  UIImageView+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/15.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FinishBlock)(void);

@interface UIImageView (Category)

- (void)setPlaceholderImg:(UIImage *)placeholderImg
           imageURLString:(NSString *)urlString;

- (void)setPlaceholderImg:(UIImage *)placeholderImg
           imageURLString:(NSString *)urlString
        completionHandler:(FinishBlock)finish;

- (void)deleteImageCache;

- (void)replaceCacheImage:(UIImage *)newImage;
@end
