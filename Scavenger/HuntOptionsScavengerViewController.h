//
//  HuntOptionsScavengerViewController.h
//  Scavenger
//
//  Created by Melissa Binde on 4/18/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuntOptionsScavengerViewController : UIViewController

@property (strong, nonatomic) NSNumber *huntID;
@property (strong, nonatomic) NSNumber *huntSize;
@property (nonatomic) BOOL timerSetting;
@property (weak, nonatomic) IBOutlet UILabel *huntSizeLabel;

@end
