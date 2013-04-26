//
//  DesignerColorAnalyticsCell.m
//  HueKnew
//
//  Created by Gilad Shai on 4/21/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesignerColorAnalyticsCell : UITableViewCell {

}

@property (strong, nonatomic) IBOutlet UILabel *seasonLabel;
@property (strong, nonatomic) IBOutlet UILabel *designerNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderIV;
@property (strong, nonatomic) IBOutlet UIView *wView;
@property (strong, nonatomic) IBOutlet UIView *mView;



- (BOOL)configureWithDictionary:(NSDictionary *)config;

@end
