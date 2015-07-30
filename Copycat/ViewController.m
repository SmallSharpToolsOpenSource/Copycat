//
//  ViewController.m
//  Copycat
//
//  Created by Brennan Stehling on 7/29/15.
//  Copyright (c) 2015 Brennan Stehling. All rights reserved.
//

#import "ViewController.h"

#import "Item.h"
#import "CopyableItem.h"

#define kTagLeftLabel 1
#define kTagRightLabel 2

@interface ViewController () <UITabBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation ViewController {
    BOOL _isMutated;
}

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.tableView, @"Outlet is required");
    NSAssert([self.tableView.delegate isEqual:self], @"Outlet is required");
    NSAssert([self.tableView.dataSource isEqual:self], @"Outlet is required");
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self tryCopyingItems];
    [self populateOriginalItems];
}

#pragma mark - User Actions
#pragma mark -

- (IBAction)changeButtonTapped:(id)sender {
    if (!_isMutated) {
        [self populateMutatedItems];
    }
    else {
        [self populateOriginalItems];
    }
}

#pragma mark - Private
#pragma mark -

- (void)tryCopyingItems {
    NSArray *items = @[[Item itemWithTitle:@"One" number:@"1"]];
    NSLog(@"Items");
    NSLog(@"%@", items);
    
    NSArray *copiedItems = items.copy;
    
    // change the values after the copy
    Item *item = items.firstObject;
    item.title = @"Two";
    item.number = @"2";
    
    NSLog(@"Copied Items");
    NSLog(@"%@", copiedItems);
    
    NSArray *copyableItems = @[[CopyableItem itemWithTitle:@"Three" number:@"3"]];
    NSLog(@"Copyable Items");
    NSLog(@"%@", copyableItems);
    
    NSArray *copiedCopyableItems = copyableItems.copy;
    
    // change the values after the copy
    CopyableItem *copyableItem = copyableItems.firstObject;
    copyableItem.title = @"Four";
    copyableItem.number = @"4";
    
    NSLog(@"Copied Copyable Items");
    NSLog(@"%@", copiedCopyableItems);
    
    CopyableItem *item1 = [CopyableItem itemWithTitle:@"One" number:@"1"];
    CopyableItem *item2 = item1.copy;
    item2.title = @"2";
    item2.number = @"Two";
    
    NSLog(@"1: %@ [original]", item1);
    NSLog(@"2: %@ [changed after copy]", item2);
    NSLog(@"3: %@ [before copy]", item1);
}

- (void)populateOriginalItems {
    NSArray *items = @[
                       [Item itemWithTitle:@"One" number:@"1"],
                       [Item itemWithTitle:@"Two" number:@"2"],
                       [Item itemWithTitle:@"Three" number:@"3"],
                       [Item itemWithTitle:@"Four" number:@"4"],
                       [Item itemWithTitle:@"Five" number:@"5"],
                       [CopyableItem itemWithTitle:@"Six" number:@"6"],
                       [CopyableItem itemWithTitle:@"Seven" number:@"7"],
                       [CopyableItem itemWithTitle:@"Eight" number:@"8"],
                       [CopyableItem itemWithTitle:@"Nine" number:@"9"],
                       [CopyableItem itemWithTitle:@"Ten" number:@"10"]
                       ];
    NSLog(@"%@", items);
    
    self.items = items.mutableCopy;
    [self.tableView reloadData];
    
    _isMutated = NO;
}

- (void)populateMutatedItems {
    NSArray *items = self.items.copy;

    // modify the copied array only and leave self.items unmodified

    for (id obj in items) {
        if ([obj isKindOfClass:[Item class]]) {
            Item *item = (Item *)obj;
            item.title = @"Eighty-eight";
            item.number = @"88";
        }
        else if ([obj isKindOfClass:[CopyableItem class]]) {
            CopyableItem *item = (CopyableItem *)obj;
            item.title = @"Ninety-nine";
            item.number = @"99";
        }
    }
    
    NSLog(@"%@ [original]", self.items);
    NSLog(@"%@ [modified copy]", items);
    
    [self.tableView reloadData];
    
    _isMutated = YES;
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *leftLabel = (UILabel *)[cell viewWithTag:kTagLeftLabel];
    UILabel *rightLabel = (UILabel *)[cell viewWithTag:kTagRightLabel];
    
    Item *item = self.items[indexPath.row];
    
    leftLabel.text = item.title;
    rightLabel.text = item.number;
    
    return cell;
}

#pragma mark - UITableViewDelegate
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
