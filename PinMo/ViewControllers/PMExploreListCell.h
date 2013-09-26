//
//  PMExploreListCell.h
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMExploreListCell : UITableViewCell
<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrlImages;
@property (strong, nonatomic) IBOutlet UILabel *lblLocName;

@property (strong, nonatomic) NSMutableArray *arrImages;
@property (strong, nonatomic) NSDictionary *dicInfo;

@property (strong, nonatomic) IBOutlet UIImageView *imgXOLA;

- (void)initCellWithLocInfo:(NSDictionary *)info;
- (IBAction)gotoMap:(id)sender;
@end
