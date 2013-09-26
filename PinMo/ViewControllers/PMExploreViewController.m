//
//  PMExploreViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "PMExploreViewController.h"
#import "PMExploreListCell.h"

#import "PMMapExploreViewController.h"
#import "PMExpDetailViewController.h"

#import "AFAppDotNetAPIClient.h"

#import <QuartzCore/QuartzCore.h>
@interface PMExploreViewController () {
}

@end

@implementation PMExploreViewController
@synthesize arrNearBySpots;

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
    self.navigationItem.title = @"Explore";
	// Do any additional setup after loading the view.
    
    [[AFAppDotNetAPIClient sharedClient] getPath:@"experiences" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSArray *locationsFromResponse = [JSON valueForKeyPath:@"data"];
        
        //NSLog(@"Experiences: %@", [locationsFromResponse description]);
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:37.810301 longitude:-122.418017];
        NSDictionary *fiswf = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"FishermansWharf", @"tag",
                               location, @"location", nil];
        
        location = [[CLLocation alloc]initWithLatitude:37.802104 longitude:-122.418929];
        NSDictionary *lombard = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"LombardStreet", @"tag",
                                 location, @"location", nil];
        
        location = [[CLLocation alloc]initWithLatitude:37.832582 longitude:-122.480062];
        NSDictionary *ggb = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"GoldenGateBridge", @"tag",
                             location, @"location", nil];
        
        location = [[CLLocation alloc]initWithLatitude:37.795458 longitude:-122.393492];
        NSDictionary *fb = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"FerryBuilding", @"tag",
                            location, @"location", nil];
        
        [self.arrNearBySpots addObject:fiswf];
        [self.arrNearBySpots addObject:lombard];
        [self.arrNearBySpots addObject:ggb];
        [self.arrNearBySpots addObject:fb];
        
        for (NSDictionary *exp in locationsFromResponse) {
            if ([[exp objectForKey:@"name"] isEqualToString:@"Survival Skills Training in the Heart of the Santa Cruz Mountains"]) {
                continue;
            }
            
            NSLog(@"Venue: %@", [exp description]);
            CLLocationDegrees lat = [[[exp objectForKey:@"geo"] objectForKey:@"lat"] doubleValue];
            CLLocationDegrees lng = [[[exp objectForKey:@"geo"] objectForKey:@"lng"] doubleValue];
            CLLocation *expGeo = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
            
            if ([expGeo distanceFromLocation:[[PMUserGeoManager sharedInstance] locCurrent]] < 200000) {
                
                NSDictionary *newVenue = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [exp objectForKey:@"name"], @"tag",
                                          expGeo, @"location",
                                          @"YES", @"XOLA",
                                          [exp objectForKey:@"price"], @"price",
                                          [exp objectForKey:@"category"], @"category",
                                          [exp objectForKey:@"desc"], @"desc",
                                          [exp objectForKey:@"medias"], @"photos",
                                          nil];
                
                [self.arrNearBySpots addObject:newVenue];
            }
        }

        [self.tblExploreList reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    self.arrNearBySpots = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrNearBySpots.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMExploreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExploreListCell"];
    
    [cell initCellWithLocInfo:[self.arrNearBySpots objectAtIndex:indexPath.row]];
     
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.arrNearBySpots objectAtIndex:indexPath.row];
    if (![dic objectForKey:@"XOLA"]) {
        return;
    }
    PMExpDetailViewController *detailView = [[self storyboard] instantiateViewControllerWithIdentifier:@"PMExpDetailViewController"];
    
    detailView.dicInfo = dic;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - Actions
-(IBAction)switchToMapView:(id)sender {
    PMMapExploreViewController *mapView = [[self storyboard] instantiateViewControllerWithIdentifier:@"PMMapExploreViewController"];
    mapView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    mapView.arrLocations = self.arrNearBySpots;
    
    [self presentViewController:mapView animated:YES completion:nil];
}

@end
