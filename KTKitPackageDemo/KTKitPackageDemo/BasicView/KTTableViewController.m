//
//  KTTableViewController.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTTableViewController.h"

@interface KTTableViewController()
@property (nonatomic, copy) selectedHandler selectHandler;
@property (nonatomic, copy) setCellBlock setCellBlock;
@end

@implementation KTTableViewController

#pragma mark - life cycle

#pragma mark - public methods
- (void)selectedHandler:(selectedHandler)selected {
    self.selectHandler = selected;
}

- (void)setCellHandler:(setCellBlock)cellBlock {
    self.setCellBlock = cellBlock;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    if (self.rowCountArray && self.rowCountArray.count >= section) {
        rowCount = (NSInteger)self.rowCountArray[section];
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.setCellBlock ? self.setCellBlock(indexPath) : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectHandler) {
        self.selectHandler(indexPath);
    }
}





@end
