//
//  MainColorAnalyticsCell.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "MainColorAnalyticsCell.h"

@implementation MainColorAnalyticsCell
@synthesize colorNameLabel = _colorNameLabel;
@synthesize rankingLabel = _rankingLabel;
@synthesize likesLabel = _likesLabel;
@synthesize yearLabel = _yearLabel;

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
