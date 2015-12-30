//
//  TestTableV.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "TestTableV.h"
//#import "UIScrollView+Category.h"
#import "UITableView+Category.h"
#import "testcell.h"

@interface TestTableV ()
@end

@implementation TestTableV

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView dismissNavigationBarWhenOffset];
    NSArray *data = @[@"1",@"2",@"33",@"44",@"44",@"555"];
    NSMutableArray *dataArray = [@[] mutableCopy];
    
    [dataArray addObject:data];
   
    [self.tableView usingKTDelegate];
    [self.tableView setTableAllRowHeight:50];
    [self.tableView bindDataCollectionArray:dataArray];
    
    
    [self.tableView cellConfigHandler:^UITableViewCell *(NSMutableArray *dataCollection, NSIndexPath *indexPath) {
        testcell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
        cell.textLabel.text = dataCollection[indexPath.section][indexPath.row];
        [cell setSeparatorInsetZero];
        return cell;
    }];
    
    
    [self.tableView selectedHandler:^(NSIndexPath *indexPath) {
        NSLog(@"%ld",(long)indexPath.row);
    }];
    

    
    [self.tableView isTableEditable:YES];
    
    [self.tableView deleteAnimation:UITableViewRowAnimationFade dataSourceBlock:^(NSMutableArray *newdataCollection, NSIndexPath *indexPath) {
        NSLog(@"new data :%@",newdataCollection);
    }];
    
    
//    NSArray *data2 = @[@"1",@"2"];
//    NSMutableArray *dataArray2 = [@[] mutableCopy];
//    [dataArray2 addObject:data2];
//    
//    [self.tableView updateData:dataArray2];
//    [self.tableView reloadData];

    
}

- (void)viewDidAppear:(BOOL)animated {

}



@end
