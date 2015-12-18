//
//  ViewController.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Category.h"
#import "UIImageView+Category.h"
#import "UIButton+Category.h"
#import "UIAlertController+Category.h"
#import "UITextField+Category.h"
#import "UISlider+Category.h"
#import "NSString+Category.h"
#import "TestModel.h"
#import "UISegmentedControl+Category.h"
#import "UISwitch+Category.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *ktView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISwitch * switchBTN;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestModel *model = [[TestModel alloc] init];
    model.name = @"KT";
    model.age = @"21";
    model.job = @"programmer";
    model.locate = @"cd";
    
    NSLog(@"%@",model);
    
    
    
    [_ktView setOrigin:CGPointMake(0, 0) withDuration:1];
    [_ktView setSize:CGSizeMake(100, 100) withDuration:2];
    
    NSLog(@"size: %f,%f",_ktView.width,_ktView.height);
    NSLog(@"origin: %f,%f",_ktView.xPosition,_ktView.yPosition);
    _ktView.backgroundColor = [UIColor greenColor];
    
    [_ktView clickAction:^(UIView *sender) {
        NSLog(@"%@",sender.backgroundColor);
    }];
    
    [_label clickAction:^(UIView *sender) {
        NSLog(@"%@",((UILabel *)sender).text);
    }];
    [self.view clickAction:^(UIView *sender) {
        NSLog(@"1");
    }];
    
    [_imageView clickAction:^(UIView *sender) {
        NSLog(@"image click");
    }];
    
    [_imageView setPlaceholderImg:[UIImage imageNamed:@"a"]
                   imageURLString:@"http://down1.cnmo.com/app/a129/fangzi00.jpg"
     completionHandler:^{
         NSLog(@"finished");
     }];
    [_imageView deleteImageCache];
    
    //[_imageView replaceCacheImage:[UIImage imageNamed:@"a"]];
    
//    UIAlertController *alertsheet = [UIAlertController initActionSheetWithTitle:@"aaa" ActionTitleArray:@[@"11",@"22"] CancelHandler:^{
//            NSLog(@"cancel");
//        }
//        ActionHandler:^(int index) {
//            if (index == 0) {
//                NSLog(@"0 click");
//            } else if (index == 1) {
//                 NSLog(@"1 click");
//            }
//          }
//    ];
    
    UIAlertController *alertSingle = [UIAlertController initSingleAlertWithTitle:@"提醒"  actionHandler:^{
        NSLog(@"ok");
    }];
    
//    UIAlertController *alert = [UIAlertController initAlertWithTitle:@"确认删除"
//      cancelHandler:^{
//        NSLog(@"cancel");
//    } OKHandler:^{
//        NSLog(@"ok");
//    }];
    
    [_btn actionHandler:^(UIButton *sender) {
        [self presentViewController:alertSingle animated:YES completion:nil];
    }];
    
    [_textField returnHandler:^(NSString *textString) {
        NSLog(@"return : %@",textString);
    }];
    
    
    [_textField textChangeHandler:^(NSString *textString) {
        NSLog(@"--%@",textString);
    }];
    
    [_slider valueChangedHandler:^(float currentValue) {
        NSLog(@"%f",currentValue);
    }];
    
    [_segment valueChangedHandler:^(NSInteger currentIndex) {
        NSLog(@"%ld---",(long)currentIndex);
    }];
    
    [_switchBTN actionHandler:^(BOOL isSelected) {
        //NSLog(@"%hhd",isSelected);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view resignFirstResponseInViewController];
}

@end
