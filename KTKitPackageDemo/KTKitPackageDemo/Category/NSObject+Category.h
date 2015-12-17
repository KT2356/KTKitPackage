//
//  NSObject+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

#pragma mark - runtime analysis object
- (NSArray *)getAllProperties;
- (NSArray *)getMethodsList;
- (NSDictionary *)getDictionaryObject;

@end
