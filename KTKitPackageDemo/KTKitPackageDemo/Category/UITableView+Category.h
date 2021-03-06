//
//  UITableView+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KTTableViewDelegate.h"
#import "KTTableViewDataSource.h"

@interface UITableView (Category)

//采用本delegate 需要调用
- (void)usingKTDelegate;


//Bind Data
- (void)bindDataCollectionArray:(NSMutableArray *)data;

//update
- (void)updateData:(NSMutableArray *)newData;

//设置显示cell
- (void)cellConfigHandler:(CellConfigBlock)settingCell;

//cell选中操作
- (void)selectedHandler:(SelectedBlock)selectedCell;

//设置rowHight
- (void)setTableAllRowHeight:(float)rowHeight;
- (void)setTableRowHeight:(SetRowHeightBlock)rowHeightBlock;



//HeaderView Height
- (void)setSectionHeightSingle:(float)sectionHeight;
- (void)setSectionHeaderHeightBlock:(SetSectionHeaderHeight)setSectionHeaderBlock ;

//Set HeaderView
- (void)setSectionHeaderViewSingle:(UIView *)sectionHeaderView;
- (void)setSectionHeaderView:(SetHeaderViewBlock)setSectionHeaderViewBlock ;

//editAble
- (void)isTableEditable:(BOOL)editable;

//Delete
- (void)deleteAnimation:(UITableViewRowAnimation)animation dataSourceBlock:(DeleteRowBlock)deleteRowBlock;


@end
