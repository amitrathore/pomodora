// 
//  Goal.m
//  pomodora
//
//  Created by Siva Jagadeesan on 3/5/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Goal.h"

#import "Pomodoro.h"
#import "User.h"

@implementation Goal 

@dynamic name;
@dynamic completed;
@dynamic createdAt;
@dynamic user;
@dynamic pomodoros;
@dynamic weekGoal;


+ (NSArray *)findIncompletedGoals:(NSManagedObjectContext *)moc{
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Goal" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	[request setFetchBatchSize:1];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"createdAt" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(completed == %@)", NO];
	[request setPredicate:predicate];
	[predicate release];
	
	NSError *error = nil;
	return [moc executeFetchRequest:request error:&error];
}

@end
