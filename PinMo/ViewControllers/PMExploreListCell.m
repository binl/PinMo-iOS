//
//  PMExploreListCell.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMExploreListCell.h"

#define CONTENT_WIDTH 240
#define PAGE_PADDING 10

static NSInteger kDelta = 0;

@interface PMExploreListCell () {
    NSString *_strSpotName;
}

@end

@implementation PMExploreListCell
@synthesize scrlImages;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCellWithLocName:(NSString *)name{
    _strSpotName = name;
    self.lblLocName.text = [NSString stringWithFormat:@"#%@", _strSpotName];
    
    NSUInteger numberPages = 3;
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *tmpImages = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[tmpImages addObject:[NSNull null]];
    }
    self.arrImages = tmpImages;
    
    // a page is the width of the scroll view
    self.scrlImages.pagingEnabled = YES;
    self.scrlImages.contentSize =
    CGSizeMake((CONTENT_WIDTH + PAGE_PADDING)* numberPages
               , CGRectGetHeight(self.scrlImages.frame));
    self.scrlImages.showsHorizontalScrollIndicator = NO;
    self.scrlImages.showsVerticalScrollIndicator = NO;
    self.scrlImages.scrollsToTop = NO;
    self.scrlImages.contentOffset = CGPointMake(0, 0);
    for (UIView *subview in self.scrlImages.subviews) {
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < numberPages ; i++) {
        [self loadScrollViewWithPage:i];
    }
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= 3)
        return;
    
    // replace the placeholder if necessary
    UIImageView *singleImage = [self.arrImages objectAtIndex:page];
    if ((NSNull *)singleImage == [NSNull null])
    {
        CGRect frame;
        frame.origin.x = PAGE_PADDING/2 + (CONTENT_WIDTH + PAGE_PADDING) * page;
        frame.origin.y = 0;
        frame.size.width = CONTENT_WIDTH;
        frame.size.height = 160 + kDelta;
        
        singleImage = [[UIImageView alloc] initWithFrame:frame];
        [singleImage setContentMode:UIViewContentModeScaleAspectFill];
        [singleImage setClipsToBounds:YES];
        [singleImage setImage:[UIImage imageNamed:
                               [NSString stringWithFormat:@"%@%d.jpg", _strSpotName, page+1]]];
        
        [self.arrImages replaceObjectAtIndex:page withObject:singleImage];
    }
    
    [self.scrlImages addSubview:singleImage];
}

@end
