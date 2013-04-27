//
//  CityColorAnalyticsCell.m
//  HueKnew
//
//  Created by Not Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Not Shai, Gilad. All rights reserved.
//

#import "WishListCell.h"

@implementation WishListCell
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

- (BOOL)configureWithArray:(NSArray *)config {
    BOOL isValid = YES;
    NSLog(@"setting Citys cell with : %@", config);
    
    _precLabel1.text = [[config[0] objectForKey:@"percent"] stringValue];
    _precLabel2.text = [[config[1] objectForKey:@"percent"] stringValue];
    _precLabel3.text = [[config[2] objectForKey:@"percent"] stringValue];
    _cityLabel1.text = [config[0] objectForKey:@"name"];
    _cityLabel2.text = [config[1] objectForKey:@"name"];
    _cityLabel3.text = [config[2] objectForKey:@"name"];
    
    
    return isValid;
}

@end
