//
//  Hunt.h
//  Scavenger
//
//  Created by Melissa Binde on 4/15/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Hunt : NSObject

@property (strong, nonatomic) NSDictionary *allHuntItems;
@property (strong, nonatomic) NSArray *shuffledHuntItems;
@property (strong, nonatomic) NSArray *currentHuntItems;
@property (strong, nonatomic) NSArray *foundHuntItems;

@property (strong, nonatomic) NSNumber *huntSize;
@property (strong, nonatomic) NSNumber *huntID;

-(id) initWithHuntSize: (NSNumber *) size withHuntID: (NSNumber *) huntID withSeed: (int) seed; // designated initializer
-(id) initWithHuntSize: (NSNumber *) size withHuntID: (NSNumber *) huntID;
-(id) initWithHuntID: (NSNumber *) huntID;
-(id) init;


-(NSString *) itemForKey: (NSString *) key;
-(void) toggleFoundStatusForHuntItem: (NSString *)key;
-(BOOL) huntItemHasBeenFound: (NSString *)key;

+(NSNumber *) randomHuntID;
+(NSNumber *) randomHuntSize;

@end
