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
@dynamic pomodoros;

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
	[currentPomodoro addEventWithType:@"START"];
	return YES;
}

- (BOOL)finishPomodoro{
	currentPomodoro.status = @"COMPLETED";
	[currentPomodoro addEventWithType:@"COMPLETE"];
	return YES;
}

- (BOOL)pausePomodoro{
	currentPomodoro.status = @"INTERRUPTED";
	[currentPomodoro addEventWithType:@"INTERRUPT"];
	return YES;
}

- (BOOL)resumePomodoro{
	currentPomodoro.status = @"STARTED";
	int pausedTime = [currentPomodoro.pausedTime intValue] + [self pausedTime];
	currentPomodoro.pausedTime = [NSNumber numberWithInt:pausedTime];
	[currentPomodoro addEventWithType:@"RESUME"];
	return YES;
}

- (BOOL)stopPomodoro{
	currentPomodoro.status = @"ABORTED";
	[currentPomodoro addEventWithType:@"ABORT"];
	return YES;
}

- (BOOL)isRunningPomodoro{
	return (currentPomodoro && currentPomodoro.status == @"STARTED");
}

- (BOOL)isPausedPomodoro{
	return (currentPomodoro && currentPomodoro.status == @"INTERRUPTED");
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
	int defaultPomodorTime = 10;
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
	int defaultRestTime = 11;
	Event * event = [Event findLastEventWithEventType:@"COMPLETE" using:self.managedObjectContext];
	
	if (event == nil) {
		return 0;
	}
	return defaultRestTime - (int)[[NSDate date] timeIntervalSinceDate:event.createdAt];
}

@end
