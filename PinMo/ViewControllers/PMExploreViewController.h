//
//  PMExploreViewController.h
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMExploreViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblExploreList;

@end
