//
//  RPSlidingMenuCell.h
//  RPSlidingMenu
//
//  Created by Paul Thorsteinson on 2/7/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

extern CGFloat const RPSlidingCellFeatureHeight;
extern CGFloat const RPSlidingCellNormalHeight;


@interface RPSlidingMenuCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *detailTextLabel;
@property (strong, nonatomic) UIImage *image;

@end
