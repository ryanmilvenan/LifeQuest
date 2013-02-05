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

@property (nonatomic, strong)NSString *docPath;
@property (nonatomic, strong)NSMutableDictionary *scoreContainer;
@property (nonatomic, strong)NSDate *todaysDate;
@property (nonatomic, strong)ActDataController *choreData;
@property (nonatomic, strong)ActDataController *workData;
@property (nonatomic, strong)ActDataController *socialData;
@property (nonatomic, strong)ActDataController *selfData;
@property (nonatomic, strong)NSNumber *choreScore;
@property (nonatomic, strong)NSNumber *workScore;
@property (nonatomic, strong)NSNumber *socialScore;
@property (nonatomic, strong)NSNumber *selfScore;

- (id)initWithDocPath:(NSString *)docPath;

- (void)refreshScoreContainer;

- (int)calculateChoreXp;

- (int)calculateWorkXp;

- (int)calculateSocialXp;

- (int)calculateSelfXp;

- (void)saveDataToDisk;

- (void)loadDataFromDisk;

@end
