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


//采用本delegate 需要调用
- (void)usingKTDelegate {
    self.delegate   = [KTTableViewDelegate sharedModel];
    self.dataSource = [KTTableViewDataSource sharedModel];
    self.tableFooterView = [[UIView alloc]init];
}

//设置rowHight
- (void)setTableAllRowHeight:(float)rowHeight {
    [[KTTableViewDelegate sharedModel] setRowHeight:rowHeight];
}

- (void)setTableRowHeight:(SetRowHeightBlock)rowHeightBlock {
    [[KTTableViewDelegate sharedModel] setSetRowHeight:rowHeightBlock];
}

//设置section数
- (void)setSectionCount:(NSInteger)sectionCount {
     [[KTTableViewDataSource sharedModel] setSectionCount:sectionCount];
}

//RowCount
- (void)setRowCountHandler:(RowCountBlock)setRowCount {
    [[KTTableViewDataSource sharedModel] setRowCountBlock:setRowCount];
}

- (void)setRowcountForSingleSection:(NSInteger)rowCount {
    [[KTTableViewDataSource sharedModel] setSectionCount:1];
    [[KTTableViewDataSource sharedModel] setRowCount:rowCount];
}

//设置显示cell
- (void)cellConfigHandler:(CellConfigBlock)settingCell {
    [[KTTableViewDataSource sharedModel] setSettingCell:settingCell];
}

//cell选中操作
- (void)selectedHandler:(SelectedBlock)selectedCell {
    [[KTTableViewDelegate sharedModel] setSelectedBlock:selectedCell];
}




@end
