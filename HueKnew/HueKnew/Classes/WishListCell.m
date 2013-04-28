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
    [_wishListImageView setImage:image];
}

- (void)slideOutImage {
    NSLog(@"slideOut Image");
    
    [UIView animateWithDuration:1.0 animations:^{
        _wishListImageView.center = CGPointMake(self.frame.size.width*0.75, _wishListImageView.center.y);
        _aLabel.center = CGPointMake(self.frame.size.width, _aLabel.center.y);
    } completion:^(BOOL finished) {
        NSLog(@"done animation out");
    }];
}
- (void)slideInImage {
    NSLog(@"slide in Image");
    
    [UIView animateWithDuration:1.0 animations:^{
        _wishListImageView.center = CGPointMake(self.frame.size.width/2, _wishListImageView.center.y);
        _aLabel.center = CGPointMake(self.frame.size.width/2, _aLabel.center.y);
    } completion:^(BOOL finished) {
        NSLog(@"done animation in");
    }];
    
    
}

- (IBAction)saveImage:(id)sender {
    NSLog(@"save image");
    [self slideInImage];
}


@end
