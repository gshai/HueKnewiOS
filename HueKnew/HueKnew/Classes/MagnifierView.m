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
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	_touchPoint = pt;
    
	// update the position of the magnifier
	self.center = CGPointMake(pt.x, pt.y-60);
}

- (void)drawRect:(CGRect)rect {

    // Magnify the view
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 3, 3);
	CGContextTranslateCTM(context,-1*(_touchPoint.x),-1*(_touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
    
    // get color in the middle of the magnifier
    UIColor *color = [self colorOfPoint:CGPointMake(rect.size.width/2, rect.size.height/2)];
    
    if ([_delegate respondsToSelector:@selector(updateWithColor:)]) {
        [_delegate updateWithColor:color];
    }
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
@end