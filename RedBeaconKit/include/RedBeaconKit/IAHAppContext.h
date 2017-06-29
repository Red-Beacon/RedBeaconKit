//
//  IAHAppContext.h
//  RedBeaconKit
//
//  Created by Fabio on 30/06/16.
//  Copyright © 2016 Fabio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// External declarations.
extern NSString * const IAHLocationUpdatedNotification;
extern NSString * const IAHBeaconLocationUpdatedNotificationImmediate;
extern NSString * const IAHBeaconLocationUpdatedNotificationNear;
extern NSString * const IAHBeaconLocationUpdatedNotificationFar;
extern NSString * const IAHBeaconLocationUpdatedNotificationUnknown;
extern NSString * const IAHBeaconLocationServiceDisableNotification;


// IAHAppContext interface.
@interface IAHAppContext : NSObject

// Class singleton.
+ (instancetype)singleton:(NSString*)secretKey withAppId:(NSString*)appId withUserId:(NSString*)userId;

// Starts communications.
- (void)startCommunications;

// Stops communications.
- (void)stopCommunications;


@end
