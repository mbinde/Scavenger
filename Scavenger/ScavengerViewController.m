//
//  ScavengerViewController.m
//  Scavenger
//
//  Created by Melissa Binde on 4/14/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "ScavengerViewController.h"
#import "HuntTableViewController.h"

@interface ScavengerViewController ()

@end

@implementation ScavengerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated
{
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
  [self.navigationController setNavigationBarHidden:NO animated:animated];
  [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
  if ([segue.identifier hasPrefix:@"Start Hunt"]) {    
    [segue.destinationViewController setHuntID: [NSNumber numberWithInt: sender.tag]];
  }
  if ([segue.identifier hasPrefix:@"Setup Hunt"]) {    
    [segue.destinationViewController setHuntID: [NSNumber numberWithInt: sender.tag]];
  }
}

@end
