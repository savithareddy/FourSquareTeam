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
//    UILabel *venuePhone;
//    UILabel *venueDistance;
    UILabel *rating;
    UILabel *open;
//    NSArray *latLong;
//    CLLocation *currentLocation;
//    CLLocation *eventLocation;
    UIImageView *venueImage1;
    NSNumber *intOpen;
    UILabel *category;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        venueImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        venueImage.layer.cornerRadius = 27.5;
        venueImage.clipsToBounds = YES;
        [self.contentView addSubview:venueImage];
        
        venueName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 200, 15)];
        [venueName setFont:[UIFont fontWithName:@"Arial" size:15.0f]];
        venueName.textColor = [UIColor blueColor];
        [self.contentView addSubview:venueName];
        
        venuePlace = [[UILabel alloc] initWithFrame:CGRectMake(65, 27, 180, 12)];
        [venuePlace setFont:[UIFont fontWithName:@"Arial" size:9]];
//        venuePlace.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:venuePlace];
        
        category = [[UILabel alloc] initWithFrame:CGRectMake(65, 41, 180, 12)];
        [category setFont:[UIFont fontWithName:@"Arial" size:9]];
        category.textColor = [UIColor blackColor];
        //        venuePlace.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:category];

        
//        venuePhone = [[UILabel alloc] initWithFrame:CGRectMake(65, 52, 150, 10)];
//        [venuePhone setFont:[UIFont fontWithName:@"Arial" size:10]];
//        [self.contentView addSubview:venuePhone];
        
//        self.venueDistance = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 80, 50)];
//        self.venueDistance = [[UILabel alloc] initWithFrame:CGRectMake(65, 52, 150, 10)];
//        self.venueDistance.backgroundColor = [UIColor lightGrayColor];
//        self.venueDistance.layer.cornerRadius = 25;
//        self.venueDistance.clipsToBounds = YES;
//        [self.venueDistance setFont:[UIFont fontWithName:@"Arial" size:10]];
//        self.venueDistance.textColor = [UIColor orangeColor];
//        venueDistance.text = [NSString stringWithFormat:@"%d",(int)[STASingleton mainSingleton].distanceSingleton];
//       [self.contentView addSubview:self.venueDistance];
        
        rating = [[UILabel alloc] initWithFrame:CGRectMake(65, 55, 100, 10)];
        [rating setFont:[UIFont fontWithName:@"Arial" size:10]];
        rating.textColor = [UIColor orangeColor];
        [self.contentView addSubview:rating];
        
        open = [[UILabel alloc] initWithFrame:CGRectMake(170, 55, 100, 10)];
        [open setFont:[UIFont fontWithName:@"Arial" size:10]];
        open.textColor = [UIColor orangeColor];
        [self.contentView addSubview:open];

        venueImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(290, 25, 20, 20)];
        venueImage1.clipsToBounds = YES;
        venueImage1.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:venueImage1];

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:@"newNotification" object:nil];
    }
    return self;
}

//-(void) updateLocation : (NSNotification *) notify
//{
//    currentLocation = (CLLocation *)[ [notify userInfo] valueForKey:@"newLocationResult"];
////    NSLog(@"current location  in cell  is %lf,%lf",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
//
//}

-(void) setInfo:(NSDictionary *)info
{
    _info = info;
//    dispatch_async(dispatch_get_main_queue(), ^{
   
    NSURL *url = [NSURL URLWithString:info[@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    venueImage.image = image;
    if (image == nil) {
        venueImage.image = [UIImage imageNamed:@"Flickr.png"];
    }
//    });
    
    venueName.text = info[@"name"];
    venuePlace.text = info[@"place"];
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:1];
    [format setMinimumFractionDigits:1];
    NSString *ratingString = [NSString stringWithFormat:@"Rating : %@ /10",[format stringFromNumber:info[@"rating"]]];
    rating.text = ratingString ;
    
    intOpen =  info[@"hoursOpen"];
//    NSLog(@" int %@",intOpen);
    open.text = [NSString stringWithFormat:@"Now : %@",[intOpen boolValue] ? @"OPEN": @"CLOSED"];
    
    category.text = info[@"category"];
//    if ([b isEqualToString:0]) {
//        b= @"Now : CLOSED";
//    }else{
//        b=@"Now : OPEN";
//    }
//    open.text = b;
//    open.text = info[@"hoursOpen"];
//    venuePhone.text = info[@"phone"];
//   NSUInteger intDist = (int)info[@"distance"];
//    NSLog(@" distance is %d",(int)intDist);
//   venueDistance.text = [NSString stringWithFormat:@ "%d",(int) info[@"distance"]];
//    self.venueDistance.text =[ @((int)info[@"distance"]) stringValue];
//    self.venueDistance.text = [NSString stringWithFormat:@"%d",(int)[STASingleton mainSingleton].distanceSingleton];
//    CLLocationDegrees lat =  [[info objectForKey:@"latitude"] doubleValue];
//    CLLocationDegrees longi =  [[info objectForKey:@"longitude"] doubleValue];
//    eventLocation = [[CLLocation alloc] initWithLatitude:lat longitude:longi];
//    NSLog(@"event location  in cell is %lf,%lf",eventLocation.coordinate.latitude,eventLocation.coordinate.longitude);

   
   
    //        NSLog(@"distance is %lf",distance/1000);

}

//-(void)layoutSubviews
//{
//    
//    CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation]* 0.000621371;
////    NSLog(@"distance is %f",distance);
//    self.venueDistance.text = [NSString stringWithFormat:@"%.2f mi",distance];
//}

- (NSString *)boolValueString {
    // if this contains BOOL value
    return [intOpen boolValue] ? @"YES" : @"NO";
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
