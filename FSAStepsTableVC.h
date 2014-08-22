//
//  FSAStepsTableVC.h
//  FourSquareApp
//
//  Created by Savitha Reddy on 8/20/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FSAStepsTableVC : UITableViewController

@property (nonatomic) MKRoute *tableRoute;

@property (nonatomic) MKRouteStep *routeSteps;

@property (nonatomic) NSString *tableString;

@property (nonatomic) NSMutableArray *mapTableArray;

@property (nonatomic) NSMutableArray *mapTableDistanceArray;

@end
