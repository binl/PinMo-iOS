//
//  PMMapExploreViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMMapExploreViewController.h"
#import "PMInterestSpot.h"

#define METERS_PER_MILE 1609.344

@interface PMMapExploreViewController ()

@end

@implementation PMMapExploreViewController
@synthesize arrLocations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    CLLocationCoordinate2D zoomLocation = [[[PMUserGeoManager sharedInstance] locCurrent] coordinate];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 100*METERS_PER_MILE, 100*METERS_PER_MILE);
    
    NSLog(@"viewRegion: %f, %f", viewRegion.center.latitude,viewRegion.center.longitude);
    [self.map setRegion:viewRegion animated:YES];
    
    for (NSDictionary *spotData in self.arrLocations) {
        CLLocationCoordinate2D coordinate = [(CLLocation *)[spotData objectForKey:@"location"] coordinate];
        NSString * name = [spotData objectForKey:@"tag"];
        NSString * address = [NSString stringWithFormat:@"Loc: %f, %f", coordinate.latitude, coordinate.longitude];
        
        PMInterestSpot *annotation = [[PMInterestSpot alloc] initWithName:name address:address coordinate:coordinate] ;
        [self.map addAnnotation:annotation];
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)switchToListView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[PMInterestSpot class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            UILabel *annotationNum = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 30, 30)];
            annotationNum.text = @"10";
            [annotationView addSubview:annotationNum];
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y, 20, 20);
            annotationView.image = [UIImage imageNamed:@"orangePin.png"];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}


// Add the following method
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    PMInterestSpot *location = (PMInterestSpot*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}
@end
