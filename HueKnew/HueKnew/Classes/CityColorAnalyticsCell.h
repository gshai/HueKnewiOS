//
//  CityColorAnalyticsCell.h
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityColorAnalyticsCell : UITableViewCell {

}
@property (strong, nonatomic) IBOutlet UILabel *precLabel1;
@property (strong, nonatomic) IBOutlet UILabel *precLabel2;
@property (strong, nonatomic) IBOutlet UILabel *precLabel3;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel1;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel2;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel3;

- (BOOL)configureWithArray:(NSArray *)config;

@end
