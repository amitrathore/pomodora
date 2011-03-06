// 
//  User.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "User.h"
#import "Event.h"
#import "Pomodoro.h"

@implementation User 

@synthesize currentPomodoro;

@dynamic currentWeekGoal;
@dynamic name;
@dynamic mode;
@dynamic pomodoros;
@dynamic goals;

// Class Methods

+ (User *)findOrCreateUser:(NSManagedObjectContext *)moc {
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"User" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	[request setFetchBatchSize:1];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"name" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	
	if (array == nil || ([array count] == 0)) 
	{
		User * user = (User *)[NSEntityDescription
							   insertNewObjectForEntityForName:@"User"
							   inManagedObjectContext:moc];		
		
		return user;
	}
	NSLog(@"%s" , "Giving exisiting user");
	
	User * user =   (User *)[array lastObject];
	
	user.currentPomodoro = [Pomodoro findCurrentPomodoro:user.managedObjectContext];
	
	return user;
}

//Instance Methods

- (BOOL)startPomodoro{
	Pomodoro * pomodoro = [Pomodoro createPomodoro:self.managedObjectContext];
	self.currentPomodoro = pomodoro;
	[self addPomodorosObject:pomodoro];
	currentPomodoro.status = @"STARTED";
	self.mode = @"STARTED";
	[currentPomodoro addEventWithType:@"START"];
	return YES;
}

- (BOOL)finishPomodoro{
	currentPomodoro.status = @"COMPLETED";
	NSDate * completedDate = [CalendarHelper beforeSeconds:(-1 * [self pomodoroTimerValue])];
	[currentPomodoro addEventWithType:@"COMPLETE" andDate:completedDate];
	self.mode = @"STOPPED";
	return YES;
}

- (BOOL)pausePomodoro{
	currentPomodoro.status = @"INTERRUPTED";
	[currentPomodoro addEventWithType:@"INTERRUPT"];
	self.mode = @"PAUSED";
	return YES;
}

- (BOOL)resumePomodoro{
	currentPomodoro.status = @"STARTED";
	int pausedTime = [currentPomodoro.pausedTime intValue] + [self pausedTime];
	currentPomodoro.pausedTime = [NSNumber numberWithInt:pausedTime];
	[currentPomodoro addEventWithType:@"RESUME"];
	self.mode = @"STARTED";
	return YES;
}

- (BOOL)stopPomodoro{
	currentPomodoro.status = @"ABORTED";
	[currentPomodoro addEventWithType:@"ABORT"];
	self.mode = @"STOPPED";
	return YES;
}

- (BOOL)startResting{
	NSLog(@"%s" , "Start Resting");
	self.mode = @"RESTING";
	return YES;
}

- (BOOL)finishResting{
	NSLog(@"%s" , "Finish Resting");
	self.mode = @"STOPPED";
	return YES;
}

- (BOOL)isRunningPomodoro{
	return (self.mode == @"STARTED");
}

- (BOOL)isPausedPomodoro{
	return  (self.mode == @"PAUSED");
}

- (NSUInteger)todayCompleted{
	NSManagedObjectContext * moc = self.managedObjectContext;
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Event" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(createdAt >= %@) AND (eventType LIKE %@)", 
								[CalendarHelper startOfToday],
								@"COMPLETE"];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	return [moc countForFetchRequest:request error:&error];
}

- (NSUInteger)overallCompleted{
	NSManagedObjectContext * moc = self.managedObjectContext;
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Event" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(eventType LIKE %@)", @"COMPLETE"];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	return [moc countForFetchRequest:request error:&error];
}

- (int)timerValue {
	if ([self isRunningPomodoro]) {
		return [self pomodoroTimerValue];
	}
	
	if ([self isPausedPomodoro]) {
		return [self pauseTimerValue];
	}
	
	return [self restTimerValue];
}	

- (int)pomodoroTimerValue{
	int defaultPomodorTime = 3;
	int lapsedTime = (int)[[NSDate date] timeIntervalSinceDate:self.currentPomodoro.createdAt];
	return defaultPomodorTime - lapsedTime + [currentPomodoro.pausedTime intValue];
}

- (int)pausedTime{
	Event * event = [Event findLastEventWithEventType:@"INTERRUPT" using:self.managedObjectContext];
	
	if (event == nil) {
		return 0;
	}
	return (int)[[NSDate date] timeIntervalSinceDate:event.createdAt];
}

- (int)pauseTimerValue{
	int defaultPauseTime = 5;
	int pauseTimer = defaultPauseTime - [self pausedTime];
	if (pauseTimer < 0) {
		return 0;
	}
	return pauseTimer;
}

- (int)restTimerValue{
	int defaultRestTime = [self restTime];
	Event * event = [Event findLastEventWithEventType:@"COMPLETE" using:self.managedObjectContext];
	
	if (event == nil) {
		return 0;
	}
	return defaultRestTime - (int)[[NSDate date] timeIntervalSinceDate:event.createdAt];
}

- (int)restTime {
	int shortRestTime = 5;
	int longRestTime = 10;
	
	int completed = (int)[self todayCompleted] % 4;
	
	if (completed == 0) {
		return longRestTime;
	}else {
		return shortRestTime;
	}

	
}

@end
