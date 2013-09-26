//
//  CNUserGeoManager.m
//  api_tester
//
//  Created by Lenix Liu on 13-4-19.
//  Copyright (c) 2013年 CrushNuts. All rights reserved.
//

#import "PMUserGeoManager.h"

@implementation PMUserGeoManager

@synthesize locationManager;
@synthesize locCurrent;


+(PMUserGeoManager *)sharedInstance {
    static PMUserGeoManager *sharedInstance = nil;

    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[PMUserGeoManager alloc] init];
        sharedInstance->shouldUpdate = YES;
        sharedInstance.locationManager = [[CLLocationManager alloc] init];
        sharedInstance.locationManager.delegate = sharedInstance;
        sharedInstance.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        sharedInstance.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; // 100 m
        [sharedInstance startTrackingWithExistingPath:nil];
    });
    
    return sharedInstance;
}

#pragma mark - Location Delegate

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"in Pause");
    self->shouldUpdate = NO;
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"in Resume");
    self->shouldUpdate = YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"in Update");
    self.locCurrent = [locations objectAtIndex:0];
    
    if (prevLocation == NULL) {
        prevLocation = [locations objectAtIndex:0];
    }
    else {
        CLLocation *newLocation = [locations objectAtIndex:0];
        if (newLocation == NULL) {
            return;
        }
        if ([prevLocation distanceFromLocation:newLocation] > 10) {
            prevLocation = newLocation;
        }
        else
            return;
    }
    
    NSDictionary *cood = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithDouble:prevLocation.coordinate.latitude], @"lat",
                          [NSNumber numberWithDouble:prevLocation.coordinate.longitude], @"longt",
                          nil];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         cood, @"location",
                         [NSNumber numberWithInteger: [[NSDate date] timeIntervalSince1970]], @"timestamp",nil];
    
    [self.arrLocationPath addObject:dic];
}

-(void)updateUserGeo{
    //Update geo location
    if (self->shouldUpdate == NO){
        return;
    }
}

#pragma mark - Actions

- (void)startTrackingWithExistingPath:(NSArray *)exisingPath {
    if (exisingPath == nil) {
        self.arrLocationPath = [NSMutableArray array];
    }
    else {
        self.arrLocationPath = [NSMutableArray arrayWithArray:exisingPath];   
    }
    
    [self.locationManager startUpdatingLocation];
}

- (NSMutableArray *)stopTracking {
    [self.locationManager stopUpdatingLocation];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.arrLocationPath
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"JSON error: %@", error);
    } else {
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        NSLog(@"JSON OUTPUT: %@",JSONString);
    }
    return self.arrLocationPath;
}

@end
