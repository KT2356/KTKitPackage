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
@property (weak, nonatomic) IBOutlet UIView *ktView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_ktView setSize:CGSizeMake(200, 200) withDuration:2];
    [_ktView setCenterPoint:CGPointMake(100, 100) withDuration:1];
    


    
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
}


@end
