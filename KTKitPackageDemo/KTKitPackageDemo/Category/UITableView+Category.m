//
//  UITableView+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "UITableView+Category.h"
#import <objc/runtime.h>

@interface UITableView ()
@end

@implementation UITableView (Category)


//采用本delegate 需要调用
- (void)usingKTDelegate {
    self.delegate   = [KTTableViewDelegate sharedModel];
    self.dataSource = [KTTableViewDataSource sharedModel];
    self.tableFooterView = [[UIView alloc]init];
}

//Bind Data
- (void)bindDataCollectionArray:(NSMutableArray *)data {
    [[KTTableViewDataSource sharedModel] setDataArrayCollection:data];
}

- (void)updateData:(NSMutableArray *)newData {
    [[KTTableViewDataSource sharedModel] updateDataArrayCollection:newData];
}

//设置rowHight
- (void)setTableAllRowHeight:(float)rowHeight {
    [[KTTableViewDelegate sharedModel] setRowHeight:rowHeight];
}

- (void)setTableRowHeight:(SetRowHeightBlock)rowHeightBlock {
    [[KTTableViewDelegate sharedModel] setSetRowHeight:rowHeightBlock];
}

//设置显示cell
- (void)cellConfigHandler:(CellConfigBlock)settingCell {
    [[KTTableViewDataSource sharedModel] setSettingCell:settingCell];
}

//cell选中操作
- (void)selectedHandler:(SelectedBlock)selectedCell {
    [[KTTableViewDelegate sharedModel] setSelectedBlock:selectedCell];
}

//HeaderView Height
- (void)setSectionHeightSingle:(float)sectionHeight {
    [[KTTableViewDelegate sharedModel] setSectionHeaderHeight:sectionHeight];
}

- (void)setSectionHeaderHeightBlock:(SetSectionHeaderHeight)setSectionHeaderBlock {
    [[KTTableViewDelegate sharedModel] setSetSectionHeaderHeight:setSectionHeaderBlock];
}

//Set HeaderView
- (void)setSectionHeaderViewSingle:(UIView *)sectionHeaderView {
    [[KTTableViewDelegate sharedModel] setHeaderView:sectionHeaderView];
}

- (void)setSectionHeaderView:(SetHeaderViewBlock)setSectionHeaderViewBlock {
    [[KTTableViewDelegate sharedModel] setSetHeaderViewBlock:setSectionHeaderViewBlock];
}


//Edit
- (void)isTableEditable:(BOOL)editable {
    [[KTTableViewDataSource sharedModel] setIsEditable:editable];
}

- (void)deleteAnimation:(UITableViewRowAnimation)animation dataSourceBlock:(DeleteRowBlock)deleteRowBlock {
    [[KTTableViewDataSource sharedModel] setDeleteAnimation:animation];
    [[KTTableViewDataSource sharedModel] setDeleteBlock:deleteRowBlock];
}



@end
