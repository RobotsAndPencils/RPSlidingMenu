RPSlidingMenu
=============

A collection view menu in the style of UltraVisual.


![RPSlidingMenu animated GIF](http://f.cl.ly/items/1P0l1X0D0b2k1C3T2C2o/2014-03-14%2011_39_36.gif)

[Youtube Video](http://www.youtube.com/watch?v=jUsxavJp4l8)

## Installation

### From CocoaPods

Add `pod 'RPSlidingMenu'` to your Podfile

## Usage

(see sample Xcode project in `/Demo`)

Create a new file that inherits from RPSlidingMenuViewController

Override the following methods:
```objc
// return the number of menu items
- (NSInteger)numberOfItemsInSlidingMenu;
// set properties of the cell like the textLabel.text, detailLabel.text and backgroundImageView.image
- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row;
// optionally to handle a menu item being tapped
- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row;
```

##Example of code in .m
```objc
- (NSInteger)numberOfItemsInSlidingMenu {
    return 10; // 10 menu items
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row {
    slidingMenuCell.textLabel.text = @"Some Title";
    slidingMenuCell.detailTextLabel.text = @"Some longer description that is like a subtitle!";
    slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"some_image"];

}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row {
    // when a row is tapped do some action like go to another view controller
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Tapped"
                                                    message:[NSString stringWithFormat:@"Row %d tapped.", row]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
```

##Notes

- In the demo I used images that were 320x210.  They just need to be big enough to cover the cells size

## Contact

[![Robots & Pencils Logo](http://f.cl.ly/items/2W3n1r2R0j2p2b3n3j3c/rnplogo.png)](http://www.robotsandpencils.com)

Follow Robots & Pencils on Twitter ([@robotsNpencils](https://twitter.com/robotsNpencils))

### Maintainers

- [Paul Thorsteinson](http://github.com/paulthorsteinson) ([@codezy](https://twitter.com/codezy))
- [Stephen Gazzard](http://github.com/stephengazzard) ([@BrokenKings](https://twitter.com/BrokenKings))
- [Brandon Evans](http://github.com/interstateone) ([@interstateone](https://twitter.com/interstateone))

## License

RPSlidingMenu is available under the MIT license. See the LICENSE file for more info.
