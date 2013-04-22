//
//  MainColorAnalyticsCell.h
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainColorAnalyticsCell : UITableViewCell {
    UILabel *colorNameLabel;
    UILabel *rankingLabel;
    UILabel *likesLabel;
    UILabel *yearLabel;

}

@property (weak, nonatomic) IBOutlet UILabel *colorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end
