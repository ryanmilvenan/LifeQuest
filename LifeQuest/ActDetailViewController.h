//
//  ActDetailViewController.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@protocol ActDetailViewControllerDelegate;
@class ActTask;

@interface ActDetailViewController : UIViewController{
    NSTimer *timer;
    UIButton *startButton;
    UIButton *cancelButton;
    UIProgressView *progView;
    BOOL running;
}

@property (nonatomic, strong)ActTask *task;
@property (nonatomic, weak)IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak)IBOutlet UILabel *timMin;
@property (nonatomic, weak)IBOutlet UIProgressView *progView;
@property (nonatomic, weak)NSDate *startTime;
@property (nonatomic, weak)NSDate *endTime;
@property (nonatomic, weak)NSDate *compareTime;
@property (nonatomic, strong)NSCalendar *startCalendar;
@property (nonatomic, strong)NSCalendar *compareCalendar;
@property (nonatomic, weak)NSDateComponents *startComponents;
@property (nonatomic, weak)NSDateComponents *compareComponents;
@property (nonatomic)NSInteger startTimeMin;
@property (nonatomic)NSInteger compareTimeMin;
@property (nonatomic)NSInteger timeMinInt;

@property (nonatomic, weak) id <ActDetailViewControllerDelegate> delegate;

- (IBAction)start:(id)sender;

- (IBAction)cancel:(id)sender;

@end

