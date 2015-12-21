//
//  KTTableCell.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/17.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+IBspectable.h"

IB_DESIGNABLE
@interface KTTableCell : UITableViewCell

@property (nonatomic, strong, readonly) NSString *identifierWithClass;

- (void)hideSectionSeparator;
- (void)setSeparatorInsetZero;

@end
