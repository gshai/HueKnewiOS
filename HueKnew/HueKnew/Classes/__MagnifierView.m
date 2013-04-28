//
//  MagnifierView.m
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

#define xX      43.0
#define yX      18.0

@implementation MagnifierView

- (id)initWithFrame:(CGRect)frame {
    NSLog(@"init mag");
	if (self = [super initWithFrame:CGRectMake(0, 0, 87, 150)]) {
		
        // load the magnifier image
        UIImageView *imV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mag.png"]];
        
        [self addSubview:imV];
        imV.center = self.center;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.delegate = self;
        [self addGestureRecognizer:tapRecognizer];

	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
    
	// update the position of the magnifier
	self.center = CGPointMake(pt.x + 50 - xX, pt.y -75 + yX);
    
    // sample color at X
    UIColor *color = [self colorOfView:_viewToMagnify atPoint:pt]; //CGPointMake(43, 133)];
    if ([_delegate respondsToSelector:@selector(updateWithColor:)]) {
        [_delegate updateWithColor:color];
    }

}

- (UIColor *) colorOfView:(UIView *)aView atPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [aView.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}
- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"magnifier - tapDetected");
}



@end
