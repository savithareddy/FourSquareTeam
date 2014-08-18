//
//  TAPFourSquareRequests.h
//  Time and Place
//
//  Created by Savitha Reddy on 6/7/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAPFourSquareRequests : NSObject

+(NSMutableArray *)getPhotosWithVenues;

+(NSMutableArray *)getPhotosWithVenuesNewYork;

+(NSMutableArray *)getPhotosWithVenuesLosAngeles;

+(NSMutableArray *)getPhotosWithVenuesBangalore;

+(NSMutableArray *)getPhotosWithVenuesChicago;

+(NSMutableArray *)getPhotosWithVenuesDallas;

//@property (nonatomic) NSData *data;

static inline NSString* NSStringFromBOOL(BOOL aBool) {
    return aBool? @"OPEN" : @"CLOSED"; }

@end
