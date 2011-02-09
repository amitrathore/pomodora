//
//  User.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Stat;

@interface User :  NSManagedObject  
{
	NSString * status;
}

@property (nonatomic, retain) NSString * status;

@property (nonatomic, retain) NSNumber * currentWeekGoal;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* stats;
@property (nonatomic, retain) NSSet* pomodoros;

@end


@interface User (CoreDataGeneratedAccessors)
- (void)addStatsObject:(Stat *)value;
- (void)removeStatsObject:(Stat *)value;
- (void)addStats:(NSSet *)value;
- (void)removeStats:(NSSet *)value;

- (void)addPomodorosObject:(NSManagedObject *)value;
- (void)removePomodorosObject:(NSManagedObject *)value;
- (void)addPomodoros:(NSSet *)value;
- (void)removePomodoros:(NSSet *)value;

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

