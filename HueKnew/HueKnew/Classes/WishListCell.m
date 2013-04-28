//
//  CityColorAnalyticsCell.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "WishListCell.h"

@implementation WishListCell

- (void)initWithImageURL:(NSURL *)imageURL reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"imageURL = %@", imageURL);
    NSData *data = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.wishListImageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.image = image;
}



@end
