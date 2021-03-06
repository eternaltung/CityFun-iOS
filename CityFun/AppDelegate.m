//
//  AppDelegate.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/13/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#import "UserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//commit test
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:85.0f/255.0f green:172.0f/255.0f blue:238.0f/255.0f alpha:1.0f]];
    [GMSServices provideAPIKey:@""];
    [UserModel setUserClient:@"" key:@""];
    
    /*
    // for testing
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //DetailViewController *detailViewController = [[DetailViewController alloc] init];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithCollectionViewLayout:[PSUICollectionViewFlowLayout new]];
    self.window.rootViewController = detailViewController;
    [self.window makeKeyAndVisible];
    */

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

static CLLocation *userlocation = nil;
+(CLLocation*)getUserLocation
{
    return userlocation;
}

+(void)setUserLocation:(CLLocation*)location
{
    userlocation = location;
}

@end
