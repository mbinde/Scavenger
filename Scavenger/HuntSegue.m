//
//  HuntSegue.m
//  Scavenger
//
//  Created by Melissa Binde on 4/16/12.
//  Copyright (c) 2012 Rolling Road Studios. All rights reserved.
//

#import "HuntSegue.h"

@implementation HuntSegue

-(void)perform {
  UIViewController *src = (UIViewController *) self.sourceViewController;
  UIViewController *dst = (UIViewController *) self.destinationViewController;

  [UIView transitionWithView:src.navigationController.view duration:0.2
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:^{
                    [src presentViewController:dst animated:NO completion:NULL];
                  }
                  completion:NULL];

  
//      [src presentViewController:dst animated:YES completion:NULL];
  /*
  UIViewController *sourceVC = (UIViewController *) self.sourceViewController;
  UIViewController *destinationVC = (UIViewController *) self.destinationViewController;
  
  [UIView transitionWithView:sourceVC.navigationController.view duration:0.2
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    [sourceVC.navigationController pushViewController:destinationVC animated:NO];
                  }
                  completion:NULL];
  */
}

/*
- (void) perform {
  
  UIViewController *src = (UIViewController *) self.sourceViewController;
  
  [UIView transitionWithView:src.navigationController.view duration:0.1
                     options:UIViewAnimationOptionTransitionNone
                  animations:^{
                    [src.navigationController popViewControllerAnimated:YES];
                  }
                  completion:NULL];
    
 */
  /*
  UIViewController *src = (UIViewController *) self.sourceViewController;
  UIViewController *dst = (UIViewController *) self.destinationViewController;
  
  [UIView transitionWithView:src.navigationController.view duration:0.2
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    [src.navigationController pushViewController:dst animated:NO];
                  }
                  completion:NULL];
*/  
//}


@end
