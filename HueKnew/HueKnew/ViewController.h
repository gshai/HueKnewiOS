//
//  ViewController.h
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *sendColorBtn;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;



- (IBAction)sendColor:(id)sender;
- (void)sendColorToHK:(UIColor *)color;

@end
