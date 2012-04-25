//
//  ActTask.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActTask.h"

@implementation ActTask

@synthesize name = _name;
@synthesize score = _score;
@synthesize category = _category;
@synthesize dimRtnVal = _dimRtnVal;
@synthesize frequency = _frequency;
@synthesize date = _date;

-(id)initWithName:(NSString *)name category:(NSString *)category frequency:(NSString *)frequency score:(NSNumber *)score dimRtnVal:(NSNumber *)dimRtnVal date:(NSDate *)date{
    self = [super init];
    if(self){
        _name = name;
        _category = category;
        _frequency = frequency;
        _score = score;
        _dimRtnVal = dimRtnVal;
        _date = date;
        return self;
    }
    return nil;
}

-(NSNumber *)calculateScore:(NSNumber *)temp{
    int intTemp = [temp integerValue];
    intTemp += [[self score] intValue];
    temp = [NSNumber numberWithInt: intTemp];
    return temp;
}

-(void)resetScore{
    self.score = [NSNumber numberWithInt:0];
    self.dimRtnVal = [NSNumber numberWithInt:8];
}

#pragma mark NSCoding

#define kNameKey       @"Name"
#define kCategory      @"Category"
#define kFrequency     @"Frequency"
#define kScore         @"Score"
#define kDimRtnVal     @"DimRtnVal"
#define kDate          @"Date"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kNameKey];
    [encoder encodeObject:_category forKey:kCategory];
    [encoder encodeObject:_frequency forKey:kFrequency];
    [encoder encodeObject:_score forKey:kScore];
    [encoder encodeObject:_dimRtnVal forKey:kDimRtnVal];
    [encoder encodeObject:_date forKey:kDate];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:kNameKey];
        self.category = [decoder decodeObjectForKey:kCategory];
        self.frequency = [decoder decodeObjectForKey:kFrequency];
        self.score = [decoder decodeObjectForKey:kScore];
        self.dimRtnVal = [decoder decodeObjectForKey:kDimRtnVal];
        self.date = [decoder decodeObjectForKey:kDate];
    }
    return self;
}

@end
