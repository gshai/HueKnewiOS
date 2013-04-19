//
//  ViewController.h
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagnifierView.h"
#import <AudioToolbox/AudioServices.h>
#import "OverlayViewController.h"


@interface ViewController : UIViewController
<UIGestureRecognizerDelegate, ColorOfPoint, UIImagePickerControllerDelegate>

@property (strong, nonatomic) OverlayViewController *overlayViewController;
@property (strong, nonatomic) IBOutlet UIButton *sendColorBtn;
@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) MagnifierView *mag;

@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;
@property (strong, nonatomic) IBOutlet UIButton *albumsBtn;

- (IBAction)photoLibraryAction:(id)sender;
- (IBAction)cameraAction:(id)sender;

- (IBAction)sendColor:(id)sender;
- (void)sendColorToHK:(UIColor *)color;
- (void)updateWithColor:(UIColor *)color;
@end
