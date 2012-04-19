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
@synthesize huntSize = _huntSize;
@synthesize timerSetting = _timerSetting;
@synthesize huntSizeLabel = _huntSizeLabel;


-(NSNumber *) huntSize {
  if (! _huntSize) {
    _huntSize = [NSNumber numberWithInt: 10];
  }
  return _huntSize;
}

-(void) updateHuntSizeLabel {
  self.huntSizeLabel.text = [NSString stringWithFormat: @"Hunt Size: %d", [self.huntSize integerValue]];
}

-(BOOL) timerSetting {
  if (! _timerSetting) {
    _timerSetting = NO;
  }
  return _timerSetting;
}

- (IBAction)huntSizeSlider:(UISlider *)sender {
  self.huntSize = [NSNumber numberWithInt: (int) roundf(sender.value)];
  [self updateHuntSizeLabel];
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
    [segue.destinationViewController setHuntSize: self.huntSize];
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
  [self updateHuntSizeLabel];
}

- (void)viewDidUnload
{
  [self setHuntSizeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
