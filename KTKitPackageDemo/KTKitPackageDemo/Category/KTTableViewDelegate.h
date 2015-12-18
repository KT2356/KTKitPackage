//
//  KTTableViewDelegate.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SelectedBlock)(NSIndexPath *indexPath);
typedef float(^SetRowHeightBlock)(NSIndexPath *indexPath);
typedef float(^SetSectionHeaderHeight)(NSInteger section);
typedef UIView* (^SetHeaderViewBlock)(NSInteger section);

@interface KTTableViewDelegate : NSObject<UITableViewDelegate>
@property (nonatomic, copy) SelectedBlock selectedBlock;
@property (nonatomic, copy) SetRowHeightBlock setRowHeight;
@property (nonatomic, copy) SetSectionHeaderHeight setSectionHeaderHeight;
@property (nonatomic, copy) SetHeaderViewBlock setHeaderViewBlock;

@property (nonatomic, assign) float rowHeight;
@property (nonatomic, assign) float sectionHeaderHeight;
@property (nonatomic, strong) UIView *headerView;

+ (instancetype)sharedModel;

@end
