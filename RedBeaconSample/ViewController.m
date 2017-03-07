//
//  ViewController.m
//  RedBeaconSample
//
//  Created by Fabio on 07/03/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <PassKit/PassKit.h>
#import <CoreLocation/CoreLocation.h>

#import "IAHAppContext.h"


#define LOCATION_DISTANCE_NOTIFY 20

@interface ViewController ()

// Locations
- (void)locationUpdatedNotificationCallback:(NSNotification *)notification;

@end

@implementation ViewController{
@private
    
    // The current location of the local peer.
    CLLocation * _location;
    CLLocation * _oldLocation;
    
    // The current beacon
    CLBeacon *_beacon;
    
    
    
}

@synthesize beaconAlreadyProc=_beaconAlreadyProc;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Get the default notification center.
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    // Location
    [notificationCenter addObserver:self
                           selector:@selector(locationUpdatedNotificationCallback:)
                               name:IAHLocationUpdatedNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(beaconLocationUpdatedNotificationImmediateCallback:)
                               name:IAHBeaconLocationUpdatedNotificationImmediate
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(beaconLocationUpdatedNotificationNearCallback:)
                               name:IAHBeaconLocationUpdatedNotificationNear
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(beaconLocationUpdatedNotificationFarCallback:)
                               name:IAHBeaconLocationUpdatedNotificationFar
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(beaconLocationUpdatedNotificationUnknownCallback:)
                               name:IAHBeaconLocationUpdatedNotificationUnknown
                             object:nil];
    
    _beaconAlreadyProc = [[NSMutableArray alloc] init];
    [_beaconAlreadyProc removeAllObjects];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Peers notifications

// TSNLocationUpdatedNotification callback.
- (void)locationUpdatedNotificationCallback:(NSNotification *)notification
{
    
    // Save the location.
    _location = [notification object];
    
    // Update server location
    CLLocationDistance distance = [_location distanceFromLocation:_oldLocation];
    
    if ((distance==-1)||(distance>=LOCATION_DISTANCE_NOTIFY)){
        
        NSLog(@"Location Notification : Distance > %f",distance);
        _oldLocation=_location;
    }
    
    
}


- (void)beaconLocationUpdatedNotificationImmediateCallback:(NSNotification *)notification
{
    
    // Save the location.
    _beacon = [notification object];
    float actualDistance = _beacon.accuracy/10;
    [self checkBeacon:_beacon type:@"Immediate" actualDistance:actualDistance];
    
}


- (void)beaconLocationUpdatedNotificationNearCallback:(NSNotification *)notification
{
    
    // Save the location.
    _beacon = [notification object];
    float actualDistance = _beacon.accuracy/10;
    [self checkBeacon:_beacon type:@"Near" actualDistance:actualDistance];
    
    
}


- (void)beaconLocationUpdatedNotificationFarCallback:(NSNotification *)notification
{
    
    // Save the location.
    _beacon = [notification object];
    float actualDistance = _beacon.accuracy/10;
    [self checkBeacon:_beacon type:@"Far" actualDistance:actualDistance];
    
    
}

- (void)beaconLocationUpdatedNotificationUnknownCallback:(NSNotification *)notification
{
    
    // Save the location.
    _beacon = [notification object];
    float actualDistance = _beacon.accuracy/10;
    [self checkBeacon:_beacon type:@"Unknown" actualDistance:actualDistance];
    
    
}


-(void)checkBeacon:(CLBeacon*)ib type:(NSString*)type actualDistance:(float)actualDistance{
    
    
    NSString *uuid = _beacon.proximityUUID.UUIDString;
    NSString *major = [NSString stringWithFormat:@"%@", _beacon.major];
    NSString *minor = [NSString stringWithFormat:@"%@", _beacon.minor];
    
    _beaconUUID.text=uuid;
    _major.text=major;
    _minor.text=minor;
    _typeDistance.text=type;
    if(actualDistance >= 0.0)
    {
        _distance.text=[NSString stringWithFormat:@"%.2f m",actualDistance];
    }
    
}


@end
