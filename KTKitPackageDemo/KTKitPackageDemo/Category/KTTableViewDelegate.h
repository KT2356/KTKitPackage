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

@interface KTTableViewDelegate : NSObject<UITableViewDelegate>
@property (nonatomic, copy) SelectedBlock selectedBlock;

+ (instancetype)sharedModel;

@end
