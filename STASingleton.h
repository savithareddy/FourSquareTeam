//
//  STASingleton.h
//  STATUS1
//
//  Created by Savitha Reddy on 5/19/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface STASingleton : NSObject

+ (STASingleton *) mainSingleton;

@property (nonatomic) NSInteger index;
//@property (nonatomic) NSInteger colorRed;
//@property (nonatomic) NSInteger detailColor;

@property (nonatomic) CLLocationDistance distance;



@end
