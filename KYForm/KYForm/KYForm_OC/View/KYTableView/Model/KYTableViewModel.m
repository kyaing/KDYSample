//
//  KYTableViewObject.m
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import "KYTableViewModel.h"
#import "KYTableViewSectionObject.h"
#import "KYTableViewCell.h"
#import "NSArray+extension.h"

@implementation KYTableViewModel

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count > 0 ? self.sections.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndexSafe:section];
    return sectionObject.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYTableViewItemObject *itemObject = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:itemObject];
    NSString *cellName = NSStringFromClass(cellClass);
    
    KYTableViewCell *cell = (KYTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    cell.itemObject = itemObject;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndexSafe:section];
    return sectionObject.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndexSafe:section];
    return sectionObject.footerTitle;
}

#pragma mark - KYTableViewDataSource

- (KYTableViewItemObject *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndexSafe:indexPath.section];
    return [sectionObject.items objectAtIndexSafe:indexPath.row];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(KYTableViewItemObject *)itemObject {
    return [KYTableViewCell class];
}

@end
