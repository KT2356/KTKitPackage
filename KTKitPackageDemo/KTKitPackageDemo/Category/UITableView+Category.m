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
@property (nonatomic, strong) KTTableViewDelegate *ktDelegate;
@property (nonatomic, strong) KTTableViewDataSource *ktDataSource;
@end

@implementation UITableView (Category)
static const void *ktTableDelegateKey = &ktTableDelegateKey;
static const void *ktTableDatesourceKey = &ktTableDatesourceKey;

//采用本delegate 需要调用
- (void)usingKTDelegate {
    self.ktDelegate = [[KTTableViewDelegate alloc] init];
    self.ktDataSource = [[KTTableViewDataSource alloc] init];
    
    self.delegate   = self.ktDelegate;
    self.dataSource = self.ktDataSource;
    
    self.tableFooterView = [[UIView alloc]init];
}

//Bind Data
- (void)bindDataCollectionArray:(NSMutableArray *)data {
    [self.ktDataSource setDataArrayCollection:data];
}

- (void)updateData:(NSMutableArray *)newData {
    [self.ktDataSource updateDataArrayCollection:newData];
}

//设置rowHight
- (void)setTableAllRowHeight:(float)rowHeight {
    [self.ktDelegate setRowHeight:rowHeight];
}

- (void)setTableRowHeight:(SetRowHeightBlock)rowHeightBlock {
    [self.ktDelegate setSetRowHeight:rowHeightBlock];
}

//设置显示cell
- (void)cellConfigHandler:(CellConfigBlock)settingCell {
    [self.ktDataSource setSettingCell:settingCell];
}

//cell选中操作
- (void)selectedHandler:(SelectedBlock)selectedCell {
    [self.ktDelegate setSelectedBlock:selectedCell];
}

//HeaderView Height
- (void)setSectionHeightSingle:(float)sectionHeight {
    [self.ktDelegate setSectionHeaderHeight:sectionHeight];
}

- (void)setSectionHeaderHeightBlock:(SetSectionHeaderHeight)setSectionHeaderBlock {
    [self.ktDelegate setSetSectionHeaderHeight:setSectionHeaderBlock];
}

//Set HeaderView
- (void)setSectionHeaderViewSingle:(UIView *)sectionHeaderView {
    [self.ktDelegate setHeaderView:sectionHeaderView];
}

- (void)setSectionHeaderView:(SetHeaderViewBlock)setSectionHeaderViewBlock {
    [self.ktDelegate setSetHeaderViewBlock:setSectionHeaderViewBlock];
}


//Edit
- (void)isTableEditable:(BOOL)editable {
    [self.ktDataSource setIsEditable:editable];
}

- (void)deleteAnimation:(UITableViewRowAnimation)animation dataSourceBlock:(DeleteRowBlock)deleteRowBlock {
    [self.ktDataSource setDeleteAnimation:animation];
    [self.ktDataSource setDeleteBlock:deleteRowBlock];
}

#pragma mark - Runtime Setter/getter
- (KTTableViewDelegate *)ktDelegate {
    return objc_getAssociatedObject(self, ktTableDelegateKey);
}

- (void)setKtDelegate:(KTTableViewDelegate *)ktDelegate {
    objc_setAssociatedObject(self, ktTableDelegateKey, ktDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KTTableViewDataSource *)ktDataSource {
    return  objc_getAssociatedObject(self, ktTableDatesourceKey);
}

- (void)setKtDataSource:(KTTableViewDataSource *)ktDataSource {
    objc_setAssociatedObject(self, ktTableDatesourceKey, ktDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
