//
//  PMFirstViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMDummyViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsFilter.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@interface PMDummyViewController ()

@end

@implementation PMDummyViewController

@synthesize img;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    
//    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
//    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        
//        // Within the group enumeration block, filter to enumerate just photos.
//        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//        
//        // Chooses the photo at the last index
//        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:([group numberOfAssets]-1)]
//                                options:0
//                             usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
//                                 
//                                 // The end of the enumeration is signaled by asset == nil.
//                                 if (alAsset) {
//                                     ALAssetRepresentation *representation = [alAsset defaultRepresentation];
//                                     UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullResolutionImage]];
////
//                                     [self.img setImage:latestPhoto];
////                                     // Do something interesting with the AV asset.
////                                     [self sendTweet:latestPhoto];
//                                 }
//                             }];
//    }
//                         failureBlock: ^(NSError *error) {
//                             // Typically you should handle an error more gracefully than this.
//                             NSLog(@"No groups");
//                         }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
