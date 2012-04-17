//
//  HuntSegue.m
//  Scavenger
//
//  Created by Melissa Binde on 4/16/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "HuntSegue.h"

@implementation HuntSegue

- (void) perform {
  
  UIViewController *src = (UIViewController *) self.sourceViewController;
  UIViewController *dst = (UIViewController *) self.destinationViewController;
  
  [UIView transitionWithView:src.navigationController.view duration:0.2
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    [src.navigationController pushViewController:dst animated:NO];
                  }
                  completion:NULL];
  
}


@end
