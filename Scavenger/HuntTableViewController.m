//
//  HuntTableViewController.m
//  Scavenger
//
//  Created by Melissa Binde on 4/14/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "HuntTableViewController.h"
#import "Hunt.h"

@interface HuntTableViewController ()
-(void) updateItemsFound;
-(void) markItemAtCell:(UITableViewCell *)cell asFound:(BOOL)found;
@end

// need to create a Hunt object
// this will store all the poissible items, the ones we selected, and the ones we've found so far
// this is better than tracking it in the controller like we are

@implementation HuntTableViewController

@synthesize huntID = _huntID;
@synthesize huntSize = _huntSize;
@synthesize timerSetting = _timerSetting;
@synthesize hunt = _hunt;
@synthesize huntInformationHeader = _huntInformationHeader;
@synthesize huntProgressBar = _huntProgressBar;


- (IBAction)cancelInProgressHunt:(id)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [super viewWillAppear:animated];
}


- (void)updateItemsFound {
  
  NSString *message = nil;
  
  int count = [self.hunt.foundHuntItems count];
  
  float progressPercentage;
  if ((count == 0) || ([self.hunt.currentHuntItems count] == 0)) {
    progressPercentage = 0.0;
  }
  else {
    progressPercentage = (float) count / (float) [self.hunt.currentHuntItems count];
  }
  [self.huntProgressBar setProgress: progressPercentage animated: YES];
  
  if (count == [self.hunt.currentHuntItems count]) {
    message = @"Good work, you found them all!";
    UIAlertView* alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popToRootViewControllerAnimated:YES];
  }
  else {
    message = @"%d/%d";
    self.huntInformationHeader.text = [NSString stringWithFormat:message,
                                       count,
                                       [self.hunt.currentHuntItems count]];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.hunt = [[Hunt alloc] initWithHuntSize: self.huntSize
                                  withHuntID: self.huntID];
  [self updateItemsFound];
}

- (void)viewDidUnload {
  [self setHuntInformationHeader:nil];
  [self setHuntProgressBar:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.hunt.currentHuntItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Hunt Item";
  
  UITableViewCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:CellIdentifier];
  }
  
  NSString *key = [self.hunt.currentHuntItems objectAtIndex: [indexPath row]];
  cell.textLabel.text = [self.hunt itemForKey:key];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  NSString *key = [self.hunt.currentHuntItems objectAtIndex: [indexPath row]];
  
  if ([self.hunt huntItemHasBeenFound:key]) {
    // was found before, so remove it from the list
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self markItemAtCell:cell asFound:FALSE];
  }
  else {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self markItemAtCell:cell asFound:TRUE];
  }
  [self.hunt toggleFoundStatusForHuntItem: key];
  [self updateItemsFound];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSString *key = [self.hunt.currentHuntItems objectAtIndex: [indexPath row]];
  
  if ([self.hunt huntItemHasBeenFound:key]) {
    [self markItemAtCell:cell asFound:TRUE];
  }
  else {
    [self markItemAtCell:cell asFound:FALSE];
    
  }
}

- (void)markItemAtCell:(UITableViewCell *)cell asFound:(BOOL)found {
  if (found) {
    cell.textLabel.textColor = [UIColor colorWithRed:0.7f
                                               green:0.7f
                                                blue:0.7f
                                               alpha:1.0f];
  }
  else {
    cell.textLabel.textColor = [UIColor blackColor];
  }
}



@end

