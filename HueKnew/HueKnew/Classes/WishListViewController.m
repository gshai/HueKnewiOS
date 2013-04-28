//
//  WishListViewController.m
//  HueKnew
//
//  Created by Gilad Shai on 4/25/13.
//  Copyright (c) 2013 Shai, Gilad. All rights reserved.
//

#import "WishListViewController.h"
#import "WishListCell.h"

@interface WishListViewController ()

@end

@implementation WishListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int rows = 0;
    if (_items) {
        rows = [_items count];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WishListCell";
    
    WishListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WishListCell" owner:nil options:nil];
        cell = [nib objectAtIndex:0];
        NSURL *imageUrl = [NSURL URLWithString:[_items objectAtIndex:indexPath.row]];
        [cell initWithImageURL:imageUrl reuseIdentifier:CellIdentifier];
        
        cell.aLabel.userInteractionEnabled = YES;
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDetected:)];
        swipe.delegate = self;
        [cell.aLabel addGestureRecognizer:swipe];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.delegate = self;
        [cell.aLabel addGestureRecognizer:tapRecognizer];
        cell.aLabel.tag = indexPath.row;

    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330.0;
}


#pragma mark - gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return  YES;
}
- (void)swipeDetected:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"swipe: %@", swipe);
    
    int row = swipe.view.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    WishListCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];

    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            NSLog(@"swipe right");            
            [cell slideOutImage];
        }
            break;
            
        case UISwipeGestureRecognizerDirectionLeft : {
            NSLog(@"swipe left");
            [cell slideInImage];
        }
            break;
            
        default:
            NSLog(@"other swipe");
            break;
    }
}
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapDetected");
}

@end
