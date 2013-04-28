//
//  CityColorAnalyticsCell.h
//  HueKnew
//
//  Created by Not Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Not Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UITableViewCell {

}

@property (weak, nonatomic) IBOutlet UILabel *wishListLabel;
@property (strong, nonatomic) IBOutlet UIImageView *wishListImageView;

- (void)initWithImageURL:(NSURL *)imageURL reuseIdentifier:(NSString *)reuseIdentifier;

@end
