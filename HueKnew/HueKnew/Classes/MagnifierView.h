//
//  MagnifierView.h
//  HueKnew
//
//  Created by Shai, Gilad on 4/18/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorOfPoint <NSObject>
- (void)updateWithColor:(UIColor *)color;
@end


@interface MagnifierView : UIView
<UIGestureRecognizerDelegate>

@property (nonatomic, strong)   UIView  *viewToMagnify;
@property (nonatomic, strong)   NSObject<ColorOfPoint> *delegate;
@property (assign, nonatomic)              CGPoint touchPoint;


@end
