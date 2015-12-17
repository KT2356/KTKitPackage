//
//  KTTableViewController.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedHandler)(NSIndexPath *indexPath);
typedef UITableViewCell* (^setCellBlock)(NSIndexPath *indexPath);

@interface KTTableViewController : UITableViewController

@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, strong) NSArray *rowCountArray;


- (void)selectedHandler:(selectedHandler)selected;
- (void)setCellHandler:(setCellBlock)cellBlock;

@end
