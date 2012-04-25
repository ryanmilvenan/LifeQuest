//
//  ActDataController.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActDataController.h"
#import "ActTask.h"
#import "ActOneOffTask.h"
#import "ActLocalScoreFill.h"
#define kDaily      @"daily"
#define kWeekly     @"weekly"
#define kOneOff     @"oneOff"
#define kDate       @"date"
#define kCalendar   @"calendar"
#define kCatName    @"catName"


@interface ActDataController ()
-(void)initializeDefaultDataList;
@end

@implementation ActDataController

@synthesize masterTaskList = _masterTaskList;
@synthesize dailyTaskList = _dailyTaskList;
@synthesize weeklyTaskList = _weeklyTaskList;
@synthesize oneOffTaskList = _oneOffTaskList;
@synthesize catName = _catName;
@synthesize localTotalScore = _localTotalScore;
@synthesize oneOffScore = _oneOffScore;
@synthesize currentDate = _currentDate;
@synthesize curCal = _curCal;


-(void)initializeDefaultDataList{
    _dailyTaskList = [[NSMutableArray alloc] init];
    _weeklyTaskList = [[NSMutableArray alloc] init];
    _oneOffTaskList = [[NSMutableArray alloc] init];
    NSMutableArray *blankScoreList = [[NSMutableArray alloc] init];
    NSMutableArray *completeTaskList = [[NSMutableArray alloc] init];
    [completeTaskList addObject:_dailyTaskList];
    [completeTaskList addObject:_weeklyTaskList];
    [completeTaskList addObject:_oneOffTaskList];
    [completeTaskList addObject:blankScoreList];
    self.localTotalScore = 0;
    self.masterTaskList = completeTaskList;
}

-(void)setMasterTaskList:(NSMutableArray *)newList{
    if(_masterTaskList != newList){
        _masterTaskList = [newList mutableCopy];
    }
}

-(id)init{
    if(self = [super init]){
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

-(void)generateType:(NSString *)type{
    if([type isEqualToString:@"Chores"]){
        self.catName = @"Chores";
        [self loadDataFromDisk];
    }
    if([type isEqualToString:@"Social"]){
        self.catName = @"Social";
        [self loadDataFromDisk];
    }
    if([type isEqualToString:@"Self"]){
        self.catName = @"Self";
        [self loadDataFromDisk];
    }
    if([type isEqualToString:@"Work"]){
        self.catName = @"Work";
        [self loadDataFromDisk];
    }
}

-(NSUInteger)countOfAllLists{
    NSUInteger temp = 0;
    temp += [_dailyTaskList count];
    temp += [_weeklyTaskList count];
    temp += [_oneOffTaskList count];
    return temp;
}

-(NSUInteger)countOfList{
    return [self.masterTaskList count];
}

-(void)scoreOfList{
    int temp = 0;
    if ([[self.masterTaskList objectAtIndex:0] count]>0) {
        for (int k = 0; k<([self.dailyTaskList count]); k++) {
            ActTask *tempTask1 = [self.dailyTaskList objectAtIndex:k];
            temp += [tempTask1.score integerValue];
        }
    }
    if ([[self.masterTaskList objectAtIndex:1] count]>0) {
        for (int k = 0; k<([self.weeklyTaskList count]); k++) {
            ActTask *tempTask2 = [self.weeklyTaskList objectAtIndex:k];
            temp += [tempTask2.score integerValue];
        }
    }
    temp += [self.oneOffScore intValue];
    _localTotalScore = [NSNumber numberWithInt:temp];
}

-(ActTask *)objectInListAtIndex:(int)array index:(NSUInteger)theIndex{
    if(array == 0) {
        return [self.dailyTaskList objectAtIndex:theIndex];
    }
    else if(array == 1) {
        return [self.weeklyTaskList objectAtIndex:theIndex];
    }
    else {
        return [self.oneOffTaskList objectAtIndex:theIndex];
    }
}

-(void)addTaskWithName:(NSString *)inputName category:(NSString *)inputCategory frequency:(NSString *)inputFrequency 
    score:(NSNumber *)inputScore dimRtnVal:(NSNumber *)inputDimRtnVal date:(NSDate *)inputDate{
    ActTask *task = [[ActTask alloc] initWithName:inputName category:inputCategory frequency:inputFrequency score:inputScore dimRtnVal:inputDimRtnVal date:inputDate];
    if ([inputFrequency isEqualToString:@"Daily"]){
        [self.dailyTaskList addObject:task];
    }
    else if([inputFrequency isEqualToString:@"Weekly"]){
        [self.weeklyTaskList addObject:task];
    }
    
}

-(void)addOneOffTaskWithName:(NSString *)inputName category:(NSString *)inputCategory score:(NSNumber *)inputScore dimRtnVal:(NSNumber *)inputDimRtnVal date:(NSDate *)inputDate{
    ActOneOffTask *oneOffTask = [[ActOneOffTask alloc] initWithName:inputName category:inputCategory score:inputScore dimRtnVal:inputDimRtnVal date:inputDate];
    [self.oneOffTaskList addObject:oneOffTask];
}

-(void)addScoreCell:(NSNumber *)inputScore{
    ActLocalScoreFill *localScoreFill = [[ActLocalScoreFill alloc] initWithScore:inputScore];
    [[self.masterTaskList objectAtIndex:3] addObject:localScoreFill];
}

//Save Data Implementation

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.catName forKey:kCatName];
    [coder encodeObject:self.currentDate forKey:kDate];
    [coder encodeObject:self.curCal forKey:kCalendar];
    [coder encodeObject:self.dailyTaskList forKey:kDaily];
    [coder encodeObject:self.weeklyTaskList forKey:kWeekly];
    [coder encodeObject:self.oneOffTaskList forKey:kOneOff];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        [self setCatName:[decoder decodeObjectForKey:kCatName]];
        [self setCurrentDate:[decoder decodeObjectForKey:kDate]];
        [self setCurCal:[decoder decodeObjectForKey:kCalendar]];
        [self setDailyTaskList:[decoder decodeObjectForKey:kDaily]];
        [self setWeeklyTaskList:[decoder decodeObjectForKey:kWeekly]];
        [self setOneOffTaskList:[decoder decodeObjectForKey:kOneOff]];
    }
    return self;
}

- (NSString *)pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *folder = [paths objectAtIndex:0];
    folder = [folder stringByAppendingPathComponent:@"Private Documents"];
    
    if ([fileManager fileExistsAtPath:folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *tempCatName = self.catName;
    NSString *fileName = [tempCatName stringByAppendingString:@".tasks"];
    return [folder stringByAppendingPathComponent: fileName];    
}

- (void)saveDataToDisk
{
    NSString *path = [self pathForDataFile];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:[self dailyTaskList] forKey:kDaily];
    [rootObject setValue:[self weeklyTaskList] forKey:kWeekly];
    [rootObject setValue:[self oneOffTaskList] forKey:kOneOff];
    [rootObject setValue:[self currentDate] forKey:kDate];
    [rootObject setValue:[self curCal] forKey:kCalendar];
    [NSKeyedArchiver archiveRootObject:rootObject toFile: path];
}

- (void)loadDataFromDisk
{   
    
    NSString *path = [self pathForDataFile];
    
    NSDictionary *rootObject; 
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (rootObject == nil) {
        [self initializeDefaultDataList];
    }else {
        NSMutableArray *masterTemp = [[NSMutableArray alloc] init];
        self.dailyTaskList = [rootObject valueForKey:kDaily];
        [masterTemp addObject:self.dailyTaskList];
        self.weeklyTaskList = [rootObject valueForKey:kWeekly];
        [masterTemp addObject:self.weeklyTaskList];
        self.oneOffTaskList = [rootObject valueForKey:kOneOff];
        [masterTemp addObject:self.oneOffTaskList];
        NSMutableArray *blankScore = [[NSMutableArray alloc] init];
        [masterTemp addObject:blankScore];
        self.masterTaskList = masterTemp;
        
        NSDateComponents *newCalDays = [self.curCal components:NSCalendarCalendarUnit|NSDayCalendarUnit fromDate:self.currentDate];
        
        NSDateComponents *compCalDays = [[rootObject valueForKey:kCalendar] components:NSCalendarCalendarUnit|NSDayCalendarUnit fromDate:[rootObject valueForKey:kDate]];
        
        int newDayInt = [newCalDays day];
        int compDayInt = [compCalDays day];
        if (newDayInt>compDayInt) {
            [self.dailyTaskList makeObjectsPerformSelector:@selector(resetScore)];
            [self.weeklyTaskList makeObjectsPerformSelector:@selector(resetScore)];
        }
    }
}
@end
