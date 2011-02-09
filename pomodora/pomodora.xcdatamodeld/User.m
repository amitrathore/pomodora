// 
//  User.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "User.h"

#import "Stat.h"
#import "Pomodoro.h"

@implementation User 

@synthesize status;

@dynamic currentWeekGoal;
@dynamic name;
@dynamic stats;
@dynamic pomodoros;

//Class Methods

+ (User *)findOrCreateUser:(NSManagedObjectContext *)managedObjectContext {
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"User" inManagedObjectContext:managedObjectContext];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"name" ascending:YES];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
	if (array == nil || ([array count] == 0)) 
	{
		NSLog(@"%s" , "User is getting created for the first time");
		User *newUser = (User *)[NSEntityDescription
								 insertNewObjectForEntityForName:@"User"
								 inManagedObjectContext:managedObjectContext];
		
		[newUser setName:@"Default User"];
		return newUser;
	}
	NSLog(@"%s" , "Giving exisiting user");
	
	return (User *)[array objectAtIndex:0 ];
	
}

//Instance Methods

- (BOOL)startPomodoro{
	self.status = @"STARTED";
	return YES;
}

- (BOOL)finishPomodoro{
	self.status = @"COMPLETED";
	return YES;
}

- (BOOL)pausePomodoro{
	self.status = @"INTERRUPTED";
	return YES;
}

- (BOOL)resumePomodoro{
	self.status = @"STARTED";
	return YES;
}

- (BOOL)stopPomodoro{
	self.status = @"ABORTED";
	return YES;
}


- (BOOL)isRunningPomodoro{
	return (self.status == @"STARTED");
}

- (BOOL)isPausedPomodoro{
	return (self.status == @"INTERRUPTED");
}

@end
