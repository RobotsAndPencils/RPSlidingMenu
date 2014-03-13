//
//  RPSlidingMenuCell.m
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPSlidingMenuCell.h"

const CGFloat RPSlidingCellFeatureHeight = 240.0f;
const CGFloat RPSlidingCellNormalHeight = 88.0f;
const CGFloat RPSlidingCellDetailTextPadding = 20.0f;

@interface RPSlidingMenuCell ()

@property (strong, nonatomic) UIView *imageCover;

@end

@implementation RPSlidingMenuCell

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setupTextLabel];
        [self setupDetailTextLabel];
        [self setupImageView];
    }

    return self;
}


- (void)setupTextLabel {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenRect.size.width, self.contentView.frame.size.height)];
    self.textLabel.center = self.contentView.center;
    self.textLabel.font = [UIFont boldSystemFontOfSize:32.0];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
}



- (void)setupDetailTextLabel{

    NSAssert(self.textLabel != nil, @"the text label must be set up before this so it can use its frame");
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat startY = self.textLabel.frame.origin.y + self.textLabel.frame.size.height-40;
    self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(RPSlidingCellDetailTextPadding, startY, screenRect.size.width - (RPSlidingCellDetailTextPadding*2), self.contentView.frame.size.height - startY)];
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.detailTextLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.detailTextLabel];
}

- (void)setupImageView {

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenRect.size.width, RPSlidingCellFeatureHeight)];
    self.backgroundImageView.clipsToBounds = YES;
    self.backgroundImageView.center = self.contentView.center;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;


    self.imageCover= [[UIView alloc] initWithFrame:self.backgroundImageView.frame];
    self.imageCover.backgroundColor = [UIColor blackColor];
    self.imageCover.alpha = 0.6f;
    self.imageCover.autoresizingMask = self.backgroundImageView.autoresizingMask;
    [self.backgroundImageView addSubview:self.imageCover];
    [self.contentView insertSubview:self.backgroundImageView atIndex:0];
    [self.contentView insertSubview:self.imageCover atIndex:1];

}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    CGFloat featureNormaHeightDifference = RPSlidingCellFeatureHeight - RPSlidingCellNormalHeight;
    // how much its grown from normal to feature
    CGFloat amountGrown = RPSlidingCellFeatureHeight - self.frame.size.height;
    
    // percent of growth from normal to feature
    CGFloat percentOfGrowth = 1 - (amountGrown / featureNormaHeightDifference);
    CGFloat scale = MAX(percentOfGrowth, .5);
    
    // scale title as it collapses but keep origin x the same and the y location proportional to view height.  Also fade in alpha
    self.textLabel.transform = CGAffineTransformMakeScale(scale, scale);
    self.textLabel.center = self.contentView.center;
    
    self.detailTextLabel.center = CGPointMake(self.center.x, self.textLabel.center.y + 40.0f);
    
    self.detailTextLabel.alpha = MAX(percentOfGrowth, .5);
    
    // when full size, alpha of imageCover should be 20%, when collapsed should be 90%
    self.imageCover.alpha = .50f - (percentOfGrowth * .30f);
    
    // its convenient to set the alpha of the fading controls to the percent of growth value
    self.detailTextLabel.alpha = percentOfGrowth;
    
}

@end
