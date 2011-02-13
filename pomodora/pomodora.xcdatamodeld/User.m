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
@synthesize todaysStat;
@synthesize currentPomodoro;

@dynamic currentWeekGoal;
@dynamic name;
@dynamic stats;
@dynamic pomodoros;

// Class Methods

+ (User *)findOrCreateUser:(NSManagedObjectContext *)moc {
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"User" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
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
		
		Stat * stat = [Stat findOrCreateStat:moc];
		stat.user = user;
		
		user.todaysStat = stat;
		
		[user addStatsObject:stat];
		
		return user;
	}
	NSLog(@"%s" , "Giving exisiting user");
	
	User * user =   (User *)[array lastObject];
	
	user.todaysStat = [Stat findOrCreateStat:moc];
	
	return user;
}

//Instance Methods

- (BOOL)startPomodoro{
	[self.todaysStat incrementStarted];
	self.status = @"STARTED";
	return YES;
}

- (BOOL)finishPomodoro{
	[self.todaysStat incrementCompleted];
	self.status = @"COMPLETED";
	return YES;
}

- (BOOL)pausePomodoro{
	[self.todaysStat incrementInterruptions];
	self.status = @"INTERRUPTED";
	return YES;
}

- (BOOL)resumePomodoro{
	[self.todaysStat incrementResumes];
	self.status = @"STARTED";
	return YES;
}

- (BOOL)stopPomodoro{
	[self.todaysStat incrementAborted];
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
