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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.setRowHeight ? self.setRowHeight(indexPath) : self.rowHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.setSectionHeaderHeight) {
        return self.setSectionHeaderHeight(section);
    } else {
        return self.sectionHeaderHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.setHeaderViewBlock) {
        return self.setHeaderViewBlock(section);
    } else if (self.headerView) {
        return self.headerView;
    } else {
        return nil;
    }
}

@end
