//
//  ViewController.m
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.hue-knew.appspot.com/api/request/color;key=something;col=%d", javaRGB]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Make request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        [self stopActiveDisplay];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        [self stopActiveDisplay];
    }];
    [operation start];

}

#pragma mark helpers
- (void)startActiveDisplay {
    [_activityIndicator setHidden:NO];
    [_activityIndicator startAnimating];
}
- (void)stopActiveDisplay {
    [_activityIndicator setHidden:YES];
    [_activityIndicator stopAnimating];
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
    if (!picture) {
        NSLog(@"picture is nil");
        return;
    }
    
    [_imageView setImage:picture];
}

- (void)didFinishWithCamera {
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"should present the new image");
//    [_imageView setImage:picture];
}


#pragma mark - Gestures Protocol

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapDetected");
    // create or destroy magnifier
    
}

- (void)panDetected:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:_imageView];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"started the drag");
            [self createMagnifierWithPoint:point];
            [_imageView addSubview:_mag];
            [_imageView bringSubviewToFront:_mag];
        }
            break;
        case UIGestureRecognizerStateChanged: {            
            NSLog(@"dragging x:%f y: %f", point.x, point.y);
            _mag.touchPoint = point;
            [_mag setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateEnded: {            
            NSLog(@"drag ended");
            [_mag removeFromSuperview];
            _mag = nil;
            _sendColorBtn.enabled = YES;
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}
@end
