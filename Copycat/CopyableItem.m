//
//  CopyableItem.m
//  Copycat
//
//  Created by Brennan Stehling on 7/29/15.
//  Copyright (c) 2015 Brennan Stehling. All rights reserved.
//

#import "CopyableItem.h"

@implementation CopyableItem

+ (instancetype)itemWithTitle:(NSString *)title number:(NSString *)number {
    CopyableItem *item = [[CopyableItem alloc] init];
    item.title = title.copy;
    item.number = number.copy;
    
    return item;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@)", self.title, self.number];
}

#pragma mark - NSCopying
#pragma mark -

- (id)copyWithZone:(NSZone *)zone {
    CopyableItem *copy = [[CopyableItem allocWithZone:zone] init];
    copy.title = self.title.copy;
    copy.number = self.number.copy;

    return copy;
}

@end
