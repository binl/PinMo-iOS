//
//  PMTutorialViewController.h
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMTutorialViewController : UIViewController
<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrlTutImages;
@property (strong, nonatomic) IBOutlet UIPageControl *pgControl;
@end
