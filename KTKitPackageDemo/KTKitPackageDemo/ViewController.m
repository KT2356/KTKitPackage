//
//  ViewController.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:testView];
    
    NSLog(@"xPosition : %f",testView.xPosition);
}

@end
