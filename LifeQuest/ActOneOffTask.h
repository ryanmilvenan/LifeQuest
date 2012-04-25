//
//  ActOneOffTask.h
//  Actuator
//
//  Created by Ryan Milvenan on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActOneOffTask : NSObject <NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *category;
@property(nonatomic,strong)NSNumber *score;
@property(nonatomic,strong)NSNumber *dimRtnVal;
@property(nonatomic,strong)NSDate *date;

-(id)initWithName:(NSString *)name category:(NSString *)category score:(NSNumber *)score dimRtnVal:(NSNumber *)dimRtnVal date:(NSDate *)date;

-(NSNumber *)calculateScore:(NSNumber *)temp;

- (void)encodeWithCoder:(NSCoder *)encoder;

- (id)initWithCoder:(NSCoder *)decoder;

@end
