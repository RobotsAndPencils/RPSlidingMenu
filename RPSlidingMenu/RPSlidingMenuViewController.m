//
//  RPSlidingMenuViewController.m
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPSlidingMenuViewController.h"
#import "RPSlidingMenuLayout.h"
#import "RPSlidingMenuCell.h"

@interface RPSlidingMenuViewController ()

@end

@implementation RPSlidingMenuViewController

- (id)init {
    self = [super initWithCollectionViewLayout:[[RPSlidingMenuLayout alloc] init]];
    if (self) {

    }
    return self;
}


static NSString *RPSlidingCellIdentifier = @"RPSlidingCellIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.collectionView registerClass:[RPSlidingMenuCell class] forCellWithReuseIdentifier:RPSlidingCellIdentifier];
    self.navigationController.navigationBarHidden = YES;
    
    // don't have it scroll content below nav bar and status bar
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RPSlidingMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RPSlidingCellIdentifier forIndexPath:indexPath];

    cell.backgroundColor = (indexPath.row % 2 == 0 ? [UIColor purpleColor] : [UIColor blueColor]);
    cell.textLabel.text = [NSString stringWithFormat:@"BehindTheScenes %d", indexPath.row];

    cell.detailTextLabel.text = @"Fine fabrics, soft hardware. Garments tailored with an ease & versatility women desire.";
    cell.image = (indexPath.row % 2 == 0 ? [UIImage imageNamed:@"Live"] : [UIImage imageNamed:@"Snapchat"]);
    return cell;
}


@end
