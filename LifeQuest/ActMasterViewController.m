//
//  ActMasterViewController.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActMasterViewController.h"
#import "ActDetailViewController.h"

#import "ActDataController.h"
#import "ActTask.h"
#import "ActOneOffTask.h"
#import "ActLocalScoreFill.h"

#import "ActCustomHeader.h"
#import "ActCustomCellView.h"

NSString *const REUSE_ID_TOP = @"TopRow";
NSString *const REUSE_ID_MID = @"MiddleRowArr";
NSString *const REUSE_ID_BOT = @"BottomRowArr";


@implementation ActMasterViewController

@synthesize dataController = _dataController;
@synthesize category = _category;
@synthesize scoreString = _scoreString;


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)registerNIBs{
    NSBundle *classBundle = [NSBundle bundleForClass:[ActCustomCellView class]];
    
    UINib *middleNib = [UINib nibWithNibName:REUSE_ID_MID bundle:classBundle];
    [[self tableView] registerNib:middleNib forCellReuseIdentifier:REUSE_ID_MID];
    UINib *bottomNib = [UINib nibWithNibName:REUSE_ID_BOT bundle:classBundle];
    [[self tableView] registerNib:bottomNib forCellReuseIdentifier:REUSE_ID_BOT];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureView];
   
    
    self.navigationItem.rightBarButtonItem = nil;
    [self registerNIBs];
    /*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    */
}

- (NSString *)reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:indexPath.section];
    NSInteger rowIndex = indexPath.row;
    
    if (rowIndex == rowCount - 1) {
        return REUSE_ID_BOT;
    }
    
    return REUSE_ID_MID;
}

- (void)configureView{
    self.navigationItem.title = _category;
    [[self tableView] reloadData];
    [self.dataController scoreOfList];
    [self updateScoreString];
}
                                                                                                                                     

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.dataController = nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataController.dailyTaskList count];
    }
    if (section == 1) {
        return [self.dataController.weeklyTaskList count];
    }
    if (section == 2) {
        return [self.dataController.oneOffTaskList count];
    }
    else {
        return 1;
    }
        
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Daily Tasks";
    }
    else if(section == 1){
        return @"Weekly Tasks";
    }
    else if(section == 2){
        return @"One-Off Tasks";
    }
    else {
        return @"Score:";
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ActCustomHeader *header = [[ActCustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *taskCellIdentifier = @"ActTaskCell";
    static NSString *oneOffCellIdentifier = @"ActOneOffCell";
    */
    static NSString *scoreCellIdentifier = @"ActScoreCell";
    UIFont *goldBox = [UIFont fontWithName:@"GoldBox" size:17];
    
    if (indexPath.section == 0){
        NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath]; 
        ActCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        NSMutableArray *arrayAtIndex = self.dataController.dailyTaskList;
        ActTask *taskAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[taskAtIndex.score intValue]];
        cell.nameLabel.font = goldBox;
        cell.scoreLabel.font = goldBox;
        cell.nameLabel.text = taskAtIndex.name;
        cell.scoreLabel.text = scoreString;
        
        //cell.textLabel.backgroundColor = [UIColor clearColor];
        //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        //[[cell detailTextLabel] setText:scoreString];
    
    return cell;
        
    }
    if (indexPath.section == 1){
        
        NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath]; 
        ActCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        NSMutableArray *arrayAtIndex = self.dataController.dailyTaskList;
        ActTask *taskAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[taskAtIndex.score intValue]];
        cell.nameLabel.text = taskAtIndex.name;
        cell.scoreLabel.text = scoreString;
        
        /*
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier];
        
        cell.backgroundView = [[ActCustomCellView alloc] init];
        cell.selectedBackgroundView = [[ActCustomCellView alloc] init];
        
        NSMutableArray *arrayAtIndex = self.dataController.weeklyTaskList;
        ActTask *taskAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[taskAtIndex.score intValue]];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        [[cell textLabel] setText:taskAtIndex.name];
        [[cell detailTextLabel] setText:scoreString];
        */
        return cell;
        
    }
    if (indexPath.section == 2) {
        NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath]; 
        ActCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        NSMutableArray *arrayAtIndex = self.dataController.dailyTaskList;
        ActTask *taskAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[taskAtIndex.score intValue]];
        cell.nameLabel.text = taskAtIndex.name;
        cell.scoreLabel.text = scoreString;
        
        /*
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneOffCellIdentifier];
        
        //Use Custom Cells
        cell.backgroundView = [[ActCustomCellView alloc] init];
        cell.selectedBackgroundView = [[ActCustomCellView alloc] init];
        
        NSMutableArray *arrayAtIndex = self.dataController.oneOffTaskList;
        ActOneOffTask *oneOffAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[oneOffAtIndex.score intValue]];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        [[cell textLabel] setText:oneOffAtIndex.name];
        [[cell detailTextLabel] setText:scoreString];
        */
        return cell;
    }
    else {
        /*
        NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath]; 
        ActCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        NSMutableArray *arrayAtIndex = self.dataController.dailyTaskList;
        ActTask *taskAtIndex = [arrayAtIndex objectAtIndex:indexPath.row];
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[taskAtIndex.score intValue]];
        cell.nameLabel.text = taskAtIndex.name;
        cell.scoreLabel.text = scoreString;
        */
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreCellIdentifier];
        
        //Use Custom Cell
        cell.backgroundView = [[ActCustomCellView alloc] init];
        cell.selectedBackgroundView = [[ActCustomCellView alloc] init];
        
        NSMutableArray *arrayAtIndex = [self.dataController.masterTaskList objectAtIndex:indexPath.section];
        ActLocalScoreFill *localScoreFill = [arrayAtIndex objectAtIndex:indexPath.row];
        localScoreFill.score = self.dataController.localTotalScore;
        NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[[self.dataController localTotalScore]intValue]];
        
        cell.textLabel.backgroundColor = [UIColor clearColor]; 
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        [[cell textLabel] setText:scoreString];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(indexPath.section == 0){
            [self.dataController.dailyTaskList removeObject:[self.dataController.dailyTaskList objectAtIndex:indexPath.row]];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else if(indexPath.section == 1){
            [self.dataController.weeklyTaskList removeObject:[self.dataController.weeklyTaskList objectAtIndex:indexPath.row]];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        else if(indexPath.section == 2){
            [self.dataController.oneOffTaskList removeObject:[self.dataController.oneOffTaskList objectAtIndex:indexPath.row]];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
} 


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        ActOneOffTask *oneOffTask = [self.dataController.oneOffTaskList  objectAtIndex:indexPath.row];
        NSNumber *newOneOffScore = [[NSNumber alloc] initWithInt:([self.dataController.oneOffScore intValue] +[oneOffTask.dimRtnVal intValue])];
        self.dataController.oneOffScore = newOneOffScore;
        [self updateScoreString];
        [self.dataController.oneOffTaskList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performSelector:@selector(configureView) withObject:self afterDelay:.4];
    }
}

- (void) updateScoreString{
    ActLocalScoreFill *localScoreFill = [[self.dataController.masterTaskList objectAtIndex:3] objectAtIndex:0];
    localScoreFill.score = self.dataController.localTotalScore;
    NSString *scoreString = [[NSString alloc] initWithFormat:@"%i",[[self.dataController localTotalScore]intValue]];
    NSString *scoreAndName = [localScoreFill.name stringByAppendingString:scoreString];
    self.scoreString = scoreAndName;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowTaskDetails"]) {
        ActDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.task = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].section index:[self.tableView indexPathForSelectedRow].row];
    }
}


@end
