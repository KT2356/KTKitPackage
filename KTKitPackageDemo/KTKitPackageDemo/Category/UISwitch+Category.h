//
//  UISwitch+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchBlock)(BOOL isSelected);
@interface UISwitch (Category)

- (void)actionHandler:(SwitchBlock)actionHandler;

@end
