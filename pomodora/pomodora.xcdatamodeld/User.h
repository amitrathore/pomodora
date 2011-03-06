//
//  User.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CalendarHelper.h"

@class Pomodoro;
@class Goal;

@interface User :  NSManagedObject  
{
	Pomodoro * currentPomodoro;
}

@property (nonatomic, retain) Pomodoro * currentPomodoro;

@property (nonatomic, retain) NSNumber * currentWeekGoal;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSSet* pomodoros;
@property (nonatomic, retain) NSSet* goals;

@end


@interface User (CoreDataGeneratedAccessors)

- (void)addPomodorosObject:(NSManagedObject *)value;
- (void)removePomodorosObject:(NSManagedObject *)value;
- (void)addPomodoros:(NSSet *)value;
- (void)removePomodoros:(NSSet *)value;

- (void)addGoalsObject:(NSManagedObject *)value;
- (void)removeGoalsObject:(NSManagedObject *)value;
- (void)addGoals:(NSSet *)value;
- (void)removeGoals:(NSSet *)value;


//method declaration
- (BOOL)finishPomodoro;
- (BOOL)pausePomodoro;
- (BOOL)resumePomodoro;
- (BOOL)stopPomodoro;
- (BOOL)startPomodoro;
- (BOOL)startResting;
- (BOOL)finishResting;

- (BOOL)isRunningPomodoro;
- (BOOL)isPausedPomodoro;
- (BOOL)isResting;

- (NSUInteger)todayCompleted;
- (NSUInteger)overallCompleted;
- (int)timerValue;
- (int)pomodoroTimerValue;
- (int)pauseTimerValue;
- (int)restTimerValue;
- (int)pausedTime;
- (int)restTime;

//Class methods

+ (User *)findOrCreateUser:(NSManagedObjectContext *)moc;

@end

