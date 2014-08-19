//
//  FSAMapVC.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#define SCREEN_HEIGHT [UIScreen mainScreen] .bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen] .bounds.size.width

#import "FSAMapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FSAAnnotation.h"
#import "TAPFourSquareRequests.h"
#import "STASingleton.h"
#import "FSATVCell.h"

@interface FSAMapVC () <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic) MKMapView *mapView;
@end

@implementation FSAMapVC
{
    CLLocationManager *lManager;
    FSAAnnotation *annoteFile;
    CLLocation *currentLocation;
    NSMutableArray *distanceArray;
    CLLocation *eventLocation;
    FSATVCell *cell;
    CLPlacemark *placemarkMany;
    CLLocationDistance distance;
 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        [lManager startUpdatingLocation];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(goToTable)];
        self.navigationItem.leftBarButtonItem = back;
        
        
//        NSLog(@"distance Array is %@",[TAPFourSquareRequests getPhotosWithVenues]);
        
        NSInteger tagPlace = [STASingleton mainSingleton].buttonTag;
        if (tagPlace == 1) {
            distanceArray = [TAPFourSquareRequests getPhotosWithVenues];
        }else if (tagPlace == 2){
            distanceArray = [TAPFourSquareRequests getPhotosWithVenuesNewYork];
        }else if (tagPlace == 3){
            distanceArray = [TAPFourSquareRequests getPhotosWithVenuesLosAngeles];
        }else if (tagPlace == 4){
            distanceArray = [TAPFourSquareRequests getPhotosWithVenuesBangalore];
        } else if (tagPlace == 5){
            distanceArray = [TAPFourSquareRequests getPhotosWithVenuesChicago];
        } else if (tagPlace == 6){
            distanceArray = [TAPFourSquareRequests getPhotosWithVenuesDallas];
        }

        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

   currentLocation = [locations firstObject];
    
     [lManager stopUpdatingLocation];
    
//    CLLocationCoordinate2D coord;
//    coord.latitude = latitude.floatValue;
//    coord.longitude = longitude.floatValue;
//    eventLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
  
//        MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(1.0, 1.0));
//        [mapView setRegion:region animated:YES];

    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currentLocation.coordinate;
    [self.mapView addAnnotation:point];
    
    
    
    MKPointAnnotation *pointMany = [[MKPointAnnotation alloc] init];
    pointMany.coordinate = eventLocation.coordinate;
    NSInteger rowSelected = [STASingleton mainSingleton].index;
    NSLog(@" name is %@",[distanceArray[rowSelected] valueForKey:@"name"]);
    [pointMany setTitle: [NSString stringWithString:[distanceArray[rowSelected] valueForKey:@"name"] ]];
        [self.mapView addAnnotation:pointMany];
    
    
//    MKCoordinateRegion region2 = MKCoordinateRegionMake(eventLocation.coordinate, MKCoordinateSpanMake(10.0, 10.0));
//    [self.mapView setRegion:region2 animated:YES];
    
    NSArray *annotationArray = [NSArray arrayWithObjects:point,pointMany, nil];
    [self.mapView showAnnotations:annotationArray animated:YES];

    
//        CLGeocoder *coder = [[CLGeocoder alloc] init];
//        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            CLPlacemark *placemark = [placemarks firstObject];
////            UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@",placemark.addressDictionary[@"Image"]]];
//            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
//            [point setTitle :cityState];
//        }];
    CLGeocoder *coderMany = [[CLGeocoder alloc] init];
    [coderMany reverseGeocodeLocation:eventLocation completionHandler:^(NSArray *placemarks, NSError *error) {
         NSLog(@" placemark array is %@",placemarks);
        placemarkMany = [placemarks lastObject];
       
//        NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemarkMany.addressDictionary[@"City"],placemarkMany.addressDictionary[@"State"]];
//        [pointMany setTitle :cityState];
        }];

    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:eventLocation.coordinate addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    directionRequest.source = source;
    directionRequest.destination = destination;
    directionRequest.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        [self calculateDistance:response];
                [self showRoute:response];
        
    }];
    
}



-(void) calculateDistance : (MKDirectionsResponse *) response
{
    MKRoute *route = response.routes[0];
    distance = (route.distance)  * 0.000621371;
    [STASingleton mainSingleton].distance = distance;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
//    footer.backgroundColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.6 alpha:0.2];
    [self.view addSubview:footer];
    
    UILabel *distanceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 160, 30)];
    distanceLabel1.text = @"Distance from current location :";
    distanceLabel1.font = [UIFont fontWithName:@"Arial" size:11];
    distanceLabel1.textColor = [UIColor blueColor];
    [footer addSubview:distanceLabel1];
    
    UILabel *distanceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 60, 30)];
    distanceLabel2.text = [NSString stringWithFormat:@"%.2f",distance];
    distanceLabel2.font = [UIFont fontWithName:@"Arial" size:11];
    distanceLabel2.textColor = [UIColor blueColor];
    [footer addSubview:distanceLabel2];
    
    UILabel *distanceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 30, 30)];
    distanceLabel3.text = @"  mi";
    distanceLabel3.font = [UIFont fontWithName:@"Arial" size:11];
    distanceLabel3.textColor = [UIColor blueColor];
    [footer addSubview:distanceLabel3];
}

-(void) showRoute : (MKDirectionsResponse *) response
{
    for (MKRoute *route in response.routes) {
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
          }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
   if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor blueColor];
//        routeRenderer.lineWidth = 5.0;
        return routeRenderer;
    }
   else return nil;
}


//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
//{
//    if([annotation isKindOfClass:[MKUserLocation class]])
//            return nil;
//
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//    MKAnnotationView * pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//    if (!pinView)
//    {
//       pinView= [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
//        pinView.canShowCallout = YES;
//        pinView.animatesDrop = YES;
//        pinView.image = [UIImage imageNamed:@"FlickrSmall"];
////        UIImage *image = [UIImage imageNamed:@"FlickrSmall"];
////        CGRect resizeRect;
////        resizeRect.size.width = 20;
////        resizeRect.size.height = 30;
////        resizeRect.origin = (CGPoint) {0.0f,0.0f};
////        UIGraphicsBeginImageContext(resizeRect.size);
////        [image drawInRect:resizeRect];
//        
////        NSLog(@"pinView.frame.size = %@, pinView.image.size = %@",
////              NSStringFromCGSize(pinView.frame.size),
////              NSStringFromCGSize(pinView.image.size));
////        pinView.image.size.width = 32;
////        pinView.frame.size = NSStringFromCGSize(CGSizeMake(32, 39));
//        pinView.calloutOffset = CGPointMake(0, 32);
////        pinView.pinColor = MKPinAnnotationColorPurple;
////        pinView.animatesDrop = YES;
//       }else {
//        pinView.annotation = annotation;
//    }
//        return pinView;
////    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    }
//    return nil;
//}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//        {


    MKPinAnnotationView *annoteView= (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annote"];
    if (annoteView == nil) {
        annoteView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annote"];
        annoteView.pinColor = MKPinAnnotationColorPurple;
        annoteView.animatesDrop = YES;
//        annoteView.image = [UIImage imageNamed:@"pin"];

        annoteView.canShowCallout=YES;
        NSInteger rowSelected = [STASingleton mainSingleton].index;
        NSURL *url = [NSURL URLWithString:[distanceArray[rowSelected] valueForKey:@"image"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@" distance array is %@",distanceArray);
//        NSLog(@"row selected is %d",(int)rowSelected);
//        UIImage *image = [UIImage imageNamed:[distanceArray[rowSelected] valueForKey:@"image"]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode  = UIViewContentModeScaleAspectFill;
      imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0, 0, 25, 25);
//        NSLog(@" image is %@",[distanceArray[rowSelected] valueForKey:@"image"]);
        annoteView.leftCalloutAccessoryView = imageView;
        
//        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        UIButton *rightButton = [[UIButton alloc]init];
        rightButton.frame =  CGRectMake(0, 0, 25, 25);
        UIImage *btnImage = [UIImage imageNamed:@"arrow.png"];
        [rightButton setBackgroundImage:btnImage forState:UIControlStateNormal];
        [rightButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//        annoteView.rightCalloutAccessoryView = rightButton;

//        [buttonView addSubview:rightButton];
        
        annoteView.rightCalloutAccessoryView = rightButton;
//        annoteView.calloutOffset = CGPointMake(0, 0);
    }else{
       annoteView.annotation = annotation;
//        
//        
    }
//    
//    
////    NSLog(@" image  string is %@",[distanceArray valueForKey:@"image"]);
////    NSURL *url = [NSURL URLWithString:[distanceArray valueForKey:@"image"]];
////    NSData *data = [NSData dataWithContentsOfURL:url];
////    UIImage *image = [UIImage imageWithData:data];
////    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
////    annoteView.leftCalloutAccessoryView = imgView;
             return annoteView;
//        }
//    return nil;
}
    
    
//- (void)mapView:(MKMapView *)mapView
//didAddAnnotationViews:(NSArray *)annotationViews
//{
//    for (MKAnnotationView *annView in annotationViews)
//    {
//        CGRect endFrame = annView.frame;
//        annView.frame = CGRectOffset(endFrame, 0, -500);
//        [UIView animateWithDuration:0.5
//                         animations:^{ annView.frame = endFrame; }];
//    }
//}


-(void) goToTable
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    self.mapView.delegate= self;
    self.mapView.showsUserLocation = YES;

    self.mapView.userTrackingMode = YES;
//    [self.mapView setCenterCoordinate:currentLocation.coordinate animated:YES];
    [self.view addSubview:self.mapView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    [mapView addGestureRecognizer:tap];
    
    NSInteger rowSelected = [STASingleton mainSingleton].index;
     double latitude = [[distanceArray[rowSelected] valueForKey:@"latitude"] doubleValue];
    double longitude =[[distanceArray[rowSelected] valueForKey:@"longitude"]doubleValue];
    eventLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
 
}




//-(void) foundTap:(UITapGestureRecognizer *) tap
//{
//    CGPoint point = [tap locationInView:mapView];
//    CLLocationCoordinate2D tapPoint = [mapView convertPoint:point toCoordinateFromView:self.view];
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
