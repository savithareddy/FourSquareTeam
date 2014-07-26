//
//  STASingleton.h
//  STATUS1
//
//  Created by Savitha Reddy on 5/19/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STASingleton : NSObject

+ (STASingleton *) mainSingleton;

@property (nonatomic) NSInteger distanceSingleton;
//@property (nonatomic) NSInteger colorRed;
//@property (nonatomic) NSInteger detailColor;



@end
