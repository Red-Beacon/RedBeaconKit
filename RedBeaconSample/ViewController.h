//
//  ViewController.h
//  RedBeaconSample
//
//  Created by Fabio on 07/03/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *beaconAlreadyProc;

@property (nonatomic, retain) IBOutlet UILabel *typeDistance;
@property (nonatomic, retain) IBOutlet UILabel *beaconUUID;
@property (nonatomic, retain) IBOutlet UILabel *major;
@property (nonatomic, retain) IBOutlet UILabel *minor;
@property (nonatomic, retain) IBOutlet UILabel *distance;


@end

