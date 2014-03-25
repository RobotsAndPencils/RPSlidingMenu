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

const CGFloat RPSlidingCellDragInterval = 180.0f;

#import "RPSlidingMenuLayout.h"
#import "RPSlidingMenuCell.h"

@interface RPSlidingMenuLayout ()

@property (strong, nonatomic) NSDictionary *layoutAttributes;

@end

@implementation RPSlidingMenuLayout


- (void)prepareLayout {

    [super prepareLayout];

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;

    NSInteger topFeatureIndex = [self currentCellIndex];

    CGFloat topCellsInterpolation =  [self currentCellIndex] - topFeatureIndex;

    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;

    // last rect will be used to calculate frames past the first one.  We initialize it to a non junk 0 value
    CGRect lastRect = CGRectMake(0.0f, 0.0f, screenWidth, RPSlidingCellNormalHeight);
    NSInteger numItems = [self.collectionView numberOfItemsInSection:0];

    for (NSInteger itemIndex = 0; itemIndex < numItems; itemIndex++) {
        indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];

        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = itemIndex;
        NSInteger yValue = 0.0f;

        if (indexPath.row == topFeatureIndex) {
            // our top feature cell
            CGFloat yOffset = RPSlidingCellNormalHeight  *topCellsInterpolation;
            yValue = self.collectionView.contentOffset.y - yOffset;
            attributes.frame = CGRectMake(0.0f, yValue , screenWidth, RPSlidingCellFeatureHeight);
        } else if (indexPath.row == (topFeatureIndex + 1) && indexPath.row != numItems) {
            // the cell after the feature which grows into one as it goes up unless its the last cell (back to top)
            yValue = lastRect.origin.y + lastRect.size.height;
            CGFloat bottomYValue = yValue + RPSlidingCellNormalHeight;
            CGFloat amountToGrow = MAX((RPSlidingCellFeatureHeight - RPSlidingCellNormalHeight) *topCellsInterpolation, 0);
            NSInteger newHeight = RPSlidingCellNormalHeight + amountToGrow;
            attributes.frame = CGRectMake(0.0f, bottomYValue - newHeight, screenWidth, newHeight);
        } else {
            // all other cells above or below those on screen
            yValue = lastRect.origin.y + lastRect.size.height;
            attributes.frame = CGRectMake(0.0f, yValue, screenWidth, RPSlidingCellNormalHeight);
        }

        lastRect = attributes.frame;
        [layoutAttributes setObject:attributes forKey:indexPath];
    }

    self.layoutAttributes = layoutAttributes;
}

- (CGFloat)currentCellIndex {
    return (self.collectionView.contentOffset.y / RPSlidingCellDragInterval);
}


- (CGSize)collectionViewContentSize {

    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = (numberOfItems+1) * RPSlidingCellDragInterval + RPSlidingCellFeatureHeight ;
    return CGSizeMake(self.collectionView.frame.size.width, height);

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    // create layouts for the rectangles in the view
    NSMutableArray *attributesInRect =  [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in [self.layoutAttributes allValues]) {
        if(CGRectIntersectsRect(rect, attributes.frame)){
            [attributesInRect addObject:attributes];
        }
    }

    return attributesInRect;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    // so when a person stops dragging/flicking - we use the drag interval to determine where it will snap to
    CGFloat currentY = self.collectionView.contentOffset.y;
    // the marker of the next drag/page intervals
    CGFloat lastPageY =   (NSInteger)(currentY /  RPSlidingCellDragInterval) * RPSlidingCellDragInterval;
    CGFloat nextPageY =   lastPageY + RPSlidingCellDragInterval;

    // snap to whichever is closest
    CGPoint restingPoint = CGPointMake(0.0f, 0.0f);
    if ((currentY - lastPageY) < (nextPageY - currentY)){
        restingPoint.y = lastPageY;
    }else{
        restingPoint.y = nextPageY;
    }

    return restingPoint;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[indexPath];
}

// bounds change causes prepareLayout if YES
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
