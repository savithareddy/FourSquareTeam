//
//  FSATVCell.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSATVCell.h"
#import "STASingleton.h"
#import "TAPFourSquareRequests.h"



@implementation FSATVCell 
{
    UIImageView *venueImage;
    UILabel *venueName;
    UILabel *venuePlace;
    UILabel *venuePhone;
//    UILabel *venueDistance;
    NSArray *latLong;
    CLLocation *currentLocation;
    CLLocation *eventLocation;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        venueImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        venueImage.layer.cornerRadius = 25;
        venueImage.clipsToBounds = YES;
        [self.contentView addSubview:venueImage];
        
        venueName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 200, 15)];
        [venueName setFont:[UIFont fontWithName:@"Arial" size:15.0f]];
        venueName.textColor = [UIColor blueColor];
        [self.contentView addSubview:venueName];
        
        venuePlace = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 180, 12)];
        [venuePlace setFont:[UIFont fontWithName:@"Arial" size:8.0f]];
//        venuePlace.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:venuePlace];
        
        venuePhone = [[UILabel alloc] initWithFrame:CGRectMake(65, 52, 150, 10)];
        [venuePhone setFont:[UIFont fontWithName:@"Arial" size:10]];
//        [self.contentView addSubview:venuePhone];
        
        self.venueDistance = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 80, 50)];
//        self.venueDistance.backgroundColor = [UIColor lightGrayColor];
//        self.venueDistance.layer.cornerRadius = 25;
//        self.venueDistance.clipsToBounds = YES;
        [self.venueDistance setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.venueDistance.textColor = [UIColor blueColor];
//        NSLog(@"Singleton distance is %d",(int)[STASingleton mainSingleton].distanceSingleton);
//        venueDistance.text = [NSString stringWithFormat:@"%d",(int)[STASingleton mainSingleton].distanceSingleton];
       [self.contentView addSubview:self.venueDistance];
        
//        latLong = [TAPFourSquareRequests getPhotosWithVenues];
//        NSNumber *lat = [latLong valueForKey:@"latitude"];
//         NSNumber *longi = [latLong valueForKey:@"longitude"];
//        NSLog(@"latLong are %lf,%lf",lat,longi);
//
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:@"newNotification" object:nil];
//        CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation];
//        NSLog(@"distance is %lf",distance/1000);
    }
    return self;
}
-(void) updateLocation : (NSNotification *) notify
{
    
    currentLocation = (CLLocation *)[ [notify userInfo] valueForKey:@"newLocationResult"];
    
    NSLog(@"current location  in cell  is %lf,%lf",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);

}

-(void) setInfo:(NSDictionary *)info
{
    _info = info;
    NSURL *url = [NSURL URLWithString:info[@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    venueImage.image = image;
    venueName.text = info[@"name"];
    venuePlace.text = info[@"place"];
//    venuePhone.text = info[@"phone"];
//   NSUInteger intDist = (int)info[@"distance"];
//    NSLog(@" distance is %d",(int)intDist);
//   venueDistance.text = [NSString stringWithFormat:@ "%d",(int) info[@"distance"]];
//    self.venueDistance.text =[ @((int)info[@"distance"]) stringValue];
//    self.venueDistance.text = [NSString stringWithFormat:@"%d",(int)[STASingleton mainSingleton].distanceSingleton];
    CLLocationDegrees lat =  [[info objectForKey:@"latitude"] doubleValue];
    CLLocationDegrees longi =  [[info objectForKey:@"longitude"] doubleValue];
    eventLocation = [[CLLocation alloc] initWithLatitude:lat longitude:longi];
    NSLog(@"event location  in cell is %lf,%lf",eventLocation.coordinate.latitude,eventLocation.coordinate.longitude);

   
   
    //        NSLog(@"distance is %lf",distance/1000);

}

-(void)layoutSubviews
{
    
    CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation]* 0.000621371;
    NSLog(@"distance is %f",distance);
    self.venueDistance.text = [NSString stringWithFormat:@"%.2f mi",distance];
}


- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
