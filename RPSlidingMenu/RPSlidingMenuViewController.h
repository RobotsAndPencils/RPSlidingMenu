//
//  RPSlidingMenuViewController.h
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPSlidingMenuCell.h"


@interface RPSlidingMenuViewController : UICollectionViewController

- (NSInteger)numberOfItemsInSlidingMenu;
- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row;
- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row;

@end
