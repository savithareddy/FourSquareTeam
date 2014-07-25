//
//  STASingleton.m
//  STATUS1
//
//  Created by Savitha Reddy on 5/19/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "STASingleton.h"

@implementation STASingleton

+(STASingleton *) mainSingleton
{
    static dispatch_once_t create;
    static STASingleton  *singleton = nil;
    dispatch_once(&create, ^{
        singleton = [[STASingleton alloc] init];
    });
    return singleton;
}

@end
