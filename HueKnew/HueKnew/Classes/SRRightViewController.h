//
//  SRRightViewController.h
//  ScanForGood
//
//  Created by Gilad Shai on 3/9/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SRRightViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *designerCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *mainCell;
@property (strong, nonatomic) NSDictionary *configDict;
@property (strong, nonatomic) UIColor *primeColor;

- (void)configWithJSON:(id)json;
- (void)configWithDict:(NSDictionary *)dict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andDictionary:(NSDictionary *)dict;
@end
