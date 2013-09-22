//
//  PMNewTripViewController.h
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMNewTripViewController : UIViewController
<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *radarAnime;
@property (nonatomic, strong) IBOutlet UIImageView *radarAnime2;
@property (nonatomic, strong) IBOutlet UIImageView *radarAnime3;

@property (strong, nonatomic) IBOutlet UIButton *btnRecord;
@property (strong, nonatomic) IBOutlet UIButton *btnStop;

@property (strong, nonatomic) IBOutlet UITextField *txtNewName;
@property (strong, nonatomic) IBOutlet UIView *viewPopup;
@property (strong, nonatomic) IBOutlet UIView *viewOverlay;

@property (strong, nonatomic) IBOutlet UIScrollView *scrlTutImages;
@property (strong, nonatomic) IBOutlet UIPageControl *pgControl;

@property (strong, nonatomic) IBOutlet UINavigationItem *navTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblNote;

-(IBAction)startRecording:(id)sender;
@end
