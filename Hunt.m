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

+(NSDictionary *) itemsForHuntID: (NSNumber *) huntID;
@end




@implementation Hunt

@synthesize rngSeed = _rngSeed;
@synthesize huntSize = _huntSize;
@synthesize huntID = _huntID;

@synthesize allHuntItems = _allHuntItems;
@synthesize shuffledHuntItems = _shuffledHuntItems;
@synthesize currentHuntItems = _currentHuntItems;
@synthesize foundHuntItems = _foundHuntItems;

@synthesize timer = _timer;
@synthesize startDateOfCurrentHuntingSession = _startDateOfCurrentHuntingSession;
@synthesize cumulativeSecondsSpentHunting = _cumulativeSecondsSpentHunting;




#pragma mark - Class Methods

+(NSArray *) shuffleArray: (NSMutableArray *) givenArray {
  // http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
  int size = [givenArray count];

  for (int i = size; i > 0; --i) {
    int randomNumber = arc4random() % size;
    [givenArray exchangeObjectAtIndex:(i-1) withObjectAtIndex:randomNumber];
  }
  
  return givenArray;
}

+(NSNumber *) randomHuntID {
  NSArray *validHuntIDs = [self validHuntIDs];
  int randomNumber = arc4random() % [validHuntIDs count];
  return [validHuntIDs objectAtIndex: randomNumber];
}

+(NSNumber *) randomHuntSize {
  NSArray *validHuntSizes = [self validHuntSizes];
  int randomNumber = arc4random() % [validHuntSizes count];
  return [validHuntSizes objectAtIndex: randomNumber];
}


#pragma mark - Accessors

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

-(NSDictionary *) allHuntItems {
  if (!_allHuntItems) {
    _allHuntItems = [[self class] itemsForHuntID: self.huntID];
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


#pragma mark - Initializers

// designated initializer
-(id) initWithHuntSize: (NSNumber *) size withHuntID: (NSNumber *) huntID withSeed: (int) seed {
  self = [super init];

  self.huntSize = size;
  self.huntID = huntID;
  self.rngSeed = seed;
  
  srandom(seed);

  return self;
}

-(id) initWithHuntSize: (NSNumber *) size withHuntID: (NSNumber *) huntID {
  self = [self initWithHuntSize: size 
                     withHuntID: huntID
                       withSeed: [[NSDate date] timeIntervalSince1970]
          ];
  return self;
}

-(id) initWithHuntID: (NSNumber *) huntID {
  self = [self initWithHuntSize: [[self class] randomHuntSize]
                     withHuntID: huntID
          ];
  return self;
}


-(id) init {
  self = [self initWithHuntSize: [[self class] randomHuntSize]
                     withHuntID: [[self class] randomHuntID]
          ];

  return self;
}

#pragma mark - Item manipulation

-(NSString *) itemForKey: (NSString *) key {
  return [self.allHuntItems objectForKey:key];
}

-(void) toggleFoundStatusForHuntItem: (NSString *)key {
  
  if ([self huntItemHasBeenFound:key]) {
    NSMutableArray *newItemsList = [self.foundHuntItems mutableCopy];
    [newItemsList removeObject: key];
    self.foundHuntItems = newItemsList;
  }
  else {
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


#pragma mark - Hunt definitions


// write tests for this that gets the number of locations, checks each to make sure they return something, then checks N+1 to make sure it returns nil

+(NSArray *) validHuntIDs {
  return [NSArray arrayWithObjects: 
          [NSNumber numberWithInteger: 1], 
          nil];
}

+(NSArray *) validHuntSizes {
  return [NSArray arrayWithObjects: 
          [NSNumber numberWithInteger: 5], 
          [NSNumber numberWithInteger: 10], 
          nil];
}

+(NSDictionary *) itemsForHuntID: (NSNumber *) huntID {
  NSDictionary *items = nil;
  
  switch ([huntID integerValue]) {
    case 1: // RV
      items = [NSDictionary dictionaryWithObjectsAndKeys:
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
      break;
    case 2: // Park
      items = [NSDictionary dictionaryWithObjectsAndKeys:
               @"Tree", @"0",
               @"Branch", @"1",
               @"Moss", @"2",
               @"Seth", @"3",
               @"Melissa", @"4",
               @"Not Yopa", @"5",
               @"Leaves", @"6",
               @"Trail", @"7",
               @"Creek", @"8",
               @"Blue Sky", @"9",
               @"Nurse Log", @"10",
               @"Conifer", @"11",
               @"Dirt", @"12",
               @"Dog", @"13",
               nil];
      break;
    default:
      items = nil;
      break;
  }

  return items;
}




@end
