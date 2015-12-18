//
//  UITableView+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell* (^CellConfigBlock)(NSIndexPath *indexPath);
typedef void(^SelectedBlock)(NSIndexPath *indexPath);
typedef NSInteger(^RowCountBlock)(NSInteger section);
typedef float(^SetRowHeightBlock)(NSIndexPath *indexPath);


@interface UITableView (Category)

//采用本delegate 需要调用
- (void)usingKTDelegate;

//RowCount
- (void)setRowcountForSingleSection:(NSInteger)rowCount;
- (void)setRowCountHandler:(RowCountBlock)setRowCount;

//设置显示cell
- (void)cellConfigHandler:(CellConfigBlock)settingCell;

//cell选中操作
- (void)selectedHandler:(SelectedBlock)selectedCell;

//设置rowHight
- (void)setTableAllRowHeight:(float)rowHeight;
- (void)setTableRowHeight:(SetRowHeightBlock)rowHeightBlock;

//设置section数
- (void)setSectionCount:(NSInteger)sectionCount;

@end
