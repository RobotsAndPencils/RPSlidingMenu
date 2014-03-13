//
//  RPSlidingMenuViewController.m
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPSlidingMenuViewController.h"
#import "RPSlidingMenuLayout.h"


@interface RPSlidingMenuViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation RPSlidingMenuViewController

- (id)init {
    self = [super initWithCollectionViewLayout:[[RPSlidingMenuLayout alloc] init]];
    if (self) {
        
    }
    return self;
}

static NSString *RPSlidingCellIdentifier = @"RPSlidingCellIdentifier";

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = [[RPSlidingMenuLayout alloc] init];

    [self.collectionView registerClass:[RPSlidingMenuCell class] forCellWithReuseIdentifier:RPSlidingCellIdentifier];
    self.navigationController.navigationBarHidden = YES;
    
    // don't have it scroll content below nav bar and status bar
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

- (NSInteger)numberOfItemsInSlidingMenu{
    NSAssert(false, @"This method must be overriden in the subclass");
    return 0;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    NSAssert(false, @"This method must be overriden in the subclass");
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
}


#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfItemsInSlidingMenu];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RPSlidingMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RPSlidingCellIdentifier forIndexPath:indexPath];

    [self customizeCell:cell forRow:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self slidingMenu:self didSelectItemAtRow:indexPath.row];
}


@end
