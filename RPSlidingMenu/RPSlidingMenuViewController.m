/***********************************************************************************
 *
 * Copyright (c) 2014 Robots and Pencils Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/

#import "RPSlidingMenuViewController.h"
#import "RPSlidingMenuLayout.h"


@interface RPSlidingMenuViewController () <UICollectionViewDataSource, UICollectionViewDelegate, RPSlidingMenuLayoutDelegate>

@end

@implementation RPSlidingMenuViewController

- (instancetype)init{

    self = [super init];

    if (self){
        _featureHeight = RPSlidingCellFeatureHeight;
        _collapsedHeight = RPSlidingCellCollapsedHeight;
        _scrollsToCollapsedRowsOnSelection = YES;
    }

    return self;
}

- (void)awakeFromNib {
    self.featureHeight = RPSlidingCellFeatureHeight;
    self.collapsedHeight = RPSlidingCellCollapsedHeight;
    self.scrollsToCollapsedRowsOnSelection = YES;
}


static NSString *RPSlidingCellIdentifier = @"RPSlidingCellIdentifier";

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.collectionView.collectionViewLayout = [[RPSlidingMenuLayout alloc] initWithDelegate:self];

    [self.collectionView registerClass:[RPSlidingMenuCell class] forCellWithReuseIdentifier:RPSlidingCellIdentifier];
    self.navigationController.navigationBarHidden = YES;
    
    // don't have it scroll content below nav bar and status bar
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

#pragma mark - Overridables

- (NSInteger)numberOfItemsInSlidingMenu {
    NSAssert(NO, @"This method must be overriden in the subclass");
    return 0;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row {
    NSAssert(NO, @"This method must be overriden in the subclass");
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row {

    if (self.scrollsToCollapsedRowsOnSelection){
        [self scrollToRow:row animated:YES];
    }

}

- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated {

    NSInteger rowOffset = RPSlidingCellDragInterval * row;

    // do not need to flip to that row if already on it
    if (self.collectionView.contentOffset.y == rowOffset) return;

    // show the category they picked
    [self.collectionView setContentOffset:CGPointMake(0.0f, rowOffset) animated:animated];

}

#pragma mark - RPSlidingMenuLayoutDelegate

- (CGFloat)heightForFeatureCell {
    return self.featureHeight;
}

- (CGFloat)heightForCollapsedCell {
    return self.collapsedHeight;
}


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfItemsInSlidingMenu];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RPSlidingMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RPSlidingCellIdentifier forIndexPath:indexPath];

    [self customizeCell:cell forRow:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self slidingMenu:self didSelectItemAtRow:indexPath.row];
}


@end
