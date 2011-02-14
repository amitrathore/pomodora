// 
//  Event.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Event.h"

#import "Pomodoro.h"

@implementation Event 

@dynamic createdAt;
@dynamic eventType;
@dynamic pomodoro;

+ (Event *)findLastEventWithEventType:(NSString *)evenType using:(NSManagedObjectContext *)moc{
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Event" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(createdAt >= %@) AND (eventType LIKE %@)", 
							   [CalendarHelper startOfToday],
							   evenType];
	[request setPredicate:predicate];
	
	[request setFetchBatchSize:1];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"createdAt" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	
	if (array == nil || ([array count] == 0)) {
		return nil;
	}
	
	return  (Event *)[array objectAtIndex:0];}

@end
