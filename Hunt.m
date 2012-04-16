//
//  Hunt.m
//  Scavenger
//
//  Created by Melissa Binde on 4/15/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "Hunt.h"

@interface Hunt ()

@property (nonatomic) int rngSeed;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *startDateOfCurrentHuntingSession;
@property (nonatomic) int cumulativeSecondsSpentHunting;

@end

@implementation Hunt

@synthesize rngSeed = _rngSeed;
@synthesize allHuntItems = _allHuntItems;
@synthesize currentHuntItems = _currentHuntItems;
@synthesize foundHuntItems = _foundHuntItems;

@synthesize timer = _timer;
@synthesize startDateOfCurrentHuntingSession = _startDateOfCurrentHuntingSession;
@synthesize cumulativeSecondsSpentHunting = _cumulativeSecondsSpentHunting;



+(void) seedRNG: (int) seed {
  srandom(seed);  
}

+(int) randomNumberWithMax: (int) max {
  return random() % max;
}

+(NSArray *) shuffleArray: (NSMutableArray *) givenArray {
  // http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
  int size = [givenArray count];

  for (int i = size; i > 0; --i) {
    int randomNumber = arc4random() % size;
    [givenArray exchangeObjectAtIndex:(i-1) withObjectAtIndex:randomNumber];
  }
  
  return givenArray;
}


// designated initializer
-(id) initWithHuntSize: (int) size withSeed: (int) seed {
  self = [super init];

  self.rngSeed = seed;
  [[self class] seedRNG:seed];

//  int i = [[self class] randomNumberWithMax:20];
  
  return self;
}

-(id) initWithHuntSize: (int) size {
  self = [self initWithHuntSize: size withSeed: [[NSDate date] timeIntervalSince1970]];
  return self;
}

-(id) init {
  self = [self initWithHuntSize: 10];

  return self;
}



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

-(NSArray *) currentHuntItems {
  if (! _currentHuntItems) {
    // create them
    NSArray *keys = [self.allHuntItems allKeys];
    self.currentHuntItems = [[self class] shuffleArray:[keys mutableCopy]];
  }
  
  return _currentHuntItems;
}

-(void) toggleFoundStatusForHuntItem: (NSString *)key {
  if ([self.foundHuntItems indexOfObject:key]) {
    NSMutableArray *newItemsList = [self.foundHuntItems mutableCopy];
    [newItemsList removeObject: key];
    self.foundHuntItems = newItemsList;
  }
  else {
    self.foundHuntItems = [self.foundHuntItems arrayByAddingObject:key];
  }
}




@end
