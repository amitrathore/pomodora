// 
//  Pomodoro.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Pomodoro.h"

#import "User.h"

@implementation Pomodoro 

@dynamic status;
@dynamic createdAt;
@dynamic desc;
@dynamic events;
@dynamic user;

+ (Pomodoro *) createPomodoro:(NSManagedObjectContext *)managedObjectContext {
	
	Pomodoro *newPomodoro = (Pomodoro *)[NSEntityDescription
										 insertNewObjectForEntityForName:@"Pomodoro"
										 inManagedObjectContext:managedObjectContext];
	
	newPomodoro.status = @"START";
	return	newPomodoro;
}
	

+ (Pomodoro *)findOrCreatePomodoro:(NSManagedObjectContext *)managedObjectContext {
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Pomodoro" inManagedObjectContext:managedObjectContext];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	request.fetchLimit = 1;
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"createdAt" ascending:NO];
	
	
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
	
	if (array == nil || ([array count] == 0)) 
	{
		return [self createPomodoro:managedObjectContext];
	}
	
	
	return (Pomodoro *)[array objectAtIndex:0 ];
	
}

@end
