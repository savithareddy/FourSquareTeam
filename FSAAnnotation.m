//
//  FSAAnnotation.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSAAnnotation.h"

@implementation FSAAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self=[super init];
    if (self) {
        _coordinate=coordinate;
    }
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
   _coordinate = newCoordinate;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
}

-(void) setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
}
@end
