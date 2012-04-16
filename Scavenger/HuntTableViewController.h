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

@property (strong, nonatomic) Hunt *hunt;

@property (nonatomic, strong) NSArray *huntItems;
@property (weak, nonatomic) IBOutlet UILabel *huntInformationHeader;
@property (nonatomic) int numberOfItemsFound;

@end