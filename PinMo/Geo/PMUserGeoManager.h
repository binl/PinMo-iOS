//
//  CNUserGeoManager.h
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PMUserGeoManager : NSObject
<CLLocationManagerDelegate> {
    BOOL shouldUpdate;
    CLLocation *prevLocation;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *locCurrent;

@property (strong, nonatomic) NSMutableArray *arrLocationPath;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;

+(PMUserGeoManager *)sharedInstance;

- (void)startTrackingWithExistingPath:(NSArray *)exisingPath;
- (NSMutableArray *)stopTracking;
@end
