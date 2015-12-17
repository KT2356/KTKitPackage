//
//  NSObject+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (NSString *)description {
    return [NSString stringWithFormat:@"ClassType : %@",self.class];
}

@end
