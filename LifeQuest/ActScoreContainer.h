//
//  ActScoreContainer.h
//  Actualizer
//
//  Created by Ryan Milvenan on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActDataController;

#import "ActDataController.h"

@interface ActScoreContainer : NSObject <NSCoding>

@property (nonatomic, strong)NSMutableDictionary *scoreContainer;
@property (nonatomic, strong)NSDate *todaysDate;
@property (nonatomic, strong)ActDataController *choreData;
@property (nonatomic, strong)ActDataController *workData;
@property (nonatomic, strong)ActDataController *socialData;
@property (nonatomic, strong)ActDataController *selfData;

- (void)refreshScoreContainer;

- (void)saveDataToDisk;

- (void)loadDataFromDisk;

@end
