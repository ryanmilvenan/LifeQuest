//
//  ActCharacter.m
//  LifeQuest
//
//  Created by Ryan Milvenan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActCharacter.h"
#import "ActScoreContainer.h"

@implementation ActCharacter

@synthesize scoreDump = _scoreDump;

@synthesize masterLvl = _masterLvl;
@synthesize choreLvl = _choreLvl;
@synthesize choreXp = _choreXp;
@synthesize workLvl = _workLvl;
@synthesize workXp = _workXp;
@synthesize socialLvl = _socialLvl;
@synthesize socialXp = _socialXp;
@synthesize selfLvl = _selfLvl;
@synthesize selfXp = _selfXp;



- (id)init{
    //self.scoreDump = [self loadScoreFiles];
    
}


+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];   
    
    return documentsDirectory;
}

+ (NSMutableArray *)loadScoreFiles {
    
    // Get private docs dir
    NSString *documentsDirectory = [ActCharacter getPrivateDocsDir];
    NSLog(@"Loading scores from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create Array holding each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count - 4];
    for (NSString *file in files) {
        if ([file.pathExtension compare:@"score" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            ActScoreContainer *scoreContainer = [[ActScoreContainer alloc] initWithDocPath:fullPath];
            [retval addObject:scoreContainer];
        }
    }
    
    return retval;
}

- (int)getChoreXp{
    [self.scoreDump makeObjectsPerformSelector:@selector(calculateChoreXp) withObject:self.choreXp];
    return [self.choreXp intValue];
}
     
- (int)getWorkXp{
    [self.scoreDump makeObjectsPerformSelector:@selector(calculateWorkXp) withObject:self.workXp];
    return [self.choreXp intValue];
}
     
- (int)getSocialXp{
    [self.scoreDump makeObjectsPerformSelector:@selector(calculateSocialXp) withObject:self.socialXp];
    return [self.choreXp intValue];
}
     
- (int)getSelfXp{
    [self.scoreDump makeObjectsPerformSelector:@selector(calculateSelfXp) withObject:self.selfXp];
    return [self.choreXp intValue];
}


@end
