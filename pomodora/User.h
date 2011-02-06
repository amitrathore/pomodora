//
//  User.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/4/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Stat;

@interface User :  NSManagedObject  
{
	int state;
}

@property (nonatomic, assign) int state;

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * currentWeekGoal;
@property (nonatomic, retain) NSSet* stats;

@end


@interface User (CoreDataGeneratedAccessors)

- (void)addStatsObject:(Stat *)value;
- (void)removeStatsObject:(Stat *)value;
- (void)addStats:(NSSet *)value;
- (void)removeStats:(NSSet *)value;

//method declaration
- (BOOL)finishPomodoro;
- (BOOL)pausePomodoro;
- (BOOL)resumePomodoro;
- (BOOL)stopPomodoro;
- (BOOL)startPomodoro;

- (BOOL)isRunningPomodoro;
- (BOOL)isPausedPomodoro;

// Class methods 

+ (User *)findOrCreateUser:(NSManagedObjectContext *)managedObjectContext;

@end

