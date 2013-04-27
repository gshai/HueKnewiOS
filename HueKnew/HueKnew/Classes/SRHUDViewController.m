//
//  SRHUDViewController.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "SRHUDViewController.h"

@interface SRHUDViewController () {
    BOOL isAnimating;
}
@end

@implementation SRHUDViewController


- (id)initWithColor:(UIColor *)color {
    self = [super initWithNibName:@"SRHUDViewController" bundle:nil];
    
//    self = [[[NSBundle mainBundle] loadNibNamed:@"SRHUDViewController" owner:self options:nil] objectAtIndex:0];
    if (self) {
        _colorView.backgroundColor = color;
        isAnimating = NO;
        _titleLabel.font = [UIFont fontWithName:@"Eurostile LT Demi.ttf" size:23];
    }
    return self;


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setColorView:nil];
    [self setAnimationCapsule:nil];
    [self setCounterLabel:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}

- (void)startAnimatingView {
    
    UIImageView *element = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hudElement.png"]];
    float wCapsule = _animationCapsule.frame.size.width;
    float wEntity = element.frame.size.width;
    isAnimating = YES;
    
    for (int i = 0; i < wCapsule/wEntity; i++) {
        [self addElement:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hudElement.png"]] atOffset:(float)(i*wEntity)];
    }
}

- (void)stopAnimatingView {
    isAnimating = NO;
    [self removeElements];
}

- (void)addElement:(UIImageView *)element atOffset:(float)x {    
    
    [_animationCapsule addSubview:element];
    element.center = CGPointMake(x, element.center.y);
    float duration = 3.0*(_animationCapsule.frame.size.width - x)/_animationCapsule.frame.size.width;
    NSLog(@"duration: %f for offset: x: %f", duration, x);
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         element.center = CGPointMake(_animationCapsule.frame.size.width+element.frame.size.width/2, element.center.y);
                     }
                     completion:^(BOOL finished){
                         [element removeFromSuperview];
                         UIImageView *element2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hudElement.png"]];
                         if (isAnimating) {
                             [self addElement:element2 atOffset:-0.5*element.frame.size.width];
                         }     
                     }
     ];
}

- (void)removeElements {
    NSLog(@"removeElements");
    for (UIImageView *element in [_animationCapsule subviews]) {
        [element stopAnimating];
        [element removeFromSuperview];
    }
}

@end
