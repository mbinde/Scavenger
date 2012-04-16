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

-(NSString *) itemForKey: (NSString *) key;

@end
