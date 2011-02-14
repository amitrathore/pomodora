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

@interface User :  NSManagedObject  
{
	Pomodoro * currentPomodoro;
}

@property (nonatomic, retain) Pomodoro * currentPomodoro;

@property (nonatomic, retain) NSNumber * currentWeekGoal;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* pomodoros;

@end


@interface User (CoreDataGeneratedAccessors)

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
- (BOOL)isResting;

- (NSUInteger)todayCompleted;
- (NSUInteger)overallCompleted;
- (int)timerValue;
- (int)pomodoroTimerValue;
- (int)pauseTimerValue;
- (int)restTimerValue;
- (int)pausedTime;

//Class methods

+ (User *)findOrCreateUser:(NSManagedObjectContext *)moc;

@end

