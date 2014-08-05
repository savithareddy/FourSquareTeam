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


@interface FSATableVC () <CLLocationManagerDelegate,MKMapViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation FSATableVC
{
    NSArray *itemsInfo;
    NSMutableArray *searchResults;
    CLLocationManager *lmanager;
    NSArray *sortedArray;
    UIBarButtonItem *searchItem;
    BOOL isSelected;
    UISearchBar *searchBar;
    UILabel *headerTitle;
    UISearchDisplayController *searchDisplay;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
//        self.tableView.backgroundColor = [UIColor greenColor];
        self.tableView.rowHeight = 70;
//       [ self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 8)];
//        self.tableView.separatorColor = [UIColor blueColor];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        
        self.navigationController.navigationBarHidden = NO;
        headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 50, 30)];
        [headerTitle setText:@"VenFo"];
        [headerTitle setTextColor:[UIColor orangeColor]];
        [headerTitle setFont:[UIFont fontWithName:@"Chalkduster" size:25]];
        self.navigationItem.titleView = headerTitle;
        
        
//        UIBarButtonItem *sortIcon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortList)];
//        self.navigationItem.rightBarButtonItem = sortIcon;
        NSInteger tagPlace = [STASingleton mainSingleton].buttonTag;
        if (tagPlace == 1) {
        itemsInfo = [TAPFourSquareRequests getPhotosWithVenues];
        }else if (tagPlace == 2){
            itemsInfo = [TAPFourSquareRequests getPhotosWithVenuesNewYork];
        }else if (tagPlace == 3){
            itemsInfo = [TAPFourSquareRequests getPhotosWithVenuesLosAngeles];
        }else if (tagPlace == 4){
            itemsInfo = [TAPFourSquareRequests getPhotosWithVenuesBangalore];
        } else if (tagPlace == 5){
            itemsInfo = [TAPFourSquareRequests getPhotosWithVenuesChicago];
        } else if (tagPlace == 6){
            itemsInfo = [TAPFourSquareRequests getPhotosWithVenuesDallas];
        }
    
            
        
        searchResults = [NSMutableArray arrayWithCapacity:[itemsInfo count]];
        
//        NSLog(@" All distances array is %f", [STASingleton mainSingleton].distance);
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        NSArray *sortArray = [NSArray arrayWithObject:sortDescriptor];
        sortedArray = [itemsInfo sortedArrayUsingDescriptors:sortArray];
//        NSLog(@"Sorted array is %@",sortedArray);
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
        
//        MKRoute *route = response.routes[0];
//        distance = (route.distance)  * 0.000621371;
//        NSLog(@"distance is %f",distance);
//        [STASingleton mainSingleton].distance = distance;

//        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        
//        searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButton)];
//        searchItem.style = (searchItem.style == UIBarButtonItemStyleBordered) ? UIBarButtonItemStyleDone : UIBarButtonItemStyleBordered;
//        isSelected = (searchItem.style == UIBarButtonItemStyleDone);
//        self.navigationItem.rightBarButtonItem = searchItem;
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(goToVC)];
        self.navigationItem.leftBarButtonItem = back;

     }
    return self;
}

-(void) goToVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) searchButton
{
 }

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [searchResults removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [NSMutableArray arrayWithArray:[itemsInfo filteredArrayUsingPredicate:resultPredicate]];
    NSLog(@"search results array has %@",searchResults);
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[searchDisplay.searchBar scopeButtonTitles]
                                      objectAtIndex:[searchDisplay.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
//    // Tells the table data source to reload when scope bar selection changes
//    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
//     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
//    // Return YES to cause the search result table view to be reloaded.
//    return YES;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
//    [NSThread detachNewThreadSelector:@selector(fetch) toTarget:self withObject:nil];
    lmanager = [[CLLocationManager alloc] init];
    lmanager.delegate =self;
    
    lmanager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
//    lmanager.distanceFilter = kCLDistanceFilterNone;
    [lmanager setDistanceFilter:100];
//    NSLog(@"current location");
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    [lmanager startUpdatingLocation];
//   [lmanager startMonitoringSignificantLocationChanges];
   

//  });
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:@"newNotification" object:nil];
    //    if (searchItem.style == isSelected) {
    //    [UIView animateWithDuration:0.3 animations:^{
    //        searchBar = [[UISearchBar alloc] init];
    //        searchBar.frame =CGRectMake(0.0f, 0.0f, 280.0f, 44.0f);
    //        searchBar.backgroundColor = [UIColor redColor];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search";
    //    self.navigationItem.titleView= searchBar;
    
    searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    searchDisplay.delegate = self;
    //        searchDisplay.displaysSearchBarInNavigationBar = YES;
    searchDisplay.searchResultsDataSource = self;
    searchDisplay.searchResultsDelegate = self;
    searchDisplay.searchResultsTableView.rowHeight = 70;
    //        self.tableView.delegate = self;
    //        self.tableView.dataSource = self;
    //        [self.tableView reloadData];
    
    [self.tableView setTableHeaderView:searchDisplay.searchBar];
    
    
    //                    }];
    //    } else{
    //        [UIView animateWithDuration:0.3 animations:^{
    
    //        self.navigationItem.titleView= headerTitle;
    //        }];
    //    }

    }

-(void) createSearchBar
{
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currentLocation = [locations lastObject];
//    NSLog(@"current location is %lf,%lf",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
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
    if (tableView == searchDisplay.searchResultsTableView) {
//        NSLog(@"searched items count is %d",(int)[searchResults count]);
        return [searchResults count];
        
    } else {
    return [sortedArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSATVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
    {
        cell = [[FSATVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    NSLog(@"array is %@",itemsInfo[indexPath.row]);
    
    if (tableView == searchDisplay.searchResultsTableView) {
//            NSLog(@"searched array is %@",searchResults[indexPath.row]);
//        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.info = searchResults[indexPath.row];
    } else {

    cell.info = sortedArray[indexPath.row];
    }
    
//    double lati = [itemsInfo objectAtIndex:<#(NSUInteger)#>
    
    return cell;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    static NSString *cellIdentifierSearch = @"SearchCell";
    UINib *nib = [UINib nibWithNibName:@"TableViewCellSearch" bundle:nil];
    [searchDisplay.searchResultsTableView registerNib:nib forCellReuseIdentifier:cellIdentifierSearch];
    searchDisplay.searchResultsTableView.rowHeight = 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@" %d row selected",(int)indexPath.row);
//    if (self.searchDisplayController.active) {
//        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//        cell.info = [searchResults objectAtIndex:indexPath.row];
//    } else {
//        indexPath = [self.tableView indexPathForSelectedRow];
//        recipe = [recipes objectAtIndex:indexPath.row];
//    }
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
