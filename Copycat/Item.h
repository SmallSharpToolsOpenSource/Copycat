//
//  Item.h
//  Copycat
//
//  Created by Brennan Stehling on 7/29/15.
//  Copyright (c) 2015 Brennan Stehling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *number;

+ (instancetype)itemWithTitle:(NSString *)title number:(NSString *)number;

@end
