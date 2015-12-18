//
//  TestTableV.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "TestTableV.h"
#import "UIScrollView+Category.h"
#import "UITableView+Category.h"
#import "testcell.h"

@interface TestTableV ()
@end

@implementation TestTableV

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView dismissNavigationBarWhenOffset];
    NSArray *dataArray = @[@"1",@"2",@"33",@"44",@"44",@"555"];
   
    [self.tableView usingKTDelegate];
    [self.tableView setTableAllRowHeight:50];
    [self.tableView setRowcountForSingleSection:dataArray.count];
    
    [self.tableView cellConfigHandler:^id(NSIndexPath *indexPath) {
        testcell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
        cell.textLabel.text = dataArray[indexPath.row];
        return cell;
    }];
    
    
    [self.tableView selectedHandler:^(NSIndexPath *indexPath) {
        NSLog(@"%d",indexPath.row);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {

}



@end
