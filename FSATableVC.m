//
//  FSATableVC.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSATableVC.h"
#import "FSATVCell.h"
#import "FSAMapVC.h"
#import "TAPFourSquareRequests.h"
#import <CoreLocation/CoreLocation.h>
#import "STASingleton.h"
#import <MapKit/MapKit.h>


@interface FSATableVC () <CLLocationManagerDelegate,MKMapViewDelegate>

@end

@implementation FSATableVC
{
    NSArray *itemsInfo;
    CLLocationManager *lmanager;
    NSArray *sortedArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
//        self.tableView.backgroundColor = [UIColor greenColor];
        self.tableView.rowHeight = 70;
        self.navigationController.navigationBarHidden = NO;
        UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 50, 30)];
        [headerTitle setText:@"VenFo"];
        [headerTitle setFont:[UIFont fontWithName:@"Chalkduster" size:25]];
        self.navigationItem.titleView = headerTitle;
        
//        UIBarButtonItem *sortIcon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortList)];
//        self.navigationItem.rightBarButtonItem = sortIcon;
        
        itemsInfo = [TAPFourSquareRequests getPhotosWithVenues];
        NSLog(@" All distances array is %f", [STASingleton mainSingleton].distance);
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        NSArray *sortArray = [NSArray arrayWithObject:sortDescriptor];
        sortedArray = [itemsInfo sortedArrayUsingDescriptors:sortArray];
        NSLog(@"Sorted array is %@",sortedArray);
//        NSLog(@"TableVc items are %@",itemsInfo);
//        itemsInfo = [@[@{@"image":[UIImage imageNamed:@"venue.jpeg"],
//                         @"name":@"HollyWood",
//                         @"phone":@"111-222-3456",
//                         @"timing":@"8:00 AM to 6:00 PM",
//                         @"distance":@"0.9 mi" },
//                       @{@"image":[UIImage imageNamed:@"venue.jpeg"],
//                        @"name":@"HollyWood",
//                        @"phone":@"111-222-3456",
//                        @"timing":@"8:00 AM to 6:00 PM",
//                        @"distance":@"0.9 mi" },
//                       @{@"image":[UIImage imageNamed:@"venue.jpeg"],
//                        @"name":@"HollyWood",
//                        @"phone":@"111-222-3456",
//                        @"timing":@"8:00 AM to 6:00 PM",
//                        @"distance":@"0.9 mi" },
//                       @{@"image":[UIImage imageNamed:@"venue.jpeg"],
//                        @"name":@"HollyWood",
//                        @"phone":@"111-222-3456",
//                        @"timing":@"8:00 AM to 6:00 PM",
//                        @"distance":@"0.9 mi" },
//                       @{@"image":[UIImage imageNamed:@"venue.jpeg"],
//                        @"name":@"HollyWood",
//                        @"phone":@"111-222-3456",
//                        @"timing":@"8:00 AM to 6:00 PM",
//                        @"distance":@"0.9 mi" }
//                        ]mutableCopy];
        
        MKRoute *route = response.routes[0];
        distance = (route.distance)  * 0.000621371;
        NSLog(@"distance is %f",distance);
        [STASingleton mainSingleton].distance = distance;

        
    }
    return self;
}

-(void) sortList
{
   }

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [NSThread detachNewThreadSelector:@selector(fetch) toTarget:self withObject:nil];
    lmanager = [[CLLocationManager alloc] init];
    lmanager.delegate =self;
    
    lmanager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
//    lmanager.distanceFilter = kCLDistanceFilterNone;
    [lmanager setDistanceFilter:100];
    NSLog(@"current location");
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    [lmanager startUpdatingLocation];
//   [lmanager startMonitoringSignificantLocationChanges];
   

//  });
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:@"newNotification" object:nil];
    
    
}

-(void) fetch
{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"current location is %lf,%lf",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newNotification" object:self userInfo:[NSDictionary dictionaryWithObject:currentLocation forKey:@"newLocationResult"]];

    [lmanager stopUpdatingLocation];
    }

//-(void) updateLocation : (NSNotification *) notify
//{
//    CLLocation *currentLocation = (CLLocation *)[ [notify userInfo] valueForKey:@"newLocationResult"];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"items count is %d",(int)[itemsInfo count]);
    return [sortedArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSATVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[FSATVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    NSLog(@"array is %@",itemsInfo[indexPath.row]);
    

    cell.info = sortedArray[indexPath.row];
    
//    double lati = [itemsInfo objectAtIndex:<#(NSUInteger)#>
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@" %d row selected",(int)indexPath.row);
    [STASingleton mainSingleton].index = indexPath.row;
    FSAMapVC *map = [[FSAMapVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:map animated:YES];
}






















/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
