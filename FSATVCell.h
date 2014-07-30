//
//  FSATVCell.h
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//@protocol FSATVCellDelegate;

@interface FSATVCell : UITableViewCell <CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic) NSDictionary *info;

//@property (nonatomic,assign) id<FSATVCellDelegate> delegate;

@property (nonatomic) UILabel *venueDistance;


@end
