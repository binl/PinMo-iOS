//
//  PMExpDetailViewController.h
//  PinMo
//
//  Created by Bin Liu on 13-9-22.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMExpDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *lblCategory;
@property (nonatomic, strong) IBOutlet UILabel *lblPrice;

@property (nonatomic, strong) IBOutlet UITextView *txtDesc;
@property (nonatomic, strong) IBOutlet UIImageView *imgTitle;

@property (nonatomic, strong) NSDictionary *dicInfo;

-(IBAction)reserve:(id)sender;

@end
