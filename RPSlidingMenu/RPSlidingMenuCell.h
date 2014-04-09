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

/**
 The height of a RPSlidingCell when it is at it's full feature height.
 */
extern const CGFloat RPSlidingCellFeatureHeight;

/**
 The height of a RPSlidingCell when it is at it's normal height.
 */
extern const CGFloat RPSlidingCellCollapsedHeight;

/**
 RPSlidingMenu is a subclass of UICollectionViewCell that is used for displaying rows in a RPSlidingMenuViewController.  It has a textLabel that can be set to show a header title for the cell.  It also has a detailTextLabel where a longer description can follow the textLabel header.  The backgroundImageView allows an image to be set behind it.  This cell has text that fades and shrink as it goes from feature height to normal height
 */
@interface RPSlidingMenuCell : UICollectionViewCell

/**
 The topmost centered label that is used like a header for the cell.  The label grows as it approaches feature height
 */
@property (strong, nonatomic) UILabel *textLabel;

/**
 The bottommost centered label that is used for a description for the cell.  The label fades in as it approaches feature height
 */
@property (strong, nonatomic) UILabel *detailTextLabel;

/**
 The background image view of the cell.  Set this to supply an image that is centered in the cell. It is covered by a black view that has varying alpha depending on the cell size.
 */
@property (strong, nonatomic) UIImageView *backgroundImageView;

@end
