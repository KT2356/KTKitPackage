//
//  TestTableV.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "TestTableV.h"
#import "UITableView+Category.h"
#import "testcell.h"

@interface TestTableV ()
@end

@implementation TestTableV

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView dismissNavigationBarWhenOffset];
    
   
    [self.tableView usingKTDelegate];
    [self.tableView setTableRowForSingleSection:@[@"111",@"333"]];
    [self.tableView cellConfigHandler:^id(NSIndexPath *indexPath) {
        testcell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
        cell.textLabel.text = @"111";
        return cell;
    }];
    
    [self.tableView selectedHandler:^(NSIndexPath *indexPath) {
        NSLog(@"%d",indexPath.row);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {

}



@end
