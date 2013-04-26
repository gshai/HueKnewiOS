//
//  ViewController.m
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "IIViewDeckController.h"
#import "SRHUDViewController.h"
#import "SRRightViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appState = START;
    _mag = nil;
    
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [_imageView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    pan.delegate = self;
    [_imageView addGestureRecognizer:pan];
    
    self.overlayViewController =
    [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil] ;
    
    // as a delegate we will be notified when pictures are taken and when to dismiss the image picker
    _overlayViewController.delegate = self;

    // prevent panning of the view
    self.viewDeckController.panningView = _panningView;
    self.viewDeckController.panningMode = IIViewDeckPanningViewPanning;//IIViewDeckNoPanning;
    
    // place btn tray out side of view
    _picBtnsTrayView.frame = CGRectMake(0, self.view.frame.size.height, _picBtnsTrayView.frame.size.width, _picBtnsTrayView.frame.size.height);
    _colorTrayView.frame = CGRectMake(0, self.view.frame.size.height, _colorTrayView.frame.size.width, _colorTrayView.frame.size.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    
    // Slide in the btn tray
    if (appState == START) {
        [self slideInPicBtns];
    }
}

- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [self setPanningView:nil];
    [self setPicBtnsTrayView:nil];
    [self setColorTrayView:nil];
    [super viewDidUnload];
}

#pragma mark - Actions

- (IBAction)photoLibraryAction:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    _sendColorBtn.enabled = NO;
}

- (IBAction)cameraAction:(id)sender {
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    _sendColorBtn.enabled = NO;
}

- (IBAction)sendColor:(id)sender {
    NSLog(@"sendColorBtn");
    
    // get color from colorView
    UIColor *color = _colorView.backgroundColor;
    [self sendColorToHK:color];
}

#pragma mark - Server
- (void)sendColorToHK:(UIColor *)color {
    
    // Start the active disply
    [self startActiveDisplay];
    
    // Translate RGB to integer
    const float* colors = CGColorGetComponents(color.CGColor);
    
    float r = 255*colors[0];
    float g = 255*colors[1];
    float b = 255*colors[2];    
    
    int rgb = 0;
    rgb = rgb + (int)(r);
    rgb = (rgb << 8) + (int)(g);
    rgb = (rgb << 8) + (int)(b);
    
    int javaRGB = -16777216;
    javaRGB = javaRGB + rgb;
    
    NSLog(@"\nRGB :%@ \nint:  %d\n javaRGB: %d", color, rgb, javaRGB );
    

    // Create url and request
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.hue-knew.appspot.com/api/request/color;key=monsieurgiladshai;col=rgb(%d,%d,%d)", (int)r, (int)g, (int)b]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Make request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        appState = HASANALYTICS;
        [self updateVCsWithData:json];
        [self stopActiveDisplay];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);

        appState = HASANALYTICS;
        id json = [self getMockCallback];
        [self updateVCsWithData:json];        
        [self stopActiveDisplay];
    }];
    [operation start];

}

#pragma mark helpers

- (void)startActiveDisplay { 
    _hud = [[SRHUDViewController alloc] initWithColor:_colorView.backgroundColor];
    _hud.view.center = _imageView.center;
    [self.view addSubview:_hud.view];
    [_hud startAnimatingView];
}
- (void)stopActiveDisplay {
    NSLog(@"stopActiveDisplay");
    
    [_hud stopAnimatingView];
    [_hud.view removeFromSuperview];
    [_hud removeFromParentViewController];
    _hud = nil;
    
    self.viewDeckController.panningView = _panningView;
    self.viewDeckController.panningMode = IIViewDeckPanningViewPanning;
}
- (void)updateVCsWithData:(id)json {    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)json];
    NSLog(@"Processing JSON dict: %@", dict);
    
    self.viewDeckController.rightController = [[SRRightViewController alloc] initWithNibName:@"SRRightViewController" bundle:nil andDictionary:dict];
    [(SRRightViewController *)self.viewDeckController.rightController setPrimeColor:_colorView.backgroundColor];

}

#pragma mark Animations
- (void)slideInPicBtns {
    [UIView animateWithDuration:0.5 animations:^{
        _picBtnsTrayView.hidden = NO;
        _picBtnsTrayView.frame = CGRectMake(0, self.view.frame.size.height - _picBtnsTrayView.frame.size.height, _picBtnsTrayView.frame.size.width, _picBtnsTrayView.frame.size.height);
    }];
}
- (void)slideOutPicBtns {
    [UIView animateWithDuration:0.3 animations:^{
        _picBtnsTrayView.frame = CGRectMake(0, self.view.frame.size.height, _picBtnsTrayView.frame.size.width, _picBtnsTrayView.frame.size.height);
    }completion:^(BOOL finished) {
        _picBtnsTrayView.hidden = YES;
    }];
}
- (void)slideInColorTray {
    [UIView animateWithDuration:0.5 animations:^{
        _colorTrayView.hidden = NO;
        _colorTrayView.frame = CGRectMake(0, self.view.frame.size.height - _colorTrayView.frame.size.height, _colorTrayView.frame.size.width, _colorTrayView.frame.size.height);
    }];
}
- (void)slideOutColorTray {
    [UIView animateWithDuration:0.3 animations:^{
        _colorTrayView.frame = CGRectMake(0, self.view.frame.size.height, _colorTrayView.frame.size.width, _colorTrayView.frame.size.height);
    }completion:^(BOOL finished) {
        _colorTrayView.hidden = YES;
    }];
}


#pragma mark - Photo Library

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (_imageView.isAnimating) {
        [_imageView stopAnimating];
    }
	    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self.overlayViewController setupImagePicker:sourceType];
        [self presentModalViewController:_overlayViewController.imagePickerController animated:YES];
    }
}


#pragma mark - Magnifier
- (void)createMagnifierWithPoint:(CGPoint)point {
    if (nil != _mag) {
        return;
    }
    
    NSLog(@"create mag");
    _mag = [[MagnifierView alloc] init];
    _mag.viewToMagnify = _imageView;
    _mag.delegate = self;
    _mag.touchPoint = point;
}


#pragma mark - Magnifier Protocol

- (void)updateWithColor:(UIColor *)color {
    [_colorView setBackgroundColor:color];
}


#pragma mark - Overlay Protocol

- (void)didTakePicture:(UIImage *)picture {
    NSLog(@"didTakePicture");
    
    if (!picture) {
        NSLog(@"picture is nil");
        return;
    }
    [self deviceBackWithImage:picture];
}

- (void)didFinishWithPicker {
    NSLog(@"didFinishWithPicker - dismiss it");
    [self dismissModalViewControllerAnimated:YES];
}

- (void)deviceBackWithImage:(UIImage *)picture {
    if (!picture) {
        NSLog(@"Error - we don't have an image to present");
        return;
    }
    
    // update state
    appState = IMAGEINVIEW;
    
    // update image
    [_imageView setImage:picture];
    
    // set view
    [self slideOutPicBtns];
    [self slideInColorTray];

    [self createMagnifierWithPoint:self.view.center];
    [self.view addSubview:_mag];
    [self.view bringSubviewToFront:_mag];

}

#pragma mark - Gestures Protocol

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapDetected");

    if (appState == START) {
        // Slide in or out the camera btns tray
        if (_picBtnsTrayView.hidden) {
            [self slideInPicBtns];
        } else {
            [self slideOutPicBtns];
        }
    } else if (appState == IMAGEINVIEW) {
        if (_picBtnsTrayView.hidden) {
            [self slideOutColorTray];
            [self slideInPicBtns];
        } else {
            [self slideOutPicBtns];
            [self slideInColorTray];
        }
    } else if (appState == HASANALYTICS) {
    if (_picBtnsTrayView.hidden) {
        [self slideOutColorTray];
        [self slideInPicBtns];
    } else {
        [self slideOutPicBtns];
        [self slideInColorTray];
    }
}

}

- (void)panDetected:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:_imageView];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"started the drag");
        }
            break;
        case UIGestureRecognizerStateChanged: {            
//            NSLog(@"dragging x:%f y: %f", point.x, point.y);
            _mag.touchPoint = point;
            [_mag setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateEnded: {            
            NSLog(@"drag ended");
            _sendColorBtn.enabled = YES;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Mockup

//reply to //www.hue-knew.appspot.com/api/request/color;key=monsieurgiladshai;col=rgb(234,23,56)
- (NSDictionary *)getMockCallback {
    NSDictionary *dict = [self dictionaryWithContentsOfJSONString:@"color.json"];
    return dict;
}
-(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}
@end
