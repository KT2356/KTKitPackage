//
//  KTTableViewDataSource.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef id(^CellConfigBlock)(NSIndexPath *indexPath);
@interface KTTableViewDataSource : NSObject<UITableViewDataSource>
+ (instancetype)sharedModel ;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, copy) CellConfigBlock settingCell;
@end
