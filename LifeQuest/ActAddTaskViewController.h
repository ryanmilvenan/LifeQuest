//
//  ActAddTaskViewController.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActAddTaskViewControllerDelegate;



@interface ActAddTaskViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource> 
@property (weak, nonatomic) IBOutlet UITextField *taskNameInput;
@property (weak, nonatomic) IBOutlet UISegmentedControl *frequencyInput;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryInput;
@property (copy, nonatomic) NSString *frequencyString;
@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) id <ActAddTaskViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)removeKeyboard:(id)sender;
- (IBAction)segmentSelect:(id)sender;
- (IBAction)switchedOn:(id)sender;

@end

@protocol ActAddTaskViewControllerDelegate <NSObject>

-(void)actAddTaskViewControllerDidCancel:(ActAddTaskViewController *)controller;
-(void)actAddTaskViewControllerDidFinishTask:(ActAddTaskViewController *)controller name:(NSString *)name category:(NSString *)category frequency:(NSString *)frequency;
-(void)actAddTaskViewControllerDidFinishOneOff:(ActAddTaskViewController *)controller name:(NSString *)name category:(NSString *)category;

@end