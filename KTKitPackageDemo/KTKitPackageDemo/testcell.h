//
//  testcell.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTTableCell.h"

@interface testcell : KTTableCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end
