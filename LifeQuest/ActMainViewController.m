//
//  ActMainViewController.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActMainViewController.h"
#import "GLViewController.h"
#import "ActMasterViewController.h"
#import "ActAddTaskViewController.h"
#import "ActDataController.h"
#import "ActScoreContainer.h"

@interface ActMasterViewController () <ActAddTaskViewControllerDelegate> 

@end


@implementation ActMainViewController
@synthesize scoreContainer = _scoreContainer;
@synthesize choreDataController = _choreDataController;
@synthesize workDataController = _workDataController;
@synthesize socialDataController = _socialDataController;
@synthesize selfDataController = _selfDataController;
@synthesize mainScoreLabel = _mainScoreLabel;
@synthesize dateLabel = _dateLabel;
@synthesize mainDateFormatter = _mainDateFormatter;
@synthesize todaysDate = _todaysDate;
@synthesize mainCal = _mainCal;
@synthesize background = _background;


//Delegate Methods
-(void)actAddTaskViewControllerDidCancel:(ActAddTaskViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)actAddTaskViewControllerDidFinishTask:(ActAddTaskViewController *)controller name:(NSString *)name category:(NSString*)category frequency:(NSString *)frequency{
    if (([name length] || [category length])){
        if ([category isEqualToString:@"Chores"]){
            [self.choreDataController addTaskWithName:name category:category frequency:frequency score:0 dimRtnVal:[NSNumber numberWithInt:8] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Work"]) {
            [self.workDataController addTaskWithName:name category:category frequency:frequency score:0 dimRtnVal:[NSNumber numberWithInt:8] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Social"]){
            [self.socialDataController addTaskWithName:name category:category frequency:frequency score:0 dimRtnVal:[NSNumber numberWithInt:8] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Self"]) {
            [self.selfDataController addTaskWithName:name category:category frequency:frequency score:0 dimRtnVal:[NSNumber numberWithInt:8] date:self.todaysDate];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)actAddTaskViewControllerDidFinishOneOff:(ActAddTaskViewController *)controller name:(NSString *)name category:(NSString*)category{
    if (([name length] || [category length])){
        if ([category isEqualToString:@"Chores"]){
            [self.choreDataController addOneOffTaskWithName:name category:category score:[NSNumber numberWithInt:3] dimRtnVal:[NSNumber numberWithInt:3] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Work"]) {
            [self.workDataController addOneOffTaskWithName:name category:category score:[NSNumber numberWithInt:3] dimRtnVal:[NSNumber numberWithInt:3] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Social"]){
            [self.socialDataController addOneOffTaskWithName:name category:category score:[NSNumber numberWithInt:3] dimRtnVal:[NSNumber numberWithInt:3] date:self.todaysDate];
        }
        if ([category isEqualToString:@"Self"]) {
            [self.selfDataController addOneOffTaskWithName:name category:category score:[NSNumber numberWithInt:3] dimRtnVal:[NSNumber numberWithInt:3] date:self.todaysDate];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}

//Interface Methods

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self calculateTotalScore];
    [self syncScoreContainer];
    [self.scoreContainer saveDataToDisk];
    self.dateLabel.text = [self.mainDateFormatter stringFromDate:self.todaysDate];
    [self.view sendSubviewToBack:self.background];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowChoreTable"]){        
        ActMasterViewController *actMasterViewController = (ActMasterViewController *)[segue destinationViewController];
        actMasterViewController.dataController = self.choreDataController;
        actMasterViewController.category = @"Chores";
    }
    if([[segue identifier] isEqualToString:@"ShowSelfTable"]){        
        ActMasterViewController *actMasterViewController = (ActMasterViewController *)[segue destinationViewController];
        actMasterViewController.dataController = self.selfDataController;
        actMasterViewController.category = @"Self";
    }
    if([[segue identifier] isEqualToString:@"ShowSocialTable"]){        
    }
    if([[segue identifier] isEqualToString:@"ShowWorkTable"]){        
        ActMasterViewController *actMasterViewController = (ActMasterViewController *)[segue destinationViewController];
        actMasterViewController.dataController = self.workDataController;
        actMasterViewController.category = @"Work";
    }
    if([[segue identifier] isEqualToString:@"ShowAddTaskView"]){
        ActAddTaskViewController *addController = (ActAddTaskViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate =  (id)self;
    }
}

//Data Management Methods

- (void)calculateTotalScore{
    int temp = 0;
    temp += [self.choreDataController.localTotalScore integerValue];
    temp += [self.workDataController.localTotalScore integerValue];
    temp += [self.socialDataController.localTotalScore integerValue];
    temp += [self.selfDataController.localTotalScore integerValue];
    if (temp<10) {
        NSString *mainScoreString = [[NSString alloc] initWithFormat:@"0%i", temp];
        self.mainScoreLabel.text = mainScoreString;
    }
    else{
        NSString *mainScoreString = [[NSString alloc] initWithFormat:@"%i", temp];
        self.mainScoreLabel.text = mainScoreString;
    }
}

- (void)syncScoreContainer{
    self.scoreContainer.choreData = self.choreDataController;
    self.scoreContainer.workData = self.workDataController;
    self.scoreContainer.socialData = self.socialDataController;
    self.scoreContainer.selfData = self.selfDataController;
    [self.scoreContainer refreshScoreContainer];
}


@end
