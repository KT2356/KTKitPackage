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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *ktView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    [_btn addAction:^(UIButton *sender) {
        NSLog(@"action11");
    }];
}


@end
