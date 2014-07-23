//
//  FSAAnnotation.h
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FSAAnnotation : NSObject <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic,readonly,copy) NSString *title;

@property (nonatomic,readonly,copy) NSString *subtitle;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate;

-(void) setTitle:(NSString *)title;

-(void) setSubtitle:(NSString *)subtitle;


@end
