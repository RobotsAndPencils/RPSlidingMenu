//
//  RPSlidingMenuCell.m
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPSlidingMenuCell.h"

CGFloat const RPSlidingCellFeatureHeight = 240.0f;
CGFloat const RPSlidingCellNormalHeight = 88.0f;

@interface RPSlidingMenuCell ()

@property (strong, nonatomic) UIImageView *backgroundImageView;
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

- (void)setImage:(UIImage *)image {

    _image = image;
    self.backgroundImageView.image = image;
}


- (void)setupTextLabel {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenRect.size.width, self.contentView.frame.size.height)];
    self.textLabel.center = self.contentView.center;
    self.textLabel.font = [UIFont boldSystemFontOfSize:32.0];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight);
    [self.contentView addSubview:self.textLabel];
}

CGFloat RPSlidingDetailTextPadding = 20.0f;

- (void)setupDetailTextLabel{

    NSAssert(self.textLabel != nil, @"the text label must be set up before this so it can use its frame");
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat startY = self.textLabel.frame.origin.y + self.textLabel.frame.size.height-40;
    self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(RPSlidingDetailTextPadding, startY, screenRect.size.width - (RPSlidingDetailTextPadding*2), self.contentView.frame.size.height - startY)];
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.detailTextLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    self.detailTextLabel.autoresizingMask = self.textLabel.autoresizingMask;
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

    CGFloat scale = self.contentView.frame.size.height /RPSlidingCellFeatureHeight;
    self.textLabel.transform = CGAffineTransformMakeScale(scale, scale);
    self.imageCover.alpha = 1.0f - scale;

}

@end
