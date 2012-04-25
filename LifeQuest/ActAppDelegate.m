//
//  ActAppDelegate.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActAppDelegate.h"
#import "ActDataController.h"
#import "ActMainViewController.h"
#import "ActScoreContainer.h"

@implementation ActAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Data Initialization
    
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    ActMainViewController *firstViewController = [[navigationController viewControllers] objectAtIndex:0];
    
    
    //Date and Time Elements
    NSDate *aDate = [NSDate date]; 
    firstViewController.todaysDate = aDate;
    NSDateFormatter *aDateFormatter = [[NSDateFormatter alloc] init];
    [aDateFormatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [aDateFormatter setDateStyle:NSDateFormatterShortStyle];
    firstViewController.mainDateFormatter = aDateFormatter;
    firstViewController.choreDataController.currentDate = firstViewController.todaysDate;
    firstViewController.workDataController.currentDate = firstViewController.todaysDate;
    firstViewController.socialDataController.currentDate = firstViewController.todaysDate;
    firstViewController.selfDataController.currentDate = firstViewController.todaysDate;
    NSCalendar *aCal = [NSCalendar currentCalendar];
    firstViewController.mainCal = aCal;
    firstViewController.choreDataController.curCal = firstViewController.mainCal;
    firstViewController.workDataController.curCal = firstViewController.mainCal;
    firstViewController.socialDataController.curCal = firstViewController.mainCal;
    firstViewController.selfDataController.curCal = firstViewController.mainCal;
    
    
    //Data Initialization
    ActDataController *aChoreDataController = [[ActDataController alloc] init];
    [aChoreDataController generateType:@"Chores"];
    [aChoreDataController addScoreCell:[NSNumber numberWithInt:0]];
    ActDataController *aWorkDataController = [[ActDataController alloc] init];
    [aWorkDataController generateType:@"Work"];
    [aWorkDataController addScoreCell:[NSNumber numberWithInt:0]];
    ActDataController *aSocialDataController = [[ActDataController alloc] init];
    [aSocialDataController generateType:@"Social"];
    [aSocialDataController addScoreCell:[NSNumber numberWithInt:0]];
    ActDataController *aSelfDataController = [[ActDataController alloc] init];
    [aSelfDataController generateType:@"Self"];
    [aSelfDataController addScoreCell:[NSNumber numberWithInt:0]];
    ActScoreContainer *aScoreContainer = [[ActScoreContainer alloc] init];
    firstViewController.choreDataController = aChoreDataController;
    firstViewController.workDataController = aWorkDataController;
    firstViewController.socialDataController = aSocialDataController;
    firstViewController.selfDataController = aSelfDataController;
    firstViewController.scoreContainer = aScoreContainer;
    [firstViewController syncScoreContainer];
    
    //Custom UI Elements
    
    UIImageView *backgroundInit = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActBackground.png"]];
    [firstViewController.view addSubview:backgroundInit];
    firstViewController.background = backgroundInit;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    ActMainViewController *firstViewController = [[navigationController viewControllers] objectAtIndex:0];
    [firstViewController.choreDataController saveDataToDisk];
    [firstViewController.workDataController saveDataToDisk];
    [firstViewController.selfDataController saveDataToDisk];
    [firstViewController.socialDataController saveDataToDisk];
    [firstViewController.scoreContainer saveDataToDisk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
