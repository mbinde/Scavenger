//
//  Hunt.m
//  Scavenger
//
//  Created by Melissa Binde on 4/15/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "Hunt.h"

@interface Hunt ()

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *startDateOfCurrentHuntingSession;
@property (nonatomic) int cumulativeSecondsSpentHunting;

@end

@implementation Hunt

@synthesize allHuntItems = _allHuntItems;
@synthesize currentHuntItems = _currentHuntItems;
@synthesize foundHuntItems = _foundHuntItems;

@synthesize timer = _timer;
@synthesize startDateOfCurrentHuntingSession = _startDateOfCurrentHuntingSession;
@synthesize cumulativeSecondsSpentHunting = _cumulativeSecondsSpentHunting;


-(NSDictionary *) allHuntItems {
  if (! _allHuntItems) {
    _allHuntItems = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"Tree", @"1",
                     @"House", @"2",
                     @"Horse", @"3",
                     @"Cat", @"4",
                     @"Melissa", @"5",
                     @"Seth", @"6",
                     @"Tree1", @"7",
                     @"House1", @"8",
                     @"Horse1", @"9",
                     @"Cat1", @"10",
                     @"Melissa1", @"11",
                     @"Seth1", @"12",
                     nil];
  }
  return _allHuntItems;
}




@end
