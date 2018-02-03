//
//  KYTableViewObject.m
//  KYForm
//
//  Created by mac on 2018/2/2.
//

#import "KYTableViewModel.h"
#import "KYTableViewSectionObject.h"

@implementation KYTableViewModel

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count > 0 ? self.sections.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
    return sectionObject.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
    return sectionObject.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    KYTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
    return sectionObject.footerTitle;
}

#pragma mark - KYTableViewDataSource

- (KYTableViewItemObject *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(KYTableViewItemObject *)itemObject {
    return nil;
}

@end
