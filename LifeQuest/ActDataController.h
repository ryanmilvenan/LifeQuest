//
//  ActDataController.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActTask;

@interface ActDataController : NSObject <NSCoding>

@property(nonatomic,copy)NSMutableArray *masterTaskList;
@property(nonatomic,strong)NSMutableArray *dailyTaskList;
@property(nonatomic,strong)NSMutableArray *weeklyTaskList; 
@property(nonatomic,strong)NSMutableArray *oneOffTaskList; 
@property(nonatomic,strong)NSString *catName;
@property(nonatomic,weak)NSNumber *localTotalScore;
@property(nonatomic,strong)NSNumber *oneOffScore;
@property(nonatomic,strong)NSDate *currentDate;
@property(nonatomic,strong)NSCalendar *curCal;

-(void)generateType:(NSString *)type;

-(NSUInteger)countOfAllLists;

-(NSUInteger)countOfList;

-(void)scoreOfList;

-(NSNumber *)getScoreOfList;

-(ActTask *)objectInListAtIndex:(int)array index:(NSUInteger)theIndex;

-(void)addTaskWithName:(NSString *)inputName category:(NSString *)inputCategory frequency:(NSString *)inputFrequency score:(NSNumber *)inputScore dimRtnVal:(NSNumber *)inputDimRtnVal date:(NSDate *)inputDate;

-(void)addOneOffTaskWithName:(NSString *)inputName category:(NSString *)inputCategory score:(NSNumber *)inputScore dimRtnVal:(NSNumber *)inputDimRtnVal date:(NSDate *)inputDate;

-(void)addScoreCell:(NSNumber *)inputScore;

-(void)encodeWithCoder:(NSCoder *)encoder;

-(id)initWithCoder:(NSCoder *)decoder;

-(void)saveDataToDisk;

-(void)loadDataFromDisk;

@end
