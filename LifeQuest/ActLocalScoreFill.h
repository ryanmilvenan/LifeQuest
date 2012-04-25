//
//  ActLocalScoreFill.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActLocalScoreFill : NSObject <NSCoding>

@property(nonatomic,copy)NSNumber *score;
@property(nonatomic,copy)NSString *name;

-(id)initWithScore:(NSNumber *)score;

@end
