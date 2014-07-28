//
//  FSAMapVC.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

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
        CLPlacemark *placemark = [placemarks firstObject];
//        NSLog(@"current location detected");
//        NSLog(@"placemark is %@",placemark);
        
        //            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
//        NSLog(@"city is %@",placemark.addressDictionary[@"City"]);
//        NSLog(@"state is %@",placemark.addressDictionary[@"State"]);
        //            [point setTitle :placemark.addressDictionary[@"City"]];
        NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
        [pointMany setTitle :cityState];
      
        //            [point setSubtitle :placemark.addressDictionary[@"State"]];
        //            }
    }];

    
    
    CLLocationDistance distance = [currentLocation distanceFromLocation:eventLocation];
//    NSLog(@"distance is %lf",distance/1000);
//    cell.venueDistance.text = [NSString stringWithFormat:@"%d" ,(int)distance/1000000];
//    [STASingleton mainSingleton].distanceSingleton = distance/100000;
    
    MKMapPoint pointOne = MKMapPointForCoordinate(currentLocation.coordinate);
    MKMapPoint pointTwo = MKMapPointForCoordinate(eventLocation.coordinate);
    
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D) * 2);
    pointArray[0] = pointOne;
    pointArray[1] = pointTwo;
//    NSLog(@"Array is %lf", pointArray);
    
    MKPolyline *routeLine = [MKPolyline polylineWithPoints:pointArray count:2];
    [mapView addOverlay:routeLine];
    
//    }
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
//    if ([overlay isKindOfClass:[MKPolyline class]])
//    {
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
//    }
    
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
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
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
