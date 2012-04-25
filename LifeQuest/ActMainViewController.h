//
//  ActMainViewController.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActDataController.h"
@class ActDataController;
@class ActScoreContainer;

@interface ActMainViewController : UIViewController
@property(nonatomic,strong)ActScoreContainer *scoreContainer;
@property(nonatomic,strong)ActDataController *choreDataController;
@property(nonatomic,strong)ActDataController *workDataController;
@property(nonatomic,strong)ActDataController *socialDataController;
@property(nonatomic,strong)ActDataController *selfDataController;
@property(nonatomic,weak)IBOutlet UILabel *mainScoreLabel;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;
@property(nonatomic,strong)NSDate *todaysDate;
@property(nonatomic,strong)NSCalendar *mainCal;
@property(nonatomic,strong)NSDateFormatter *mainDateFormatter;
@property(nonatomic,weak)UIImageView *background;

- (void)calculateTotalScore;

- (void)syncScoreContainer;

@end
