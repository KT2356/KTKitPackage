//
//  Test2YTable.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "Test2YTable.h"
#import "UITableView+Category.h"
#import "testcell.h"

@implementation Test2YTable

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *data = @[@"11111",@"21111",@"3311"];
    NSMutableArray *dataArray = [@[] mutableCopy];
    
    [dataArray addObject:data];
    
    [self.tableView usingKTDelegate];
    [self.tableView setTableAllRowHeight:90];
    [self.tableView bindDataCollectionArray:dataArray];
    
    [self.tableView setSectionHeightSingle:50];
    UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    viewB.backgroundColor = [UIColor lightGrayColor];
    [self.tableView setSectionHeaderViewSingle:viewB];

    
    
    [self.tableView cellConfigHandler:^UITableViewCell *(NSMutableArray *dataCollection, NSIndexPath *indexPath) {
        testcell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"test2" forIndexPath:indexPath];
        cell.label.text = dataCollection[indexPath.section][indexPath.row];
        return cell;
    }];
    
    
    [self.tableView selectedHandler:^(NSIndexPath *indexPath) {
        NSLog(@"%ld",(long)indexPath.row);
    }];
    
    
    [self.tableView isTableEditable:YES];
    
    [self.tableView deleteAnimation:UITableViewRowAnimationMiddle dataSourceBlock:^(NSMutableArray *newdataCollection, NSIndexPath *indexPath) {
        NSLog(@"new data :%@",newdataCollection);
    }];
}
@end
