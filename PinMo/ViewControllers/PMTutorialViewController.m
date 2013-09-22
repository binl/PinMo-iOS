//
//  PMTutorialViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMTutorialViewController.h"

#define CONTENT_WIDTH 260
#define PAGE_PADDING 10

@interface PMTutorialViewController ()

@end

@implementation PMTutorialViewController

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
    NSUInteger page = floor(self.scrlTutImages.contentOffset.x / CONTENT_WIDTH) + 1;
    
    [self.pgControl setCurrentPage:page];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
