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

#import "RPSlidingMenuCell.h"

const CGFloat RPSlidingCellFeatureHeight = 240.0f;
const CGFloat RPSlidingCellCollapsedHeight = 88.0f;
const CGFloat RPSlidingCellDetailTextPadding = 20.0f;
const CGFloat RPSlidingMenuNormalImageCoverAlpha = 0.5f;
const CGFloat RPSlidingMenuFeaturedImageCoverAlpha = 0.2f;

@interface RPSlidingMenuCell ()

@property (strong, nonatomic) UIView *imageCover;

@end

@implementation RPSlidingMenuCell

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setupTextLabel];
        [self setupDetailTextLabel];
        [self setupImageView];
    }

    return self;
}


#pragma - mark label and image view setups

// We do this in code so there is no resources to bundle up

- (void)setupTextLabel {

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenRect.size.width, self.contentView.frame.size.height)];
    self.textLabel.center = self.contentView.center;
    self.textLabel.font = [UIFont boldSystemFontOfSize:32.0];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
}

- (void)setupDetailTextLabel {

    NSAssert(self.textLabel != nil, @"the text label must be set up before this so it can use its frame");
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat startY = self.textLabel.frame.origin.y + self.textLabel.frame.size.height - 40.0f;
    self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(RPSlidingCellDetailTextPadding, startY, screenRect.size.width - (RPSlidingCellDetailTextPadding * 2), self.contentView.frame.size.height - startY)];
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12.0f];
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

    // add a cover that we can fade in a black tint
    self.imageCover = [[UIView alloc] initWithFrame:self.backgroundImageView.frame];
    self.imageCover.backgroundColor = [UIColor blackColor];
    self.imageCover.alpha = 0.6f;
    self.imageCover.autoresizingMask = self.backgroundImageView.autoresizingMask;
    [self.backgroundImageView addSubview:self.imageCover];
    [self.contentView insertSubview:self.backgroundImageView atIndex:0];
    [self.contentView insertSubview:self.imageCover atIndex:1];

}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {

    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat featureNormaHeightDifference = RPSlidingCellFeatureHeight - RPSlidingCellCollapsedHeight;

    // how much its grown from normal to feature
    CGFloat amountGrown = RPSlidingCellFeatureHeight - self.frame.size.height;
    
    // percent of growth from normal to feature
    CGFloat percentOfGrowth = 1 - (amountGrown / featureNormaHeightDifference);
    
    //Curve the percent so that the animations move smoother
    percentOfGrowth = sin(percentOfGrowth * M_PI_2);
    
    CGFloat scaleAndAlpha = MAX(percentOfGrowth, 0.5f);

    // scale title as it collapses but keep origin x the same and the y location proportional to view height.  Also fade in alpha
    self.textLabel.transform = CGAffineTransformMakeScale(scaleAndAlpha, scaleAndAlpha);
    self.textLabel.center = self.contentView.center;

    // keep detail just under text label
    self.detailTextLabel.center = CGPointMake(self.center.x, self.textLabel.center.y + 40.0f);

    // its convenient to set the alpha of the fading controls to the percent of growth value
    self.detailTextLabel.alpha = percentOfGrowth;
    
    // when full size, alpha of imageCover should be 20%, when collapsed should be 90%
    self.imageCover.alpha = RPSlidingMenuNormalImageCoverAlpha - (percentOfGrowth * (RPSlidingMenuNormalImageCoverAlpha - RPSlidingMenuFeaturedImageCoverAlpha));
    
}

@end
