// 
//  Stat.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import "Stat.h"

#import "User.h"

@implementation Stat 

@dynamic noAborted;
@dynamic noCompleted;
@dynamic noOfInterruptions;
@dynamic date;
@dynamic noStarted;
@dynamic noOfResumes;
@dynamic user;

+ (Stat *)findOrCreateStat:(NSManagedObjectContext *)moc {
	
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Stat" inManagedObjectContext:moc];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entityDescription];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
										initWithKey:@"date" ascending:NO];
	
	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	[sortDescriptor release];
	
	NSError *error = nil;
	NSArray *array = [moc executeFetchRequest:request error:&error];
	
	if (array == nil || ([array count] == 0)) 
	{
		Stat * stat = (Stat *)[NSEntityDescription
							   insertNewObjectForEntityForName:@"Stat"
							   inManagedObjectContext:moc];		
		
		stat.date = [NSDate	date];
		
		return stat;
	}
	
	return (Stat *)[array lastObject];
}


- (void)incrementStarted{
	self.noStarted = [self increment:self.noStarted];
}

- (void)incrementAborted{
	self.noAborted = [self increment:self.noAborted];
}

- (void)incrementCompleted{
	self.noCompleted = [self increment:self.noCompleted];
}

- (void)incrementInterruptions{
	self.noOfInterruptions = [self increment:self.noOfInterruptions];
}

- (void)incrementResumes{
	self.noOfResumes = [self increment:self.noOfResumes];
}

- (NSNumber *)increment:(NSNumber *)number{
	return [NSNumber numberWithInt:[number intValue]+1];
}


@end
