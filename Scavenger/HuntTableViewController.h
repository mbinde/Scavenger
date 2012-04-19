//
//  HuntTableViewController.h
//  Scavenger
//
//  Created by Melissa Binde on 4/14/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hunt.h"

@interface HuntTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSNumber *huntID;
@property (strong, nonatomic) NSNumber *huntSize;
@property (nonatomic) BOOL timerSetting;
@property (strong, nonatomic) Hunt *hunt;
@property (weak, nonatomic) IBOutlet UILabel *huntInformationHeader;
@property (weak, nonatomic) IBOutlet UIProgressView *huntProgressBar;

@end
