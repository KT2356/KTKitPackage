//
//  UITableView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UITableView+Category.h"
#import <objc/runtime.h>
#import "KTTableViewDelegate.h"
#import "KTTableViewDataSource.h"

@interface UITableView ()
@end

@implementation UITableView (Category)

- (void)usingKTDelegate {
    self.delegate   = [KTTableViewDelegate sharedModel];
    self.dataSource = [KTTableViewDataSource sharedModel];
    
    self.tableFooterView = [[UIView alloc]init];
}



- (void)setTableRowForSingleSection:(NSArray *)rowDataArray {
    [[KTTableViewDataSource sharedModel] setSectionCount:1];
    [[KTTableViewDataSource sharedModel] setDataArray:rowDataArray];
}

- (void)cellConfigHandler:(CellConfigBlock)settingCell {
    [[KTTableViewDataSource sharedModel] setSettingCell:settingCell];
}

- (void)selectedHandler:(SelectedBlock)selectedCell {
    [[KTTableViewDelegate sharedModel] setSelectedBlock:selectedCell];
}


@end
