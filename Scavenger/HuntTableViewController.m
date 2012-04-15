//
//  HuntTableViewController.m
//  Scavenger
//
//  Created by Melissa Binde on 4/14/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "HuntTableViewController.h"

@interface HuntTableViewController ()
-(void) updateItemsFound;
@end

// need to create a Hunt object
// this will store all the poissible items, the ones we selected, and the ones we've found so far
// this is better than tracking it in the controller like we are

@implementation HuntTableViewController

@synthesize huntItems = _huntItems;
@synthesize huntInformationHeader = _huntInformationHeader;
@synthesize numberOfItemsFound = _numberOfItemsFound;

- (NSArray *) huntItems {
  if (! _huntItems) {
    _huntItems = [NSArray arrayWithObjects:
                  @"Tree", 
                  @"House",
                  @"Horse",
                  @"Cat",
                  @"Melissa",
                  @"Seth", 
                  @"Tree1", 
                  @"House1",
                  @"Horse1",
                  @"Cat1",
                  @"Melissa1",
                  @"Seth1", 
                  nil];
  }
  return _huntItems;
}

- (void)updateItemsFound {
  
  NSString *message = nil;
  
  if (! self.numberOfItemsFound) {
    self.numberOfItemsFound = 0;
  }
  if (self.numberOfItemsFound == [self.huntItems count]) {
    message = @"Good work, you found them all!";
  }
  else if (self.numberOfItemsFound >= ([self.huntItems count] * .8)) {
    message = @"Items Found: %d/%d ... almost done!";
  }
  else {
    message = @"Items Found: %d/%d";
  }
  self.huntInformationHeader.text = [NSString stringWithFormat:message,
                                     self.numberOfItemsFound,
                                     [self.huntItems count]];
}

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.numberOfItemsFound = 0;
  [self updateItemsFound];
}

- (void)viewDidUnload {
  [self setHuntInformationHeader:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  self.huntItems = nil;
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
  return [self.huntItems count];
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
  
  // Configure the cell.
  cell.textLabel.text = [self.huntItems objectAtIndex: [indexPath row]];
  return cell;
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if (cell.accessoryType == UITableViewCellAccessoryNone) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.textColor = [UIColor colorWithRed:0.7f
                                               green:0.7f
                                                blue:0.7f 
                                               alpha:1.0f];
    self.numberOfItemsFound++;
  }
  else {
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    self.numberOfItemsFound--;
  }
  [self updateItemsFound];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
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

