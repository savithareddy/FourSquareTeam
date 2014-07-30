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

@end

@implementation FSAMapVC
{
    CLLocationManager *lManager;
    MKMapView *mapView;
    FSAAnnotation *annotation;
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
        distanceArray = [TAPFourSquareRequests getPhotosWithVenues];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    [mapView removeAnnotations:mapView.annotations];
   currentLocation = [locations firstObject];
    
    
    
//    CLLocationCoordinate2D coord;
//    coord.latitude = latitude.floatValue;
//    coord.latitude = 40;
//    coord.longitude = -77;
//    coord.longitude = longitude.floatValue;
//    eventLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
//    NSLog(@"event location coordinates are %d",eventLocation.coordinate);
   [lManager stopUpdatingLocation];
//    for (CLLocation *location in locations) {
//       annotation = [[FSAAnnotation alloc] initWithCoordinate:currentLocation.coordinate];
//        annotation.title = @"Marker";
//        annotation.subtitle = @"City";
//        [mapView addAnnotation:annotation];
//
//        MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(1.0, 1.0));
//        [mapView setRegion:region animated:YES];
//
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currentLocation.coordinate;
    [mapView addAnnotation:point];
    
//    MKCoordinateRegion region2 = MKCoordinateRegionMake(eventLocation.coord, MKCoordinateSpanMake(1.0, 1.0));
//    [mapView setRegion:region2 animated:YES];
    
    MKPointAnnotation *pointMany = [[MKPointAnnotation alloc] init];
    pointMany.coordinate = eventLocation.coordinate;
    [mapView addAnnotation:pointMany];
    
    NSArray *annotationArray = [NSArray arrayWithObjects:point,pointMany, nil];
    [mapView showAnnotations:annotationArray animated:YES];

    
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark = [placemarks firstObject];
           
//            NSLog(@"current location detected");
//            NSLog(@"placemark is %@",placemark);
            
//            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
//            NSLog(@"city is %@",placemark.addressDictionary[@"City"]);
//            NSLog(@"state is %@",placemark.addressDictionary[@"State"]);
//            [point setTitle :placemark.addressDictionary[@"City"]];
            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
            [point setTitle :cityState];
//            [point setSubtitle :placemark.addressDictionary[@"State"]];
//            }
        }];
    CLGeocoder *coderMany = [[CLGeocoder alloc] init];
    [coderMany reverseGeocodeLocation:eventLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        placemarkMany = [placemarks lastObject];
//        NSLog(@"current location detected");
//        NSLog(@"placemark is %@",placemark);
        
        //            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
//        NSLog(@"city is %@",placemark.addressDictionary[@"City"]);
//        NSLog(@"state is %@",placemark.addressDictionary[@"State"]);
        //            [point setTitle :placemark.addressDictionary[@"City"]];
        NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemarkMany.addressDictionary[@"City"],placemarkMany.addressDictionary[@"State"]];
        [pointMany setTitle :cityState];
      
        //            [point setSubtitle :placemark.addressDictionary[@"State"]];
        //            }
    }];

    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:eventLocation.coordinate addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    directionRequest.source = source;
    directionRequest.destination = destination;
    directionRequest.transportType = MKDirectionsTransportTypeAutomobile;
//    CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation]* 0.000621371;
//    NSLog(@"distance is %f",distance);
    
//    self.venueDistance.text = [NSString stringWithFormat:@"%.2f mi",distance];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
//        [self calculateDistance:response];
                [self showRoute:response];
        
    }];
    
    
    
    
//    CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation];
////    NSLog(@"distance is %lf",distance/1000);
////    cell.venueDistance.text = [NSString stringWithFormat:@"%d" ,(int)distance/1000000];
////    [STASingleton mainSingleton].distanceSingleton = distance/100000;
//    
//    MKMapPoint pointOne = MKMapPointForCoordinate(currentLocation.coordinate);
//    MKMapPoint pointTwo = MKMapPointForCoordinate(eventLocation.coordinate);
//    
//    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D) * 2);
//    pointArray[0] = pointOne;
//    pointArray[1] = pointTwo;
////    NSLog(@"Array is %lf", pointArray);
//    
//    MKPolyline *routeLine = [MKPolyline polylineWithPoints:pointArray count:2];
//    [mapView addOverlay:routeLine];
    
//    }
}

-(void) calculateDistance : (MKDirectionsResponse *) response
{
    MKRoute *route = response.routes[0];
    distance = (route.distance)  * 0.000621371;
    NSLog(@"distance is %f",distance);
    [STASingleton mainSingleton].distance = distance;
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
//    footer.backgroundColor = [UIColor blueColor];
    footer.backgroundColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.6 alpha:0.2];
    [self.view addSubview:footer];
    
    UILabel *distanceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 100, 30)];
    distanceLabel1.text = @"Travel Distance is :";
    distanceLabel1.font = [UIFont fontWithName:@"Arial" size:10];
    [footer addSubview:distanceLabel1];
    
    UILabel *distanceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 60, 30)];
    distanceLabel2.text = [NSString stringWithFormat:@"%.2f",distance];
    distanceLabel2.font = [UIFont fontWithName:@"Arial" size:10];
    [footer addSubview:distanceLabel2];
    
    UILabel *distanceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 30, 30)];
    distanceLabel3.text = @"  mi";
    distanceLabel3.font = [UIFont fontWithName:@"Arial" size:10];
    [footer addSubview:distanceLabel3];

}

-(void) showRoute : (MKDirectionsResponse *) response
{
//   [mapView removeOverlays:mapView.overlays];
    for (MKRoute *route in response.routes) {
//        MKRoute *route = response.routes.lastObject;
        [mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
//        [mapView insertOverlay:route.polyline atIndex:0 level:MKOverlayLevelAboveRoads];
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


//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
//    //7
////    if([annotation isKindOfClass:[MKUserLocation class]])
////        return nil;
////    
////    //8
////    static NSString *identifier = @"myAnnotation";
//    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annote"];
//    if (!annotationView)
//    {
//        //9
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annote"];
//        annotationView.pinColor = MKPinAnnotationColorPurple;
//        annotationView.animatesDrop = YES;
//        annotationView.canShowCallout = YES;
//    }else {
//        annotationView.annotation = annotation;
//    }
//    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    return annotationView;
//}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annoteView= (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annote"];
    if (annoteView == nil) {
        annoteView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annote"];
    }else{
        annoteView.annotation = annotation;
    }
    annoteView.canShowCallout=YES;
    return annoteView;
}


-(void) goToTable
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40)];
    mapView.delegate= self;
    [self.view addSubview:mapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [mapView addGestureRecognizer:tap];
    
    NSInteger rowSelected = [STASingleton mainSingleton].index;
    NSLog(@"row selected from tableVC is %d",(int)rowSelected);
     double latitude = [[distanceArray[rowSelected] valueForKey:@"latitude"] doubleValue];
    double longitude =[[distanceArray[rowSelected] valueForKey:@"longitude"]doubleValue];
    NSLog(@"lat and long are %f,%f",latitude,longitude);
    eventLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    
    
}

-(void)viewWillLayoutSubviews
{
   
    
}



-(void) foundTap:(UITapGestureRecognizer *) tap
{
    CGPoint point = [tap locationInView:mapView];
    CLLocationCoordinate2D tapPoint = [mapView convertPoint:point toCoordinateFromView:self.view];
//    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
//    point1.coordinate = tapPoint;
//    [mapView addAnnotation:point1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
