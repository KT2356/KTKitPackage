//
//  KTTableViewDataSource.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/18.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTTableViewDataSource.h"
#import "testcell.h"
@interface KTTableViewDataSource()
@end
@implementation KTTableViewDataSource
@synthesize dataArrayCollection = _dataArrayCollection;

#pragma mark - public methods
- (void)updateDataArrayCollection:(NSMutableArray *)dataArrayCollection {
    [self setDataArrayCollection:dataArrayCollection];
}


#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArrayCollection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArrayCollection.count > section) {
        NSArray *subArray = self.dataArrayCollection[section];
        if (subArray && subArray.count > 0) {
            return subArray.count;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.settingCell ? self.settingCell(self.dataArrayCollection,indexPath) : nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return self.isEditable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && self.deleteBlock) {
        
        [self.dataArrayCollection[indexPath.section] removeObjectAtIndex:indexPath.row];
        self.deleteBlock(self.dataArrayCollection,indexPath);
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:self.deleteAnimation];
        [tableView reloadData];
    }
}

#pragma mark - setter
- (void)setDataArrayCollection:(NSMutableArray *)dataArrayCollection {
    if (!dataArrayCollection) {
        return;
    }
    if (!_dataArrayCollection) {
        _dataArrayCollection = [@[] mutableCopy];
    }
    if (_dataArrayCollection.count) {
        [_dataArrayCollection removeAllObjects];
    }
    for (id subObj in dataArrayCollection) {
        if ([subObj isKindOfClass:[NSArray class]]) {
            [_dataArrayCollection addObject:[subObj mutableCopy]];
        }
    }
}

- (void)dealloc {
}
@end
