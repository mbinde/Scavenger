//
//  HuntOptionsScavengerViewController.m
//  Scavenger
//
//  Created by Melissa Binde on 4/18/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "HuntOptionsScavengerViewController.h"

@interface HuntOptionsScavengerViewController ()

@end

@implementation HuntOptionsScavengerViewController

@synthesize huntID = _huntID;
@synthesize timerSetting = _timerSetting;

-(BOOL) timerSetting {
  if (! _timerSetting) {
    _timerSetting = NO;
  }
  return _timerSetting;
}

- (IBAction)timerToggle:(UISwitch *)sender {
  if (sender.on) {
    self.timerSetting = YES;
  }
  else {
    self.timerSetting = NO;
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
  if ([segue.identifier hasPrefix:@"Start Hunt"]) {    
    [segue.destinationViewController setHuntID: self.huntID];
    [segue.destinationViewController setTimerSetting: self.timerSetting];
  }
}


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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
