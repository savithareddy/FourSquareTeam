//
//  FSAAppDelegate.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSAAppDelegate.h"
#import "FSAViewController.h"
#import "FSATableVC.h"
#import "TAPFourSquareRequests.h"


@implementation FSAAppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FSAViewController *viewVC = [[FSAViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewVC];
   self.window.rootViewController = nc;
    self.window.backgroundColor = [UIColor whiteColor];
    //for data persistence// 2MB of memory and 100MB of disk space 
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
                                                         diskCapacity:100 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [self.window makeKeyAndVisible];
    return YES;
}




































- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
//    BOOL success = [[FSATableVC s]]
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
