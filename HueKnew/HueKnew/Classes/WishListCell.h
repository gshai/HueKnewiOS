//
//  CityColorAnalyticsCell.h
//  HueKnew
//
//  Created by Not Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Not Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UITableViewCell <UIGestureRecognizerDelegate>{

}


@property (strong, nonatomic) IBOutlet UIImageView *wishListImageView;
@property (strong, nonatomic) IBOutlet UILabel *aLabel;

- (void)initWithImageURL:(NSURL *)imageURL reuseIdentifier:(NSString *)reuseIdentifier;

- (void)slideOutImage;
- (void)slideInImage;
- (IBAction)saveImage:(id)sender;

@end
