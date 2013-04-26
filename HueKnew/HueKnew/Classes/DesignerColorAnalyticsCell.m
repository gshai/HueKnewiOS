//
//  DesignerColorAnalyticsCell.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "DesignerColorAnalyticsCell.h"
#define BAR_WIDTH  60.0

@implementation DesignerColorAnalyticsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"initing cell");
        
    }
    return self;
}

- (BOOL)configureWithDictionary:(NSDictionary *)config {
    BOOL isValid = YES;
    NSLog(@"setting Designer cell with : %@", config);
/*
    "name": "LANVIN",
    "season": "Fall 2013",
    "topsPercent": 37,
    "bottomsPercent": 22
  */
    _designerNameLabel.text = [config objectForKey:@"name"];
    _seasonLabel.text = [config objectForKey:@"season"];

    float sTop = [[config objectForKey:@"topsPercent"] floatValue] / 100.0;
    float sBottom = [[config objectForKey:@"bottomsPercent"] floatValue] / 100.0;

    _wView.frame = CGRectMake(_wView.frame.origin.x, _wView.frame.origin.y, BAR_WIDTH*sTop, _wView.frame.size.height);
    _mView.frame = CGRectMake(_mView.frame.origin.x, _mView.frame.origin.y, BAR_WIDTH*sBottom, _mView.frame.size.height);

    return isValid;
}

@end
