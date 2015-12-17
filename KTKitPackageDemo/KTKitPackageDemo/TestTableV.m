//
//  TestTableV.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "TestTableV.h"
#import "UIScrollView+Category.h"

@implementation TestTableV

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView dismissNavigationBarWhenOffset];
    
    self.sectionCount = 1;
    self.rowCountArray = @[@10];
    [self selectedHandler:^(NSIndexPath *indexPath) {
        NSLog(@"select %d",indexPath.row);
    }];
    
    __weak typeof(self) weakself = self;
    [self setCellHandler:^UITableViewCell *(NSIndexPath *indexPath) {
        UITableViewCell *cell = [weakself.tableView dequeueReusableCellWithIdentifier:@"111"];
        cell.textLabel.text = @"2334";
        return cell;
    }];
    
}
@end
