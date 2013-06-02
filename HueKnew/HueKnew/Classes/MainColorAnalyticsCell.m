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
- (BOOL)configureWithDictionary:(NSDictionary *)config {
    BOOL isValid = YES;
    NSLog(@"setting main cell with : %@", config);
    
    _colorNameLabel.text = [config objectForKey:@"name"];
    _rankingLabel.text = [NSString stringWithFormat:@"Ranking %@",[[config objectForKey:@"ranking"] stringValue]];
    _likesLabel.text = [NSString stringWithFormat:@"Likes %@",[[config objectForKey:@"likes"]stringValue]];
    _yearLabel.text = [config objectForKey:@"year"];
    _colorP0.text = [[config objectForKey:@"percent"] stringValue];
    
    // Should do this part progrematicly 
    NSArray *subcolors = [config objectForKey:@"subcolors"];
    _colorP1.text = [[subcolors[0] objectForKey:@"percent"] stringValue];
    _colorP2.text = [[subcolors[1] objectForKey:@"percent"] stringValue];
    _colorP3.text = [[subcolors[2] objectForKey:@"percent"] stringValue];
    
    for (int i = 0; i<3; i++) {
        float r = [[subcolors[i] objectForKey:@"r"] floatValue] / 255.0;
        float g = [[subcolors[i] objectForKey:@"g"] floatValue] / 255.0;
        float b = [[subcolors[i] objectForKey:@"b"] floatValue] / 255.0;
        UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1];
        UIView *view = [self viewWithTag:i+10];
        [view setBackgroundColor:color];
        NSLog(@"set color : %@ for tag : %d", color, 10+i);
    }
/*
    NSString *rgb = [[config objectForKey:@"rgb"]stringByReplacingOccurrencesOfString:@" " withString:@""];
    //TODO - fix the color convertor

    float r = [[self findSubString:rgb btw:@"(" and:@","] floatValue];
    float g = [[self findSubString:rgb btw:@"," and:@","] floatValue];
    float b = [[self findSubString:rgb btw:@"," and:@")"] floatValue];
    NSLog(@"colors: %f %f %f", r,g,b);
*/
//    UIColor *mainColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];    
//    self.contentView.backgroundColor = mainColor;
   
    return isValid;
}

- (NSString *)findSubString:(NSString *)myString btw:(NSString *)sub1 and:(NSString*)sub2 {
    
    int firstMatch = [myString rangeOfString:sub1].location;
    int secondMatch = [myString rangeOfString:sub2 options:0 range:NSMakeRange(firstMatch+1 , [myString length] - firstMatch - 1)].location;
    
    NSRange range = NSMakeRange(firstMatch+1, secondMatch-firstMatch-1);
    NSString *str = [myString substringWithRange:range];
    
    myString = [myString substringFromIndex:secondMatch];
    NSLog(@"return: str %@ short to : %@", str, myString);
    
    return str;
}

/*
- (NSRange)findString:(NSString *)myString withPattern:(NSRegularExpression *)regex  {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\"])(?:\\\\\\1|.)*?\\1" options:0 error:&error];

    NSRange range = [regex rangeOfFirstMatchInString:myString options:0 range:NSRangeMake(0,[myString length])];
    
    return range;
}
 */
@end
