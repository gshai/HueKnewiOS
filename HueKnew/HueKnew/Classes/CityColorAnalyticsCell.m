//
//  CityColorAnalyticsCell.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "CityColorAnalyticsCell.h"

@implementation CityColorAnalyticsCell
@synthesize precLabel1 = _precLabel1;
@synthesize precLabel2 = _precLabel2;
@synthesize precLabel3 = _precLabel3;
@synthesize cityLabel1 = _cityLabel1;
@synthesize cityLabel2 = _cityLabel2;
@synthesize cityLabel3 = _cityLabel3;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"initing cell");
        
    }
    return self;
}

@end
