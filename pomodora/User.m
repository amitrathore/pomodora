// 
//  User.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/4/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "User.h"
#import "Stat.h"

@implementation User 

@dynamic name;
@dynamic currentWeekGoal;
@dynamic stats;

@synthesize state;

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
	[self setState:1];
	return YES;
}

- (BOOL)finishPomodoro{
	[self setState:0];
	return YES;
}

- (BOOL)pausePomodoro{
	[self setState:2];
	return YES;
}

- (BOOL)resumePomodoro{
	[self setState:1];
	return YES;
}

- (BOOL)stopPomodoro{
	[self setState:0];
	return YES;
}


- (BOOL)isRunningPomodoro{
	return [self state] == 1;
}

- (BOOL)isPausedPomodoro{
	return [self state] == 2;
}

@end
