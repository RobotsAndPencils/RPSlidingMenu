//
//  RPViewController.m
//  RPSlidingMenuDemo
//
//  Created by Paul Thorsteinson on 2/24/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPViewController.h"


@interface RPViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RPViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    // Example of changing the feature height and collapsed height for all
    //self.featureHeight = 200.0f;
    //self.collapsedHeight = 100.0f;
}


#pragma mark - RPSlidingMenuViewController


-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 10;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
 
    // alternate for demo.  Simply set the properties of the passed in cell
    if (row % 2 == 0) {
        slidingMenuCell.textLabel.text = @"Something Special";
        slidingMenuCell.detailTextLabel.text = @"For your loved ones!";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"image1_320x210"];
    }else{
        
        slidingMenuCell.textLabel.text = @"This Thing Too";
        slidingMenuCell.detailTextLabel.text = @"This thing will blow your mind.";
        slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"image2_320x210"];
    }
    
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{

    [super slidingMenu:slidingMenu didSelectItemAtRow:row];

    // when a row is tapped do some action
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Tapped"
                                                    message:[NSString stringWithFormat:@"Row %ld tapped.", (long)row]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}


@end
