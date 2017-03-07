//
//  AppDelegate.m
//  RedBeaconSample
//
//  Created by Fabio on 07/03/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "IAHAppContext.h"

@interface AppDelegate ()<CLLocationManagerDelegate>{
    CLLocationManager * _locationManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // NOTIFICATIONS
    
    // Cancel all notifications on launch.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
    // Notification for iBeacon
    [[UIApplication sharedApplication]
     registerUserNotificationSettings:[UIUserNotificationSettings
                                       settingsForTypes:UIUserNotificationTypeAlert
                                       categories:nil]];
    
    // Push Notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //ios8 ++
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        }
    }
    else
    {
        // ios7
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotificationTypes:)])
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        }
    }
    
    //Remote notification info
    NSDictionary *remoteNotifiInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    //Accept push notification when app is not open
    if (remoteNotifiInfo) {
        [self application:application didReceiveRemoteNotification:remoteNotifiInfo];
    }
    
    [self startBT];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
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

#pragma mark -
#pragma mark Activity
#pragma mark -

-(void)startBT{
    [[IAHAppContext singleton:SECRETKEY withAppId:APPID withUserId:USERID] startCommunications];
}

-(void)stopBT{
    [[IAHAppContext singleton:SECRETKEY withAppId:APPID withUserId:USERID] stopCommunications];
}

#pragma mark -
#pragma mark Beacon
#pragma mark -


-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if (state == CLRegionStateInside){
        [_locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }else if (state == CLRegionStateOutside){
        [_locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}


- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    if (foundBeacon!=nil){
        
        // Notify the delegate.
        if(foundBeacon.proximity==CLProximityImmediate)
        {
            NSLog(@"Immediate");
        }
        else if(foundBeacon.proximity==CLProximityNear)
        {
            NSLog(@"Near");
        }
        else if(foundBeacon.proximity==CLProximityFar)
        {
            NSLog(@"Far");
        }
        else if(foundBeacon.proximity==CLProximityUnknown)
        {
            
            NSLog(@"Unknown");
        }
    }
}

#pragma mark -
#pragma mark Push Notification
#pragma mark -

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // available in iOS8
{
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"%@",token);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Handle your remote RemoteNotification
    NSLog(@"%@",userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error:%@",error);
}



@end

