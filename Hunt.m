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

//+(NSDictionary *) itemsForHuntID: (NSNumber *) huntID;
+(NSDictionary *) dataForHuntID: (NSNumber *) huntID;
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
    NSDictionary *globalHuntItems = [[self class] dataForHuntID: [NSNumber numberWithInt:-1]];
    NSDictionary *specificHuntItems = [[self class] dataForHuntID: self.huntID];
    NSMutableDictionary *combinedHuntItems = [NSMutableDictionary dictionaryWithDictionary:globalHuntItems];
    [combinedHuntItems addEntriesFromDictionary:specificHuntItems];
    _allHuntItems = [NSDictionary dictionaryWithDictionary: combinedHuntItems]; // make an immutable copy;
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

+(NSDictionary *) dataForHuntID: (NSNumber *) huntID {
  NSDictionary *data = nil;
  NSDictionary *items = nil;
  NSString *title = nil;
  
  // global items; we'll add the specific items later
  NSMutableDictionary *allItems = [NSMutableDictionary dictionaryWithObjectsAndKeys:
           @"Something Red", @"-1",
           @"Something Orange", @"-2",
           @"Something Yellow", @"-3",
           @"Something Green", @"-4",
           @"Something Blue", @"-5",
           @"Something Purple", @"-6",
           @"Something Brown", @"-7",
           @"Something Grey", @"-8",
           @"Something Black", @"-9",
           @"Something White", @"-10",
           @"Something Round", @"-11",
           @"Something Flat", @"-12",
           @"Something Pointy", @"-13",
           nil];
  
  // These use dictionaries instead of arrays so we can track statistics;
  // without reliable keys, we wouldn't be able to do internationalization,
  // tracking, etc.
  
  switch ([huntID integerValue]) {
    case 1: // RV
      title = @"RV";
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
      title = @"Park";
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
    case 3: // Grocery
      title = @"Grocery";
      items = [NSDictionary dictionaryWithObjectsAndKeys:
               @"Apples", @"0",
               @"Eggs",@"1",
               @"Cheese",@"2",
               @"Milk",@"3",
               @"Fish",@"4",
               @"Chicken",@"5",
               @"Shopping Basket",@"6",
               @"Coupon",@"7",
               @"Cereal",@"8",
               @"Bread",@"9",
               @"Brocolli",@"10",
               nil];
      break;
    case 4: // Highway
      title = @"Highway";
      items = [NSDictionary dictionaryWithObjectsAndKeys:
               @"Blue Car", @"0",
               @"Red Car",@"1",
               @"White Car",@"2",
               @"Black Car",@"3",
               @"RV",@"4",
               @"Truck",@"5",
               @"Speed Limit Sign",@"6",
               @"Tree",@"7",
               @"Bridge",@"8",
               @"Sportcar",@"9",
               @"Highway Patrol",@"10",
               @"Out of state license plate", @"11",
               @"U-Haul Truck", @"12",
               nil];
      break;
    default:
      items = nil;
      break;
  }
  
  [allItems addEntriesFromDictionary:items];
  
  data = [NSDictionary dictionaryWithObjectsAndKeys:
          title, @"title",
          huntID, @"id",
          [NSDictionary dictionaryWithDictionary: allItems], @"items",
          nil];
  
  return items;
}




@end
