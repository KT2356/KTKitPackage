//
//  UITableView+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef id(^CellConfigBlock)(NSIndexPath *indexPath);
typedef void(^SelectedBlock)(NSIndexPath *indexPath);

@interface UITableView (Category)

- (void)usingKTDelegate;

- (void)setTableRowForSingleSection:(NSArray *)rowDataArray;

- (void)cellConfigHandler:(CellConfigBlock)settingCell;

- (void)selectedHandler:(SelectedBlock)selectedCell;

@end
