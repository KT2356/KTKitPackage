//
//  ViewController.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Category.h"
#import "UIView+IBspectable.h"
#import "KTView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet KTView *ktView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:testView];
    
    [_ktView clickAction:^(UIView *sender) {
        NSLog(@"%@",sender.backgroundColor);
    }];
    
    [_label clickAction:^(UIView *sender) {
        NSLog(@"label");
    }];
    
    _ktView.width = 60;
    _ktView.height = 200;
    
    NSLog(@"width : %f",_ktView.width);
    _ktView.backgroundColor = [UIColor greenColor];
}


@end
