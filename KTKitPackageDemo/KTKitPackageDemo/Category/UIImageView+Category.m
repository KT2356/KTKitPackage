//
//  UIImageView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/15.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIImageView+Category.h"
#import <objc/runtime.h>

@interface UIImageView()
@property (nonatomic, strong) NSString *imageStroageKey;
@property (nonatomic, copy) FinishBlock finishBlock;
@end

@implementation UIImageView (Category)
static const void *kTImageStroageKey     = &kTImageStroageKey;
static const void *kTImageFinishBlockKey = &kTImageFinishBlockKey;

- (void)setPlaceholderImg:(UIImage *)placeholderImg
           imageURLString:(NSString *)urlString {
    [self setImage:placeholderImg];
    [self gotImageStorageKey:urlString];
    //判断图像是否存于本地
    UIImage *image = [self loadImageFromCache];
    if (image) {
        [self setImage:image];
    } else {
        [self requestImage:urlString];
    }
    
}
- (void)setPlaceholderImg:(UIImage *)placeholderImg
           imageURLString:(NSString *)urlString
        completionHandler:(FinishBlock)finish
{
    [self setPlaceholderImg:placeholderImg imageURLString:urlString];
     self.finishBlock = finish;
}


- (void)deleteImageCache {
    if (self.imageStroageKey.length) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:self.imageStroageKey];
    }
}

- (void)replaceCacheImage:(UIImage *)newImage {
    if (newImage) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newImage];
        if (self.imageStroageKey.length) {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.imageStroageKey];
        }
    }
}

#pragma mark - web request
- (void)requestImage:(NSString *)imageUrlString {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrlString]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if (!error) {
                                                           UIImage *webImage = [UIImage imageWithData:data];
                                                           if (webImage) {
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [self setImage:webImage];
                                                               });
                                                               if (self.finishBlock) {
                                                                   self.finishBlock();
                                                               }
                                                               [self storeImageToCache:webImage];
                                                           }
                                                       } else {
                                                           NSLog(@"download image error : %@",error);
                                                       }
                                                   }];
    
    [dataTask resume];
}

#pragma mark - 产生图片保存key
- (void)gotImageStorageKey:(NSString *)urlString {
    self.imageStroageKey = [NSString stringWithFormat:@"KTUIImageStorage-%@",urlString];
}

#pragma mark - save/load Pic
- (UIImage *)loadImageFromCache {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:self.imageStroageKey];
    if(!data) {
        return nil;
    }
    UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return image ? image : nil;
}

- (void)storeImageToCache:(UIImage *)image {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:image];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.imageStroageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - runtime setter/getter
- (NSString *)imageStroageKey {
    return objc_getAssociatedObject(self, kTImageStroageKey);
}

- (void)setImageStroageKey:(NSString *)imageStroageKey {
    objc_setAssociatedObject(self, kTImageStroageKey, imageStroageKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (FinishBlock)finishBlock {
    return objc_getAssociatedObject(self, kTImageFinishBlockKey);
}

- (void)setFinishBlock:(FinishBlock)finishBlock {
    objc_setAssociatedObject(self, kTImageFinishBlockKey, finishBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
