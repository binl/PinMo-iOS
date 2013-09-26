//
//  PMExpDetailViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-22.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMExpDetailViewController.h"

@interface PMExpDetailViewController ()

@end

@implementation PMExpDetailViewController
@synthesize dicInfo;

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
    self.title = [self.dicInfo objectForKey:@"tag"];
    
    NSDictionary *singleMedia = [[self.dicInfo objectForKey:@"photos"] objectAtIndex:0];
    
    [self.imgTitle setImageWithURL:[NSURL URLWithString:[singleMedia objectForKey:@"src"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    self.lblCategory.text = [self.dicInfo objectForKey:@"category"];
    self.lblPrice.text = [NSString stringWithFormat:@"$%@/person", [self.dicInfo objectForKey:@"price"]];
    self.txtDesc.text = [self.dicInfo objectForKey:@"desc"];

    UIImage* image3 = [UIImage imageNamed:@"direction.png"];
    CGRect frameimg = CGRectMake(-10, 0, 23, 23);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(getDirection)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *directionBtn =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=directionBtn;
    
	// Do any additional setup after loading the view.
}

-(void)getDirection {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocation *targetLocation = [self.dicInfo objectForKey:@"location"];
        
        CLLocationCoordinate2D coordinate = targetLocation.coordinate;
        
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"My Place"];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    //[self.navigationItem.backBarButtonItem setImage:[UIImage imageNamed:@"backArrow.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
-(IBAction)reserve:(id)sender {
    
}


@end
