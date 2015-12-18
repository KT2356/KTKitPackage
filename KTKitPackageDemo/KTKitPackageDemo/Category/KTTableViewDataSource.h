//
//  KTTableViewDataSource.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell* (^CellConfigBlock)(NSMutableArray *dataCollection, NSIndexPath *indexPath);
typedef void(^DeleteRowBlock)(NSMutableArray *newdataCollection,NSIndexPath *indexPath);

@interface KTTableViewDataSource : NSObject<UITableViewDataSource>

+ (instancetype)sharedModel ;
- (void)updateDataArrayCollection:(NSMutableArray *)dataArrayCollection;

@property (nonatomic, strong) NSMutableArray *dataArrayCollection;
@property (nonatomic, copy) CellConfigBlock settingCell;

@property (nonatomic, assign) BOOL isEditable;
@property (nonatomic, assign) UITableViewRowAnimation deleteAnimation;
@property (nonatomic, copy) DeleteRowBlock deleteBlock;
@end
