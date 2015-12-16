//
//  UITextField+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UITextField+Category.h"
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
    self.returnHandler(textField.text);
    return YES;
}

- (void)textFieldDidChange:(UITextField *)sender {
    self.textChangedHandler(sender.text);
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
