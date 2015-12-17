//
//  UITextField+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UITextField+Category.h"
#import "UIView+Category.h"
#import <objc/runtime.h>
@interface UITextField ()<UITextFieldDelegate>
@property (nonatomic, copy) TextFielderHandlerArgs returnHandler;
@property (nonatomic, copy) TextFielderHandlerArgs textChangedHandler;
@end

@implementation UITextField (Category)
static const void *KTreturnHandler = &KTreturnHandler;
static const void *KTtextChangedHandler = &KTtextChangedHandler;

#pragma mark - return
- (void)returnHandler:(TextFielderHandlerArgs)returnHandler {
    self.delegate = self;
    self.returnHandler = returnHandler;
}

- (void)textChangeHandler:(TextFielderHandlerArgs)textHandler {
    self.textChangedHandler = textHandler;
    [self addTarget:self  action:@selector(textFieldDidChange:)  forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    if (self.returnHandler) {
        self.returnHandler(textField.text);
    }
    return YES;
}

//防止键盘覆盖view autoScroll
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    UIView *mainView = [self superViewController].view;
    if (mainView.height - self.yPosition - self.height < 252) {
        float transformY = 20 - (mainView.height - self.yPosition - self.height - 252);
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, mainView.height, mainView.width, transformY)];
        backView.backgroundColor = mainView.backgroundColor;
        [mainView addSubview:backView];
        [mainView transformToPoint:CGPointMake(0, -transformY) withDuration:0.5];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *mainView = [self superViewController].view;
    if (mainView.height - self.yPosition - self.height < 252) {
        [mainView transformToPoint:CGPointMake(0, 0) withDuration:0.5 completion:^{
            for (UIView *subView in mainView.subviews) {
                if (subView.yPosition == mainView.height) {
                    [subView removeFromSuperview];
                }
            }
        }];
    }
}

- (void)textFieldDidChange:(UITextField *)sender {
    if (self.textChangedHandler) {
        self.textChangedHandler(sender.text);
    }
}


#pragma mark - objc/runtime
- (TextFielderHandlerArgs)returnHandler {
   return  objc_getAssociatedObject(self, KTreturnHandler);
}

- (void)setReturnHandler:(TextFielderHandlerArgs)returnHandler {
    objc_setAssociatedObject(self, KTreturnHandler, returnHandler, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (TextFielderHandlerArgs)textChangedHandler {
    return  objc_getAssociatedObject(self, KTtextChangedHandler);
}

- (void)setTextChangedHandler:(TextFielderHandlerArgs)textChangedHandler {
    objc_setAssociatedObject(self, KTtextChangedHandler, textChangedHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
