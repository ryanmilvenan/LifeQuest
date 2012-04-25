//
//  ActDetailViewController.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActDetailViewController.h"
#import "ActTask.h"

@interface ActDetailViewController ()
- (void)configureView;
@end

@implementation ActDetailViewController
@synthesize delegate = _delegate;
@synthesize task = _task;
@synthesize scoreLabel = _scoreLabel;
@synthesize timMin = _timMin;
@synthesize progView = _progView;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize compareTime = _compareTime;
@synthesize startCalendar = _startCalendar;
@synthesize compareCalendar = _compareCalendar;
@synthesize startComponents = _startComponents;
@synthesize compareComponents = _compareComponents;
@synthesize startTimeMin = _startTimeMin;
@synthesize compareTimeMin = _compareTimeMin;
@synthesize timeMinInt = _timeMinInt;
BOOL running = NO;

#pragma mark - Managing the detail item

- (void)setTask:(ActTask *)newTask
{
    if (_task != newTask) {
        _task = newTask;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    ActTask *theTask = self.task;
    
    if (running == NO) {
        if (theTask){
            NSString *scoreVal = [[NSString alloc] initWithFormat:@"%i", [theTask.score intValue]];
            self.scoreLabel.text = scoreVal;
            self.navigationItem.title = theTask.name;
            self.progView.hidden = YES;
            self.progView.progress = 0;
        }
    } else {
        if (theTask) {
                NSString *scoreVal = [[NSString alloc] initWithFormat:@"%i", [theTask.score intValue]];
                self.scoreLabel.text = scoreVal;
                self.navigationItem.title = theTask.name;
                self.progView.hidden = NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    /*
    CGRect timerRect = CGRectMake(50.0, 50.0, 220.0, 220.0);
    UIImageView *timerPic = [[UIImageView alloc] initWithFrame:timerRect];
    [timerPic setImage:[UIImage imageNamed:@"TimerCircle.png"]];
    [self.view addSubview:timerPic];
     */
}

- (void)viewDidAppear:(BOOL)animated{
    [self configureView];
}

- (void)viewDidUnload
{
    [self setTimMin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.task = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)start:(id)sender {
    if(running == NO){
        self.startTime = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setFormatterBehavior:NSDateFormatterBehaviorDefault];
        [formatter setTimeStyle:NSDateFormatterFullStyle];
        self.endTime = [NSDate dateWithTimeInterval:1200 sinceDate:self.startTime];
        NSCalendar *startCalendar = [NSCalendar currentCalendar];
        self.startComponents = [startCalendar components:NSCalendarCalendarUnit|NSMinuteCalendarUnit fromDate:self.startTime];
        self.startTimeMin = [self.startComponents minute];         
        timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(compareTimes) userInfo:nil repeats:YES];
        self.progView.hidden = NO;
        running = YES;
    }
    
}

- (IBAction)cancel:(id)sender {
        _timMin.text = @":00";
        self.progView.hidden = YES;
        self.progView.progress = 0;
        [timer invalidate];
        self.startTime = nil;
        running = NO;
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)compareTimes{
    ActTask *theTask = self.task;
    self.compareTime = [NSDate date];
    self.compareCalendar = [NSCalendar currentCalendar];
    self.compareComponents = [self.compareCalendar components:NSCalendarCalendarUnit|NSMinuteCalendarUnit fromDate:self.compareTime];
    self.compareTimeMin = [self.compareComponents minute];
    self.timeMinInt = self.compareTimeMin - self.startTimeMin;
    if ((self.timeMinInt == 0) && (self.compareTimeMin - self.startTimeMin > 1)){
        self.timeMinInt = 1;
    }
    if (self.timeMinInt<10) {
        self.timMin.text = [[NSString alloc] initWithFormat:@":0%i", self.timeMinInt];
    }
    else {
        self.timMin.text = [[NSString alloc] initWithFormat:@":%i", self.timeMinInt];
    }
    if (running == YES) {
        for (int k=1; k<=self.timeMinInt; k++) {
            self.progView.progress = (20*.05);
        }
    }
    if (self.progView.progress == 1) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        _timMin.text = @":00";
        NSNumber *newScore = [[NSNumber alloc] initWithInt:([theTask.score intValue] + [theTask.dimRtnVal intValue])];
        int dimCalc = ([theTask.dimRtnVal intValue]/2);
        NSNumber *newDimRtnVal = [[NSNumber alloc] initWithInt:dimCalc];
        theTask.score = newScore;
        theTask.dimRtnVal = newDimRtnVal;
        NSString *scoreLabelUpd =[[NSString alloc] initWithFormat:@"%i",[theTask.score intValue]];
        self.scoreLabel.text = scoreLabelUpd;
        self.progView.hidden = YES;
        self.progView.progress = 0;
        self.startTime = nil;
        self.compareTime = nil;
        [timer invalidate];
    }
}

@end
