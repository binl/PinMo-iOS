//
//  PMExploreViewController.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMExploreViewController.h"

#import "PMExploreListCell.h"

@interface PMExploreViewController ()

@end

@implementation PMExploreViewController

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
    self.title = @"Explore";
    
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 440, 200, 50)];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:startBtn];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int nRows = 3;
        
    return nRows;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMExploreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExploreListCell"];
    
    if (indexPath.row == 0) {
        [cell initCellWithLocName:@"GoldenGateBridge"];
    }
    else if (indexPath.row == 1) {
        [cell initCellWithLocName:@"LombardStreet"];
    }
    else if (indexPath.row == 2) {
        [cell initCellWithLocName:@"FishermansWharf"];
    }
    else if (indexPath.row == 3) {
        [cell initCellWithLocName:@"UnionSquare"];
    }
    
    return cell;
}

@end
