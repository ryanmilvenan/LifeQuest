//
//  ActCharacter.h
//  LifeQuest
//
//  Created by Ryan Milvenan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActCharacter : NSObject

@property(nonatomic, strong)NSArray *scoreDump;

@property(nonatomic,strong)NSNumber *masterLvl;
@property(nonatomic,strong)NSNumber *choreLvl;
@property(nonatomic,strong)NSNumber *choreXp;
@property(nonatomic,strong)NSNumber *workLvl;
@property(nonatomic,strong)NSNumber *workXp;
@property(nonatomic,strong)NSNumber *socialLvl;
@property(nonatomic,strong)NSNumber *socialXp;
@property(nonatomic,strong)NSNumber *selfLvl;
@property(nonatomic,strong)NSNumber *selfXp;

@end
