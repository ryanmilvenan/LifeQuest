//
//  FromRightReplaceSegue.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FromRightReplaceSegue.h"

@implementation FromRightReplaceSegue

-(void)perform{
    UIViewController *dst = [self destinationViewController];
    UIViewController *src = [self sourceViewController];
    [dst viewWillAppear:NO];
    [dst viewDidAppear:NO];
    
    [src.view addSubview:dst.view];
    
    CGRect original = dst.view.frame;
    
    dst.view.frame = CGRectMake(0+dst.view.frame.size.width, dst.view.frame.origin.y, dst.view.frame.size.width, dst.view.frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.675];
    dst.view.frame = CGRectMake(original.origin.x, original.origin.y, original.size.height, original.size.width);
    [UIView commitAnimations];
    
    [self performSelector:@selector(animationDone:) withObject:dst afterDelay:0.1];
}
- (void)animationDone:(id)vc{
    UIViewController *dst = (UIViewController*)vc;
    UINavigationController *nav = [[self sourceViewController] navigationController];
    [nav popViewControllerAnimated:NO];
    [nav pushViewController:dst animated:NO];
}

@end
