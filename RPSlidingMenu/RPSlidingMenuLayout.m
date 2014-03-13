//
//  RPSlidingMenuLayout.m
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

NSInteger const RPSlidingCellDragInterval = 180.0f;
NSInteger const RPSlidingSection = 0;

#import "RPSlidingMenuLayout.h"
#import "RPSlidingMenuCell.h"

@interface RPSlidingMenuLayout ()

@property (strong, nonatomic) NSDictionary* layoutAttributes;

@end

@implementation RPSlidingMenuLayout

- (void)prepareLayout{

    [super prepareLayout];

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    NSInteger topIndex = [self currentCellIndex];

    CGFloat interpolation =  [self currentCellIndex] - topIndex;

    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;

    CGRect lastRect = CGRectMake(0.0F, 0.0F, screenWidth, RPSlidingCellNormalHeight);
    NSInteger numItems = [self.collectionView numberOfItemsInSection:RPSlidingSection];

    for(NSInteger itemIndex = 0; itemIndex < numItems; itemIndex++){
        indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:RPSlidingSection];

        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = itemIndex;
        CGFloat yValue = 0.0f;

        if (indexPath.row == topIndex){
            CGFloat yOffset = RPSlidingCellNormalHeight* interpolation;
            yValue = self.collectionView.contentOffset.y - yOffset;
            attributes.frame = CGRectMake(0.0f, yValue , screenWidth, RPSlidingCellFeatureHeight);
        }else if (indexPath.row == (topIndex + 1)){
            yValue = lastRect.origin.y + lastRect.size.height;
            CGFloat bottomYValue = yValue + RPSlidingCellNormalHeight;
            CGFloat amountToGrow = MAX((RPSlidingCellFeatureHeight - RPSlidingCellNormalHeight) * interpolation, 0);
            CGFloat newHeight = RPSlidingCellNormalHeight + amountToGrow;
            attributes.frame = CGRectMake(0.0f, bottomYValue - newHeight, screenWidth, newHeight);
        }else{
            yValue = lastRect.origin.y + lastRect.size.height;
            attributes.frame = CGRectMake(0.0f, yValue, screenWidth, RPSlidingCellNormalHeight);
        }
        lastRect = attributes.frame;
        [layoutAttributes setObject:attributes forKey:indexPath];
    }


    self.layoutAttributes = layoutAttributes;
}

- (CGFloat)currentCellIndex{
    return (self.collectionView.contentOffset.y /RPSlidingCellDragInterval);
}


- (CGSize)collectionViewContentSize{
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = numberOfItems * RPSlidingCellDragInterval + RPSlidingCellFeatureHeight ;
    return CGSizeMake(self.collectionView.frame.size.width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *attributesInRect =  [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in [self.layoutAttributes allValues]) {
        if(CGRectIntersectsRect(rect, attributes.frame)){
            [attributesInRect addObject:attributes];
        }
    }

    return attributesInRect;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    CGFloat currentY = self.collectionView.contentOffset.y;
    CGFloat lastPageY =   (NSInteger)(currentY /RPSlidingCellDragInterval) *RPSlidingCellDragInterval;
    CGFloat nextPageY =   lastPageY + RPSlidingCellDragInterval;

    CGPoint restingPoint = CGPointMake(0.0f, 0.0f);
    if ((currentY - lastPageY) < (nextPageY - currentY)){
        restingPoint.y = lastPageY;
    }else{
        restingPoint.y = nextPageY;
    }

    return restingPoint;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutAttributes[indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
