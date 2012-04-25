//
//  ActScoreContainer.m
//  Actualizer
//
//  Created by Ryan Milvenan on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kChore          @"chores"
#define kWork           @"work"
#define kSocial         @"social"
#define kSelf           @"self"
#define kDate           @"date"
#define kScoreContainer @"scoreContainer"

#import "ActScoreContainer.h"

@implementation ActScoreContainer

@synthesize scoreContainer = _scoreContainer;
@synthesize todaysDate = _todaysDate;
@synthesize choreData = _choreData;
@synthesize workData = _workData;
@synthesize socialData = _socialData;
@synthesize selfData = _selfData;

//Instance Methods

- (id)init{
    if(self = [super init]){
        NSMutableDictionary *aScoreContainer = [[NSMutableDictionary alloc] init];
        self.scoreContainer = aScoreContainer;
        self.choreData = [[ActDataController alloc] init];
        self.workData = [[ActDataController alloc] init];
        self.socialData = [[ActDataController alloc] init];
        self.selfData = [[ActDataController alloc] init];
        self.todaysDate = [NSDate date];
        
        [self.scoreContainer setValue:[self choreData] forKey:kChore];
        [self.scoreContainer setValue:[self workData] forKey:kWork];
        [self.scoreContainer setValue:[self socialData] forKey:kSocial];
        [self.scoreContainer setValue:[self selfData] forKey:kSelf];
        [self.scoreContainer setValue:[self todaysDate] forKey:kDate];
        return self;
    }
    return nil;
}

- (void)refreshScoreContainer{
    [self.scoreContainer setValue:[self choreData] forKey:kChore];
    [self.scoreContainer setValue:[self workData] forKey:kWork];
    [self.scoreContainer setValue:[self socialData] forKey:kSocial];
    [self.scoreContainer setValue:[self selfData] forKey:kSelf];
    [self.scoreContainer setValue:[self todaysDate] forKey:kDate];
}

//Saving Implementation

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[self choreData] forKey:kChore];
    [aCoder encodeObject:[self workData] forKey:kWork];
    [aCoder encodeObject:[self socialData] forKey:kSocial];
    [aCoder encodeObject:[self selfData] forKey:kSelf];
    [aCoder encodeObject:[self todaysDate] forKey:kDate];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.choreData = [aDecoder valueForKey:kChore];
        self.workData = [aDecoder valueForKey:kWork];
        self.socialData = [aDecoder valueForKey:kSocial];
        self.selfData = [aDecoder valueForKey:kSelf];
        self.todaysDate = [NSDate date];
        self.scoreContainer = [[NSMutableDictionary alloc] init];
        
        [self.scoreContainer setValue:[self choreData] forKey:kChore];
        [self.scoreContainer setValue:[self workData] forKey:kWork];
        [self.scoreContainer setValue:[self socialData] forKey:kSocial];
        [self.scoreContainer setValue:[self selfData] forKey:kSelf];
        [self.scoreContainer setValue:[self todaysDate] forKey:kDate];
        return self;
    }
    return nil;
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
    
    NSCalendar *aCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [aCalendar components:(NSCalendarCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:self.todaysDate];
    int monthInt = [components month];
    int dayInt = [components day];
    int yearInt = [components year];
    NSString *dateName = [NSString stringWithFormat:@"%i",monthInt];
    NSString *tempString = [NSString stringWithFormat:@"%i",dayInt];
    dateName = [dateName stringByAppendingString:tempString];
    tempString = [NSString stringWithFormat:@"%i",yearInt];
    dateName = [dateName stringByAppendingString:tempString];
    NSString *fileName = [dateName stringByAppendingString:@".score"];
    return [folder stringByAppendingPathComponent: fileName];    
}

- (void)saveDataToDisk
{
    NSString *path = [self pathForDataFile];
    
    NSMutableDictionary *rootObject;
    rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:[self scoreContainer] forKey:kScoreContainer];
    [NSKeyedArchiver archiveRootObject:rootObject toFile: path];
}

- (void)loadDataFromDisk
{   
    NSString *path = [self pathForDataFile];
    
    NSMutableDictionary *rootObject; 
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];    
    
    self.scoreContainer = [rootObject valueForKey:kScoreContainer];
    self.choreData = [self.scoreContainer valueForKey:kChore];
    self.workData = [self.scoreContainer valueForKey:kWork];
    self.socialData = [self.scoreContainer valueForKey:kSocial];
    self.selfData = [self.selfData valueForKey:kSelf];
}


@end
