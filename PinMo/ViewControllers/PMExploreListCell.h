//
//  PMExploreListCell.h
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMExploreListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIScrollView *scrlImages;
@property (strong, nonatomic) IBOutlet UILabel *lblLocName;

@property (strong, nonatomic) NSMutableArray *arrImages;

- (void)initCellWithLocName:(NSString *)name;

@end
