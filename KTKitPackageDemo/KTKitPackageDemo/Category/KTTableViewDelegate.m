//
//  KTTableViewDelegate.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTTableViewDelegate.h"
@interface KTTableViewDelegate()
@end

@implementation KTTableViewDelegate

+ (instancetype)sharedModel {
    static KTTableViewDelegate *ktdelegate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ktdelegate = [[KTTableViewDelegate alloc] init];
    });
    return ktdelegate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.setRowHeight ? self.setRowHeight(indexPath) : self.rowHeight;
}


@end
