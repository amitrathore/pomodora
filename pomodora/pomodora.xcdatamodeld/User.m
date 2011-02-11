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
		return (User *)[NSEntityDescription
						insertNewObjectForEntityForName:@"User"
						inManagedObjectContext:moc];		
	}
	NSLog(@"%s" , "Giving exisiting user");
	
	return  (User *)[array lastObject];
}

//Call Back functions

- (void)awakeFromInsert {
	[super awakeFromInsert];
	self.name = @"Default User";
	Stat * newStat = [Stat findOrCreateStat:[self managedObjectContext]];
	self.todaysStat = newStat;
	
	[self addStatsObject:newStat];	
}

- (void)awakeFromFetch {
	[super awakeFromFetch];
	self.todaysStat = [Stat findOrCreateStat:[self managedObjectContext]];
}

//Instance Methods

- (BOOL)startPomodoro{
	[self.todaysStat incrementStarts];
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
