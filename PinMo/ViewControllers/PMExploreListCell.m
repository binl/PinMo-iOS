//
//  PMExploreListCell.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMExploreListCell.h"
#import <MapKit/MapKit.h>

#define CONTENT_WIDTH 274
#define PAGE_PADDING 6

static NSInteger kDelta = 0;

@interface PMExploreListCell () {
    NSString *_strSpotName;
    NSUInteger numberPages;
}

@end

@implementation PMExploreListCell
@synthesize scrlImages;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithLocInfo:(NSDictionary *)info{
    self.dicInfo = info;
    _strSpotName = [info objectForKey:@"tag"];
    self.lblLocName.text = [NSString stringWithFormat:@"#%@", _strSpotName];
    
    if ([info objectForKey:@"XOLA"]) {
        [self.imgXOLA setHidden:NO];
        numberPages = [[info objectForKey:@"photos"] count];
        if (numberPages > 2) {
            numberPages = 2;
        }
    }
    else {
        [self.imgXOLA setHidden:YES];
        numberPages = 3;
    }
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *tmpImages = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[tmpImages addObject:[NSNull null]];
    }
    self.arrImages = tmpImages;
    
    // a page is the width of the scroll view
    self.scrlImages.pagingEnabled = YES;
    self.scrlImages.delegate = self;
    self.scrlImages.contentSize =
    CGSizeMake((CONTENT_WIDTH + PAGE_PADDING)* numberPages
               , CGRectGetHeight(self.scrlImages.frame));
    self.scrlImages.showsHorizontalScrollIndicator = NO;
    self.scrlImages.showsVerticalScrollIndicator = NO;
    self.scrlImages.scrollsToTop = NO;
    self.scrlImages.contentOffset = CGPointMake(0, 0);
    for (UIView *subview in self.scrlImages.subviews) {
        [subview removeFromSuperview];
    }
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= numberPages)
        return;
    
    // replace the placeholder if necessary
    UIImageView *singleImage = [self.arrImages objectAtIndex:page];
    if ((NSNull *)singleImage == [NSNull null])
    {
        CGRect frame;
        frame.origin.x = PAGE_PADDING/2 + (CONTENT_WIDTH + PAGE_PADDING) * page;
        frame.origin.y = 0;
        frame.size.width = CONTENT_WIDTH;
        frame.size.height = 160 + kDelta;
        
        singleImage = [[UIImageView alloc] initWithFrame:frame];
        [singleImage setContentMode:UIViewContentModeScaleAspectFill];
        [singleImage setClipsToBounds:YES];
        
        if (![self.dicInfo objectForKey:@"XOLA"]) {
            [singleImage setImage:[UIImage imageNamed:
                                   [NSString stringWithFormat:@"%@%d.jpg", _strSpotName, page+1]]];
        }
        else {
            NSDictionary *singleMedia = [[self.dicInfo objectForKey:@"photos"] objectAtIndex:page];
            
            [singleImage setImageWithURL:[NSURL URLWithString:[singleMedia objectForKey:@"src"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
        }
        
        
        
        [self.arrImages replaceObjectAtIndex:page withObject:singleImage];
    }
    
    [self.scrlImages addSubview:singleImage];
}

#pragma mark - actions
- (IBAction)gotoMap:(id)sender {
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
    }}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    NSUInteger page = floor(self.scrlImages.contentOffset.x / CONTENT_WIDTH);
    
    [self loadScrollViewWithPage:page + 1];
}

@end
