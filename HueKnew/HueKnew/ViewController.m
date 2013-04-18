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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendColor:(id)sender {
    
    // get color from colorView
    UIColor *color = _colorView.backgroundColor;
    [self sendColorToHK:color];
}

- (void)sendColorToHK:(UIColor *)color {
    
    // Translate RGB to integer
    const float* colors = CGColorGetComponents(color.CGColor);
    int rgb = (int)(colors[0]*255);
    rgb = (rgb << 8) + ((int)colors[1])*255;
    rgb = (rgb << 8) + ((int)colors[2])*255;

    // Create url and request
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.hue-knew.appspot.com/api/request/color;key=something;col=%d", rgb]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Make request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];

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
    NSLog(@"update with color %@", color);
    [_colorView setBackgroundColor:color];
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
        }
            break;
            
        default:
            break;
    }
}
@end
