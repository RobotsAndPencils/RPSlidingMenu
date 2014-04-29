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

@property (assign, nonatomic) CGFloat contentHeight;
@property (assign, nonatomic) NSInteger contentIndex;

@end

@implementation RPSlidingMenuLayout

- (instancetype)initWithDelegate:(id<RPSlidingMenuLayoutDelegate>)delegate {
    
    self = [super init];
    if (self){
        _delegate = delegate;
    }

    return self;
}

- (void)prepareLayout {

    [super prepareLayout];

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    NSInteger totalItem = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat totalComputedHeight = ([self collapsedHeight] * (totalItem-1)) + [self featureHeight];
    
    
    CGFloat yOffsetMax = totalComputedHeight - self.collectionView.bounds.size.height;
    CGFloat realItemOffset = yOffsetMax / totalItem;
    
    
    CGFloat itemIndexOffset = self.collectionView.contentOffset.y / realItemOffset;
    

    if(itemIndexOffset > totalItem-1) return;
    if(itemIndexOffset < 0) return;
    
    
    CGFloat featureOffset = itemIndexOffset;
    NSInteger featureIndex = featureOffset;
    double unused;
    CGFloat topCellsInterpolation = modf(featureOffset, &unused);

    //NSLog(@"%f %d %f", featureOffset, featureIndex, topCellsInterpolation);
    
    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];

    CGFloat featureHeight = [self featureHeight];
    CGFloat normalHeight = [self collapsedHeight];

    CGFloat totalHeight = 0.0f;
    
    for (NSInteger itemIndex = 0; itemIndex < totalItem; itemIndex++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];

        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = itemIndex;
        
        
        CGFloat height = normalHeight;
        if(itemIndex == featureIndex) {
            height = featureHeight - ((featureHeight-normalHeight)*topCellsInterpolation);
        } else if(itemIndex == featureIndex+1) {
            height = normalHeight + ((featureHeight-normalHeight)*topCellsInterpolation);
        }
        
        attributes.frame = CGRectMake(0, totalHeight, screenWidth, height);
        
        totalHeight = totalHeight+height;
        
        [layoutAttributes setObject:attributes forKey:indexPath];
    }
    
    self.contentHeight = totalHeight;

    self.layoutAttributes = layoutAttributes;
    
    self.contentIndex = featureIndex;
}

- (CGFloat)currentCellIndex {
    NSInteger totalItem = [self.collectionView numberOfItemsInSection:0];
    CGFloat totalComputedHeight = ([self collapsedHeight] * (totalItem-1)) + [self featureHeight];
    CGFloat itemHeightMoy = totalComputedHeight / totalItem;
    
    CGFloat itemIndexOffset = self.collectionView.contentOffset.y / itemHeightMoy;
    

    return itemIndexOffset;
}

- (CGFloat)featureHeight{

    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForFeatureCell)]){
        return [self.delegate heightForFeatureCell];
    }else{
        return RPSlidingCellFeatureHeight;
    }
}

- (CGFloat)collapsedHeight{

    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForCollapsedCell)]){
        return [self.delegate heightForCollapsedCell];
    }else{
        return RPSlidingCellCollapsedHeight;
    }
}


- (CGSize)collectionViewContentSize {

    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
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

-(CGPoint) targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    NSInteger totalItem = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat totalComputedHeight = ([self collapsedHeight] * (totalItem-1)) + [self featureHeight];
    
    
    CGFloat yOffsetMax = totalComputedHeight - self.collectionView.bounds.size.height;
    CGFloat realItemOffset = yOffsetMax / totalItem;
    
    CGFloat res = proposedContentOffset.y / realItemOffset;
    double unused;
    if(modf(res, &unused) > 0.5) {
        res = ceil(res);
    } else {
        res = floor(res);
    }
    
    CGFloat yOffset = res * realItemOffset;
    
    return CGPointMake(proposedContentOffset.x, yOffset);

}
//}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[indexPath];
}

// bounds change causes prepareLayout if YES
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
