//
//  PMNewTripViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMNewTripViewController.h"

#import "PMUserGeoManager.h"

#define CONTENT_WIDTH 260
#define PAGE_PADDING 10

#define IS_RECORDING [self.btnRecord isSelected]
#define IS_NOT_RECORDING ![self.btnRecord isSelected]

#define TRACK_STARTED [self.btnStop isSelected]
#define TRACK_NOT_STARTED ![self.btnStop isSelected]

#define TAP_MSG @"Tap To Start!"
#define RECORDING_MSG @"Now, put away your phone and enjoy the trip!"

@interface PMNewTripViewController () {
    BOOL firstLoad;
}

@end

@implementation PMNewTripViewController

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
    self.lblNote.text = TAP_MSG;
    
    [[PMUserGeoManager sharedInstance] stopTracking];
    NSUInteger numberPages = 3;
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    // a page is the width of the scroll view
    self.scrlTutImages.pagingEnabled = YES;
    self.scrlTutImages.delegate = self;
    self.scrlTutImages.contentSize =
    CGSizeMake((CONTENT_WIDTH + PAGE_PADDING)* numberPages
               , CGRectGetHeight(self.scrlTutImages.frame));
    self.scrlTutImages.showsHorizontalScrollIndicator = NO;
    self.scrlTutImages.showsVerticalScrollIndicator = NO;
    self.scrlTutImages.scrollsToTop = NO;
    self.scrlTutImages.contentOffset = CGPointMake(0, 0);
    for (UIView *subview in self.scrlTutImages.subviews) {
        [subview removeFromSuperview];
    }
    
    for (NSUInteger i = 0; i < numberPages; i++) {
		[self loadScrollViewWithPage:i];
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    if (IS_RECORDING) {
        [self animateView:self.radarAnime WithDelay:0];
        [self animateView:self.radarAnime2 WithDelay:1.0];
        [self animateView:self.radarAnime3 WithDelay:2.0];
    }
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= 3)
        return;
    
    // replace the placeholder if necessary
    UIImageView *singleImage;
    
    CGRect frame;
    frame.origin.x = PAGE_PADDING/2 + (CONTENT_WIDTH + PAGE_PADDING) * page;
    frame.origin.y = 0;
    frame.size.width = CONTENT_WIDTH;
    frame.size.height = 345;
    
    singleImage = [[UIImageView alloc] initWithFrame:frame];
    [singleImage setContentMode:UIViewContentModeScaleAspectFill];
    [singleImage setClipsToBounds:YES];
    [singleImage setImage:[UIImage imageNamed:
                           [NSString stringWithFormat:@"tutorial0%d.png", page+1]]];
    
    [self.scrlTutImages addSubview:singleImage];
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    NSUInteger page = floor(self.scrlTutImages.contentOffset.x / CONTENT_WIDTH);
    
    [self.pgControl setCurrentPage:page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions
-(IBAction)startRecording:(id)sender {
    if (TRACK_NOT_STARTED) {
        [self.viewPopup setHidden:NO];
        [self.viewOverlay setHidden:NO];
        [self.txtNewName becomeFirstResponder];
        return;
    }
    
    [self.btnRecord setSelected:![self.btnRecord isSelected]];
    if (IS_RECORDING) {
        [self animateView:self.radarAnime WithDelay:0];
        [self animateView:self.radarAnime2 WithDelay:1.0];
        [self animateView:self.radarAnime3 WithDelay:2.0];
    }
    else {
    }
    
    
}

-(IBAction)doneEditingName:(id)sender {
    self.navTitle.title = self.txtNewName.text;
    
    [self.btnStop setSelected:YES];
    [self.btnRecord setSelected:YES];
    [self.viewPopup setHidden:YES];
    [self.viewOverlay setHidden:YES];
    [self.txtNewName resignFirstResponder];
    [self.txtNewName setText:@""];
    
    [self animateView:self.radarAnime WithDelay:0];
    [self animateView:self.radarAnime2 WithDelay:1.0];
    [self animateView:self.radarAnime3 WithDelay:2.0];
    
    self.lblNote.text = RECORDING_MSG;
    [[PMUserGeoManager sharedInstance] startTrackingWithExistingPath:nil];
}


-(IBAction)cancelEditingName:(id)sender {
    [self.viewPopup setHidden:YES];
    [self.viewOverlay setHidden:YES];
    [self.txtNewName resignFirstResponder];
    [self.txtNewName setText:@""];
}

-(IBAction)stopTracking:(id)sender {
    [self.btnStop setSelected:NO];
    self.navTitle.title = @"New Trip";
    [self.btnRecord setSelected:NO];
    
    self.lblNote.text = TAP_MSG;
    [[PMUserGeoManager sharedInstance] stopTracking];
}

-(IBAction)doneWithTutorials:(id)sender {
    NSUInteger page = floor(self.scrlTutImages.contentOffset.x / CONTENT_WIDTH);
    
    if (page < 2) {
        return;
    }
    
    [self.scrlTutImages setHidden:YES];
    [self.pgControl setHidden:YES];
    [self.viewOverlay setHidden:YES];
}

#pragma mark - animation
-(void)animateView:(UIView *)view WithDelay:(CGFloat)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3
                              delay:delay
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
             view.frame = CGRectMake(0, 66, 320, 320);
             view.alpha = 0;
        }
                         completion:^(BOOL finished) {
                             view.frame = CGRectMake(70, 136, 180, 180);
                             view.alpha = 1;
                             if(IS_RECORDING) {
                                 [self animateView:view WithDelay:0];
                             }
                         }];
    });
}


@end
