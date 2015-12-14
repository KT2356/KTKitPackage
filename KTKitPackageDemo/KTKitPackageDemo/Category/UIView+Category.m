//
//  UIView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark - position
- (float)width {
    return self.bounds.size.width;
}
- (float)height {
    return self.bounds.size.height;
}
- (float)xPosition {
    return self.frame.origin.x;
}
- (float)yPosition {
    return self.frame.origin.y;
}


@end
