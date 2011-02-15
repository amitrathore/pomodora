// 
//  Pomodoro.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Pomodoro.h"

#import "User.h"
#import "Event.h"

@implementation Pomodoro 

@dynamic status;
@dynamic createdAt;
@dynamic desc;
@dynamic events;
@dynamic user;
@dynamic pausedTime;

- (void)addEventWithType:(NSString *)eventType {
	Event * event = (Event *)[NSEntityDescription
								 insertNewObjectForEntityForName:@"Event"
								 inManagedObjectContext:self.managedObjectContext];
	event.eventType = eventType;
	event.createdAt = [NSDate date];
	
	[self addEventsObject:event];
	
}

+ (Pomodoro *)createPomodoro:(NSManagedObjectContext *)moc {
	Pomodoro * newPomodoro = (Pomodoro *)[NSEntityDescription
										  insertNewObjectForEntityForName:@"Pomodoro"
										  inManagedObjectContext:moc];
	
	newPomodoro.createdAt = [NSDate date];
	return newPomodoro;
}

+ (Pomodoro *)findCurrentPomodoro:(NSManagedObjectContext *)moc {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Pomodoro" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	[request setFetchBatchSize:1];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"createdAt" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	
	return (Pomodoro *)[array lastObject];
}

+ (int)countCompletedPomodorosAfter:(NSDate *)date using:(NSManagedObjectContext *)moc{
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Pomodoro" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(createdAt >= %@) AND (status LIKE %@)", 
							   date,
							   @"COMPLETED"];
	[request setPredicate:predicate];
	
	NSError *error = nil;
	
	return (int)[moc countForFetchRequest:request error:&error];
}

@end
