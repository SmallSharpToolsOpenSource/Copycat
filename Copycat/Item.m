//
//  Item.m
//  Copycat
//
//  Created by Brennan Stehling on 7/29/15.
//  Copyright (c) 2015 Brennan Stehling. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (instancetype)itemWithTitle:(NSString *)title number:(NSString *)number {
    Item *item = [[Item alloc] init];
    item.title = title.copy;
    item.number = number.copy;
    
    return item;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@)", self.title, self.number];
}

@end
