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

#import <UIKit/UIKit.h>
#import "RPSlidingMenuCell.h"

@class RPSlidingMenuLayout;

/**
 RPSlidingMenuViewController is a subclass of UICollectionViewController that is supplies methods that can be overridden to supply the number of items in the menu, customize the menu cell and also to react to a menu item being tapped.
 */
@interface RPSlidingMenuViewController : UICollectionViewController

/**
 The height cells should be when featured.  Defaults to RPSlidingCellFeatureHeight
 */
@property (nonatomic) CGFloat featureHeight;

/**
 The height cells should be when collapsed.  Defaults to RPSlidingCellCollapsedHeight
 */
@property (nonatomic) CGFloat collapsedHeight;

/**
 If yes when a user taps on a collapsed row it will expand it to the feature spot. If no it remains in the same position.  Default is YES.
 */
@property (nonatomic) BOOL scrollsToCollapsedRowsOnSelection;

/**
 Returns the number of items(cells) that are in the sliding menu.
 
 @return the number of rows desired in the RPSlidingMenu
 
 */
- (NSInteger)numberOfItemsInSlidingMenu;

/**
 Gives you a chance to customize the cell at the given row. To set a header set the textLabel.text, a description goes in the detailTextlabel.text and background image in backgroundImageView.image.
 
 @param slidingMenuCell The RPSlidingMenuCell that will be displayed at that row and can be customized at this point.
 
 @param row The row that relates to the data being shown.
 
 */
- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row;

/**
 Called when one of the rows in the RPSlidingMenu is tapped. Requires call to super for animating to that row on collapsed selection
 
 @param slidingMenu the sliding menu that called this.
 
 @param row The row that relates to the data on the row that was tapped.
 
 */
- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row;

@end
