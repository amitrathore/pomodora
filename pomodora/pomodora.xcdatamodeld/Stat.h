//
//  Stat.h
//  pomodora
//
//  Created by Siva Jagadeesan on 2/13/11.
//  Copyright 2011 Thoughtworks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CalendarHelper.h"

@class User;

@interface Stat :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * noAborted;
@property (nonatomic, retain) NSNumber * noCompleted;
@property (nonatomic, retain) NSNumber * noOfInterruptions;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * noStarted;
@property (nonatomic, retain) NSNumber * noOfResumes;
@property (nonatomic, retain) User * user;


- (void)incrementStarted;
- (void)incrementAborted;
- (void)incrementCompleted;
- (void)incrementInterruptions;
- (void)incrementResumes;

- (NSNumber *)increment:(NSNumber *)number;

+ (Stat *)findOrCreateStat:(NSManagedObjectContext *)moc;


@end



