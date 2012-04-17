//
//  ScavengerViewController.m
//  Scavenger
//
//  Created by Melissa Binde on 4/14/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "ScavengerViewController.h"

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
  if ([segue.identifier isEqualToString:@"Start Hunt"]) {
    NSLog(@"In Segue");
    NSLog(@"Segue Tag: %d", sender.tag);
    NSLog(@"Identifier: %@", segue.identifier);
//    [segue.destinationViewController setDelegate:self];
  }
}

@end
