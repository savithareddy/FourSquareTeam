//
//  TAPFourSquareRequests.m
//  Time and Place
//
//  Created by Savitha Reddy on 6/7/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

//#define ID @"40a55d80f964a52020f31ee3"
//#define ID  @"U5LGPWWMKMNBT4VZ3TCKKRHC2R3LHVTWGN3NEGJWY2M1D15P"
#import "TAPFourSquareRequests.h"

@implementation TAPFourSquareRequests

+(NSMutableArray *)getPhotosWithVenues
{
    NSMutableArray *photos = [@[] mutableCopy];
    
    NSString *locationURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?ll=40.7,-74&oauth_token=UQGRMZSKDL2DZIGQ430EW0AHPJ1S30ZEQBCOWDXRQ5AYE5KB&v=20140723"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:locationURL]];
    NSData *resonseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *fsInfo = [NSJSONSerialization JSONObjectWithData:resonseData options:0 error:nil];
//    NSLog(@"DIctionary is %@",fsInfo);
    
    for (int index = 7 ; index < 13; index ++) {
        NSString *photos1 = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"categories"] [0] [@"icon"] [@"prefix"];
        NSString *photos2 = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"categories"] [0] [@"icon"] [@"suffix"];
        NSString *dimension = @"bg_88";
        NSString *joinString=[NSString stringWithFormat:@"%@%@%@",photos1,dimension,photos2];
//        [photos addObject:joinString];
        
        NSString *name = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"name"];
        NSString *placeLat = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"location"] [@"lat"];
        NSString *placeLong = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"location"] [@"lng"];
        NSString *placeCity = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"location"] [@"city"];
        NSString *placeState= fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"location"] [@"state"];
        NSString *placeSecond =[NSString stringWithFormat:@"%@ , %@",placeCity,placeState];
        NSString *phone = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"contact"] [@"formattedPhone"];
        NSNumber *distance = fsInfo[@"response"][@"groups"][0][@"items"] [index] [@"venue"][@"location"] [@"distance"];
//       [photos addObject:name];
//        [photos addObject:place];
//        [photos addObject:phone];
//        [photos addObject:distance];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:joinString forKey:@"image"];
        [dict setObject: name forKey:@"name"];
        [dict setObject:placeSecond forKey:@"place"];
        [dict setObject:phone forKey:@"phone"];
        [dict setObject:distance forKey:@"distance"];
        [dict setObject:placeLat forKey:@"latitude"];
        [dict setObject:placeLong forKey:@"longitude"];
        [photos addObject:dict];
        NSLog(@"Dictionary is %@",dict);
        }
//    NSLog(@" photos %@",photos);
    return photos;

}

@end
