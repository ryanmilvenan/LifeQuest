//
//  ActOneOffTask.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActOneOffTask.h"

@implementation ActOneOffTask

@synthesize name = _name;
@synthesize category = _category;
@synthesize score = _score;
@synthesize dimRtnVal = _dimRtnVal;
@synthesize date = _date;

-(id)initWithName:(NSString *)name category:(NSString *)category score:(NSNumber *)score dimRtnVal:(NSNumber *)dimRtnVal date:(NSDate *)date{
    self = [super init];
    if(self){
        _name = name;
        _category = category;
        _score = score;
        _dimRtnVal = dimRtnVal;
        _date = date;
    return self;
    }
    return nil;
}

-(NSNumber *)calculateScore:(NSNumber *)temp{
    int intTemp = [temp integerValue];
    intTemp += [self.score intValue];
    temp = [NSNumber numberWithInt: intTemp];
    return temp;
}


#pragma mark NSCoding

#define kNameKey       @"Name"
#define kCategory      @"Category"
#define kScore         @"Score"
#define kDimRtnVal     @"DimRtnVal"
#define kDate          @"Date"

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:kNameKey];
    [coder encodeObject:_category forKey:kCategory];
    [coder encodeObject:_score forKey:kScore];
    [coder encodeObject:_dimRtnVal forKey:kDimRtnVal];
    [coder encodeObject:_date forKey:kDate];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:kNameKey];
        self.category = [decoder decodeObjectForKey:kCategory];
        self.score = [decoder decodeObjectForKey:kScore];
        self.dimRtnVal = [decoder decodeObjectForKey:kDimRtnVal];
        self.date = [decoder decodeObjectForKey:kDate];
    }
    return self;
}

@end
