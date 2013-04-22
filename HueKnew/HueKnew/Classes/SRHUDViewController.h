//
//  SRHUDViewController.h
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRHUDViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIView *animationCapsule;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;

- (id)initWithColor:(UIColor *)color;
- (void)startAnimatingView;
- (void)stopAnimatingView;
@end
