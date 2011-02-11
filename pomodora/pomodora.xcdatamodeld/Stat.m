// 
//  Stat.m
//  pomodora
//
//  Created by Siva Jagadeesan on 2/8/11.
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

- (void)incrementCompleted {
	self.noCompleted++;
}

- (void)incrementAborted {
	self.noAborted++;
}

- (void)incrementInterruptions{
	self.noOfInterruptions++;
}

- (void)incrementStarts {
	self.noStarted++;
}

- (void)incrementResumes {
	self.noOfInterruptions++;
}

+ (Stat *)findOrCreateStat:(NSManagedObjectContext *)moc {
	Stat * newStat = (Stat *)[NSEntityDescription
							  insertNewObjectForEntityForName:@"Stat"
							  inManagedObjectContext:moc];
	
	[newStat setDate:[NSDate date]];
	
	
	return newStat;
}

@end
