//
//  KTTableViewDataSource.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell* (^CellConfigBlock)(NSIndexPath *indexPath);
typedef NSInteger(^RowCountBlock)(NSInteger section);

@interface KTTableViewDataSource : NSObject<UITableViewDataSource>
+ (instancetype)sharedModel ;

@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger rowCount;

@property (nonatomic, copy) CellConfigBlock settingCell;
@property (nonatomic, copy) RowCountBlock rowCountBlock;
@end
