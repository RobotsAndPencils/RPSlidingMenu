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

/**
 RPSlidingMenuViewController is a subclass of UICollectionViewController that is supplies methods that can be overridden to supply the number of items in the menu, customize the menu cell and also to react to a menu item being tapped.
 */
@interface RPSlidingMenuViewController : UICollectionViewController

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
 Called when one of the rows in the RPSlidingMenu is tapped.
 
 @param slidingMenu the sliding menu that called this.
 
 @param row The row that relates to the data on the row that was tapped.
 
 */
- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row;

/**
 Scrolls the cells so that the item at the index path is featured
 
 @param row The row of the cell to feature
 
 @param animated Whether or not to animate the scroll

 */
- (void)scrollToRow:(NSInteger)row animated:(BOOL)animated;

@end
