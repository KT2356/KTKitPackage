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

#pragma mark - public methods
+ (instancetype)sharedModel {
    static KTTableViewDataSource *ktDataSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ktDataSource = [[KTTableViewDataSource alloc] init];
    });
    return ktDataSource;
}


#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowCountBlock ? self.rowCountBlock(section) : self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.settingCell ? self.settingCell(indexPath) : nil;
}

@end
