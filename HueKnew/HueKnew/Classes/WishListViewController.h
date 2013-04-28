//
//  WishListViewController.h
//  HueKnew
//
//  Created by Gilad Shai on 4/25/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListViewController : UITableViewController  <UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSArray *items;
@end
