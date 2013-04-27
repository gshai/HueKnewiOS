//
//  MagnifierView.m
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 80, 80)]) {
		
        // make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 3;
		self.layer.cornerRadius = 40;
		self.layer.masksToBounds = YES;
        
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.delegate = self;
        [self addGestureRecognizer:tapRecognizer];

	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	_touchPoint = pt;
    
	// update the position of the magnifier
	self.center = CGPointMake(pt.x, pt.y-60);
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
    
    /*
        // Magnify the view
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 1*(self.frame.size.width*0.5), 1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 3, 3);
	CGContextTranslateCTM(context, -1*(_touchPoint.x), -1*(_touchPoint.y));
	[_layerToMagnify renderInContext:context];
    */
    
        // get color in the middle of the magnifier
    UIColor *color = [self colorOfPoint: _touchPoint]; // CGPointMake(rect.size.width/2, rect.size.height/2)];
    
        // call the delegate
    if ([_delegate respondsToSelector:@selector(updateWithColor:)]) {
        [_delegate updateWithColor:color];
    }
    
        // render the color in place
    [self setBackgroundColor:color];
}

- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [_layerToMagnify renderInContext:context];
    
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
    if ([_delegate respondsToSelector:@selector(eventWithColor:)]) {
        [_delegate eventWithColor:self.backgroundColor];
    }

 
}

@end
