//
//  UITextField+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TextFielderHandlerArgs)(NSString *textString);
@interface UITextField (Category)

- (void)returnHandler:(TextFielderHandlerArgs)returnHandler;

- (void)textChangeHandler:(TextFielderHandlerArgs)textHandler;


@end
