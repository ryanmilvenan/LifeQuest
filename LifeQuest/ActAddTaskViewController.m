//
//  ActAddTaskViewController.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActAddTaskViewController.h"

@interface ActAddTaskViewController ()

@end

@implementation ActAddTaskViewController
@synthesize taskNameInput = _taskNameInput;
@synthesize categoryInput = _categoryInput;
@synthesize frequencyInput = _frequencyInput;
@synthesize frequencyLabel = _frequencyLabel;
@synthesize frequencyString = _frequencyString;
@synthesize pickerArray = _pickerArray;
@synthesize delegate = _delegate;
BOOL isOneOffTask = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //On loading, populate picker view
    [super viewDidLoad];
    NSArray *pickerArrayLoader = [[NSArray alloc] initWithObjects:@"Chores", @"Work",@"Social",@"Self", nil];
    self.pickerArray = pickerArrayLoader;
    self.frequencyString = @"Daily";
    isOneOffTask = NO;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    //Unload everything
    [self setFrequencyInput:nil];
    [self setTaskNameInput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [[self delegate] actAddTaskViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    
    if ([self.taskNameInput.text length]>0 && isOneOffTask == NO) {
        [[self delegate] actAddTaskViewControllerDidFinishTask:self name:self.taskNameInput.text category:[_pickerArray objectAtIndex:[_categoryInput selectedRowInComponent:0]] frequency:_frequencyString];
    }else if([self.taskNameInput.text length]>0 && isOneOffTask == YES){
        [[self delegate] actAddTaskViewControllerDidFinishOneOff:self name:self.taskNameInput.text category:[_pickerArray objectAtIndex:[_categoryInput selectedRowInComponent:0]]];
    }
    else { 
        [[self delegate] actAddTaskViewControllerDidCancel:self];
    }
}

- (IBAction)removeKeyboard:(id)sender {
    [_taskNameInput resignFirstResponder];
}

- (IBAction)segmentSelect:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        _frequencyString = @"Daily";
    }else {
        _frequencyString = @"Weekly";
    }
}

- (IBAction)switchedOn:(id)sender {
    UISwitch *oneOffSwitch = (UISwitch *)sender;
    BOOL yesNo = oneOffSwitch.isOn;
    if (yesNo == YES) {
        self.frequencyInput.hidden = YES;
        self.frequencyLabel.hidden = YES;
        self.frequencyInput = nil;
        isOneOffTask = YES;
    }
    if (yesNo == NO) {
        self.frequencyInput.hidden = NO;
        self.frequencyLabel.hidden = NO;
        isOneOffTask = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.taskNameInput) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerArray objectAtIndex:row];
}
@end
