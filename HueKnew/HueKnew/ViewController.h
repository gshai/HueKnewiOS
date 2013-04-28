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
#import "SRHUDViewController.h"
#import "CaptureSessionManager.h"

typedef enum {
    START,
    IMAGEINVIEW,
    HASANALYTICS,
} APPSTATE;

typedef enum {
    VIDEO,
    IMAGE,

} IMAGESTATE;


@interface ViewController : UIViewController
<UIGestureRecognizerDelegate,
ColorOfPoint,
UIImagePickerControllerDelegate,
OverlayViewControllerDelegate> {
    APPSTATE appState;
    IMAGESTATE imageState;
}

@property (strong, nonatomic) OverlayViewController *overlayViewController;
//@property (strong, nonatomic) IBOutlet UIButton *sendColorBtn;
@property (strong, nonatomic) UIColor *localColor;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) MagnifierView *mag;

@property (strong, nonatomic) IBOutlet UIView *picBtnsTrayView;
@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;
@property (strong, nonatomic) IBOutlet UIButton *albumsBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *panningView;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIImageView *magIV;
@property (strong, nonatomic) IBOutlet UIView *womenIconsView;
@property (strong, nonatomic) IBOutlet UIView *menIconsView;

@property (strong, nonatomic) SRHUDViewController *hud;
@property (strong, nonatomic) NSTimer *timer;
@property (strong) CaptureSessionManager *captureManager;

- (IBAction)photoLibraryAction:(id)sender;
- (IBAction)cameraAction:(id)sender;
- (IBAction)selectFashionItem:(id)sender;

//- (IBAction)sendColor:(id)sender;
- (void)sendColorToHK:(UIColor *)color;

// Magnifier
- (void)updateWithColor:(UIColor *)color;
- (void)eventWithColor:(UIColor *)color;
@end
