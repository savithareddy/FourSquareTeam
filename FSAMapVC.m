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

@interface FSAMapVC () <MKMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation FSAMapVC
{
    CLLocationManager *lManager;
    MKMapView *mapView;
    FSAAnnotation *annotation;
    CLLocation *currentLocation;
    
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
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    [mapView removeAnnotations:mapView.annotations];
    currentLocation = [locations firstObject];
   [lManager stopUpdatingLocation];
//    for (CLLocation *location in locations) {
//       annotation = [[FSAAnnotation alloc] initWithCoordinate:currentLocation.coordinate];
//        annotation.title = @"Marker";
//        annotation.subtitle = @"City";
//        [mapView addAnnotation:annotation];
//
        MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(1.0, 1.0));
        [mapView setRegion:region animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currentLocation.coordinate;
    
    [mapView addAnnotation:point];

    
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSLog(@"current location detected");
            NSLog(@"placemark is %@",placemark);
            
            NSString *cityState = [NSString stringWithFormat:@"%@,%@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
            NSLog(@"city is %@",placemark.addressDictionary[@"City"]);
            NSLog(@"state is %@",placemark.addressDictionary[@"State"]);
            [point setTitle :placemark.addressDictionary[@"City"]];
            [point setSubtitle :placemark.addressDictionary[@"State"]];
//            }
        }];
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
