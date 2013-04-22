//
//  SRRightViewController.m
//  ScanForGood
//
//  Created by Gilad Shai on 3/9/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import "SRRightViewController.h"
#import "IIViewDeckController.h"
#import "ViewController.h"
#import "MainColorAnalyticsCell.h"

@interface SRRightViewController ()

@end

@implementation SRRightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"heightForRowAtIndexPath %d", indexPath.row);
    switch (indexPath.row) {
        case 0: {
            return 100.0;
        }
            break;
        case 1: {
            return 60.0;
        }
            break;
            
        default:            
            break;
    }
    return 40.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainColorAnalyticsCell";
    
    switch (indexPath.row) {
        case 0: {
            CellIdentifier = @"MainColorAnalyticsCell";
            MainColorAnalyticsCell *cell = (MainColorAnalyticsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainColorAnalyticsCell" owner:nil options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.colorNameLabel.text = @"Camel";
            cell.yearLabel.text = @"2013";
            [cell.viewForBaselineLayout setBackgroundColor:[UIColor greenColor]];
            return cell;
        }
            break;
        default: {
            CellIdentifier = @"Cell";
        }
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSLog(@"created %@ cell", CellIdentifier);
    return cell;
}


#pragma mark - Table view delegate
/*
 Each row will set a new VC in the centerViewControler
 **/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0: {
            NSLog(@"choose the first row!\nWe should not do anything at this point\nlater we can dispaly data for Color or Designer");
            /*
            self.viewDeckController.rightController = SharedAppDelegate.rightController;
            ViewController* nestController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:nestController];
            self.viewDeckController.centerController = navController;
             */
        }
            break;

        case 1: {
            NSLog(@"choose row 2!\nWe should not do anything at this point\nlater we can dispaly data for Color or Designer");
            /*
            self.viewDeckController.rightController = SharedAppDelegate.rightController;
            
            SRHistoryViewController *nestController1 = [[SRHistoryViewController alloc] initWithNibName:@"SRHistoryViewController" bundle:nil];
            UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:nestController1];
            self.viewDeckController.centerController = navController1;
             */
        }
            break;
            
        case 2: {
            NSLog(@"choose row 3!\nWe should not do anything at this point\nlater we can dispaly data for Color or Designer");
            /*
            self.viewDeckController.rightController = SharedAppDelegate.rightController;            
            SRSettingsViewController *nestController1 = [[SRSettingsViewController alloc] initWithNibName:@"SRSettingsViewController" bundle:nil];
            UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:nestController1];
            self.viewDeckController.centerController = navController1;
             */
        }
            break;
                        
        default: {
            /*
            self.viewDeckController.rightController = SharedAppDelegate.rightController;
            ViewController* nestController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:nestController];
            self.viewDeckController.centerController = navController;
             */
        }
            break;
    }
    
    // Close the view and present the selected VC
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            [cc.navigationController setNavigationBarHidden:YES animated:YES];
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
        }
//        [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
    }];
}

- (void)viewDidUnload {
    [self setDesignerCell:nil];
    [self setMainCell:nil];
    [super viewDidUnload];
}
@end
