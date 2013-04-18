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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
