//
//  ActLocalScoreFill.m
//  Actuator
//
//  Created by Ryan Milvenan on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActLocalScoreFill.h"

@implementation ActLocalScoreFill

@synthesize score = _score;
@synthesize name = _name;

-(id)initWithScore:(NSNumber *)score{
    self = [super init];
    if(self){
        _name = @"Current Category Score: ";
        _score = score;
        return self;
    }
    return nil;
}

#pragma mark NSCoding
#define kScore         @"Score"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_score forKey:kScore];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSNumber *score = [decoder decodeObjectForKey:kScore];
    return [self initWithScore:score];
}


@end
