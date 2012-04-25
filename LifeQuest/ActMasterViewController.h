//
//  ActMasterViewController.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActDataController;
@class ActCustomCellView;

@interface ActMasterViewController : UITableViewController

@property(nonatomic,strong)ActDataController *dataController;
@property(nonatomic,weak)NSString *category;
@property(nonatomic,weak)NSString *scoreString;

- (void)updateScoreString;

@end
