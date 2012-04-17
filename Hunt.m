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
@synthesize huntSize = _huntSize;
@synthesize allHuntItems = _allHuntItems;
@synthesize shuffledHuntItems = _shuffledHuntItems;
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

-(void) setFoundHuntItems: (NSArray *) array {
  if (_foundHuntItems != array) {
    _foundHuntItems = array;
  }
}
-(NSArray *) foundHuntItems {
  if (! _foundHuntItems) {
    _foundHuntItems = [[NSArray alloc] init ];
  }
  return _foundHuntItems;
}


// designated initializer
-(id) initWithHuntSize: (int) size withSeed: (int) seed {
  self = [super init];

  self.huntSize = [NSNumber numberWithInt: size];
  self.rngSeed = seed;
  [[self class] seedRNG:seed];

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
                     @"Tree", @"0",
                     @"Blanket", @"1",
                     @"Seth", @"2",
                     @"F250", @"3",
                     @"Cat", @"4",
                     @"Melissa", @"5",
                     @"Laptop", @"6",
                     @"RAID Drive", @"7",
                     @"Water Hose", @"8",
                     @"Wheel Chock", @"9",
                     @"Keys", @"10",
                     @"Headphones", @"11",
                     @"iPad", @"12",
                     @"Board Game", @"13",
                     @"Pillow", @"14",
                     nil];
  }
  return _allHuntItems;
}

-(NSArray *) shuffledHuntItems {
  if (! _shuffledHuntItems) {
    NSArray *keys = [self.allHuntItems allKeys];
    _shuffledHuntItems = [[self class] shuffleArray:[keys mutableCopy]];
  }
  return _shuffledHuntItems;
}

-(NSArray *) currentHuntItems {
  if (! _currentHuntItems) {
    NSRange range;
    range.location = 0;
    range.length = [self.huntSize integerValue];
    _currentHuntItems = [self.shuffledHuntItems subarrayWithRange:range];
  }
  return _currentHuntItems;
}

-(NSString *) itemForKey: (NSString *) key {
  return [self.allHuntItems objectForKey:key];
}

-(void) toggleFoundStatusForHuntItem: (NSString *)key {
  
  if ([self huntItemHasBeenFound:key]) {
    NSLog(@"%@ Already exists; removing", key);
    NSMutableArray *newItemsList = [self.foundHuntItems mutableCopy];
    [newItemsList removeObject: key];
    self.foundHuntItems = newItemsList;
  }
  else {
    NSLog(@"Adding %@", key);
    self.foundHuntItems = [self.foundHuntItems arrayByAddingObject:key];
  }
}

-(BOOL) huntItemHasBeenFound: (NSString *)key {
  if ([self.foundHuntItems indexOfObject:key] != NSNotFound) {
    return YES;
  }
  else {
    return NO;
  }
}



@end
